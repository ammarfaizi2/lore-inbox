Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKQUov>; Fri, 17 Nov 2000 15:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKQUon>; Fri, 17 Nov 2000 15:44:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4100 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129187AbQKQUoY>; Fri, 17 Nov 2000 15:44:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VGA PCI IO port reservations
Date: 17 Nov 2000 12:13:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v43i1$sjs$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1001117125211.20635A-100000@chaos.analogic.com> <200011171953.TAA01877@raistlin.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011171953.TAA01877@raistlin.arm.linux.org.uk>
By author:    Russell King <rmk@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
>
> Richard B. Johnson writes:
> > The code necessary to find the lowest unaliased address looks like
> > this:
> 
> Any chance of providing something more readable?  I may be able to read
> some x86 asm, but I don't have the time to try to decode that lot.
> 

Ignore this code.  It's bullshit -- you can't just go and poke random
boards -- even with IN's -- indiscriminately.  As usual, Richard is
writing long lectures on subjects he is seriously mistaken about (and
probably will send me yet another email trying to browbeat me into not
calling him on all his errors.)

The standard algorithm, documented in many places, is the one I gave
before:

	(port >= 0x1000 && (port & 0x0300) == 0)

Allocating ports in any other ranges is unsafe.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
