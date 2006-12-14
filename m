Return-Path: <linux-kernel-owner+w=401wt.eu-S1751878AbWLNAi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWLNAi0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWLNAiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:38:25 -0500
Received: from peacekeeper.artselect.com ([69.18.47.2]:54512 "EHLO
	wyeth.artselect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbWLNAiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:38:24 -0500
X-Greylist: delayed 1535 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 19:38:24 EST
Date: Wed, 13 Dec 2006 18:12:47 -0600
To: Dieter Ferdinand <dieter.ferdinand@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: server don't accept ip-connections from linux
Message-ID: <20061214001247.GA26676@artselect.com>
References: <457FD55E.13765.202391D@dieter.ferdinand.gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457FD55E.13765.202391D@dieter.ferdinand.gmx.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Pete Harlan <harlan@artselect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 10:26:38AM +0000, Dieter Ferdinand wrote:
> i don't know, what is the difference of the tcp-packets from windows/kernel 
> 2.2 and linux with kernel 2.4. but with kernel 2.4 i have trouble with some 
> servers.
> 
> i check the packets with an analyser and make some test. if i disable ecn 
> with "echo 0x0 > /proc/sys/net/ipv4/tcp_ecn" it works, with ecn enabled, it 
> don't work.

With kernel 2.6.17.13 or higher, you can limit the scaling factor for
that broken host with:

	THEIR_IP=1.2.3.4
	MY_GATEWAY=5.6.7.8

	ip route add $THEIR_IP/32 via $MY_GATEWAY window 65535

which limits window scaling for that destination without interfering
with your other connections.

--Pete
