Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbTCTQvF>; Thu, 20 Mar 2003 11:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbTCTQvF>; Thu, 20 Mar 2003 11:51:05 -0500
Received: from mega.ist.utl.pt ([193.136.128.20]:59584 "EHLO mega.ist.utl.pt")
	by vger.kernel.org with ESMTP id <S261341AbTCTQvD>;
	Thu, 20 Mar 2003 11:51:03 -0500
Date: Thu, 20 Mar 2003 17:01:20 +0000 (WET)
From: Ricardo <rjpp@mega.ist.utl.pt>
X-X-Sender: rjpp@mega
To: linux-kernel@vger.kernel.org
Subject: socket() datalink bug
Message-ID: <Pine.GSO.4.44.0303201640410.4714-100000@mega>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was found while experimenting with a sniffer, so I have IFF_PROMISC
set when doing the recv(). And my kernel is a 2.4.19-gentoo-r9, but a
normal 2.4.18 from slackware 8.1 has the same behavior.

socket(PF_PACKET,SOCK_RAW,htons(ETH_P_IP));

Does not return a copy of the packets send by the computer you are on. It
returns the IP traffic that other people send normally. So the sniffer
can't see packets from the computer it is running on. This shouldn't be so
as htons(ETH_P_IP) should only be a filter that would return IP only
packets.

socket(PF_PACKET,SOCK_RAW,htons(ETH_P_ALL));

Works just fine, so I think the filter is excluding too much.
Or isn't it a bug?

Please Cc it to me as I haven't subscribed the mailing list.

