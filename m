Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSCRVxG>; Mon, 18 Mar 2002 16:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293075AbSCRVw5>; Mon, 18 Mar 2002 16:52:57 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:423 "EHLO sbcs.cs.sunysb.edu")
	by vger.kernel.org with ESMTP id <S293048AbSCRVwm>;
	Mon, 18 Mar 2002 16:52:42 -0500
Date: Mon, 18 Mar 2002 16:49:13 -0500 (EST)
From: <prade@cs.sunysb.edu>
X-X-Sender: <prade@compserv3>
To: Hari Gadi <HGadi@ecutel.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Trapping all Incoming Network Packets
In-Reply-To: <AF2378CBE7016247BC0FD5261F1EEB210B6A8F@EXCHANGE01.domain.ecutel.com>
Message-ID: <Pine.GSO.4.33.0203181646170.5841-100000@compserv3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Hari Gadi wrote:

> Hi,
> Is it possible to change the packet (add an extra ip header)
> and send it back to network bypassing the routing functionality.
> I want to do my own routing.( I add the hardware address of the destination machine)

In IP-IP encapsualtion, after adding the outer IP header, the ip_send
function is invoked. Instead for your purpose you can have your own
function and write your routing table lookup. You can check the
net/ipv4/ipip.c code

--pradipta

