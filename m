Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTIEQq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTIEQq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:46:56 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:21460 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265128AbTIEQqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:46:55 -0400
Date: Fri, 5 Sep 2003 12:43:47 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Henning Schmiedehausen <hps@intermeta.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
In-Reply-To: <1062776157.20632.1697.camel@forge.intermeta.de>
Message-ID: <Pine.GSO.4.33.0309051231110.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Sep 2003, Henning Schmiedehausen wrote:
>225kpps * 64 Bytes (minimum packet len) = 13,7 MBytes / sec
>
>100 MBit / 8 bit = 12,5 MBytes / sec
>
>So, IMHO even with a small packet saturated 100 MBit link you won't
>reach 225kpps. AFAIK this was Ciscos intention to publish this number.
>It basically says "you will have filled your link before you fill our
>router".

64B is the minimum ETHERNET frame size.  That isn't true for PPP, HDLC,
Frame relay, ATM, etc.

>I'm pretty sure that your 37xx won't do any routing updates anymore at
>this point. And if you do _anything_ that forces the packets down the
>slow path from the routing engine, you're toast anyway.

Sure it can.  Yeah, it'll be slow_er_, but not stopped.  CEF/PXF doesn't
require much CPU to switch a packet.

At process switching, the router is rated to a few K pps.  Process switching
SUCKS.

I've seen a 7206/200 _attempt_ to move 150kpps @ 64B each. (misbehaving
software and a misconfigured firewall...) The router was chuggin' right
along -- discarding UDP traffic like a mad man.  From the console, it was
working fine. *grin* It's rather hard for telnet to compete (and even
harder for ssh.)

All those machines are behind a 7401 now.  And it doesn't even blink at
such things.  (That thing's worth every penny we paid for it.)

--Ricky


