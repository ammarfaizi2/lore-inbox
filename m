Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTGCPt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTGCPt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:49:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264610AbTGCPsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:48:17 -0400
Date: Thu, 3 Jul 2003 09:05:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org, Wiktor Wodecki <wodecki@gmx.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030703151529.B20336@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307030857240.14925-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Russell, 

> If anyone else is having similar problems, they need to report them so
> we can obtain more data points - I suspect some other change in some other
> subsystem broke PCMCIA for Wiktor.

I have a T20 and a NE2k network card and have been experiencing a similar 
hang when I start cardmgr. I did some playing around with it and found 
some inconsistencies. 

At first, I had it in Slot 1, and it hung when probing the first range of 
addresses. I moved it to Slot 0, and it was able to probe and bring the 
interface up (though it did complain heavily about dropping packets). 

After a few reboots, it started hanging during the address probe (in Slot 
0). I tried disabling various memory regions to probe in 
/etc/pcmcia/config.opts, and had luck initially, but it now has decided to 
not work at all. 

I also have a Cisco/Aironet 340 802.11b card that is having problems. When 
in Slot 0, cardmgr can idenitfy the card, and the driver initalizes the 
card properly, but I cannot obtain an IP address (but does not hang). In 
Slot 1, the system hangs while trying to obtain an IP address. 

Any ideas?



	-pat

