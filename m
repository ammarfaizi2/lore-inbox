Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbQKHRcT>; Wed, 8 Nov 2000 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129190AbQKHRcJ>; Wed, 8 Nov 2000 12:32:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129159AbQKHRb4>; Wed, 8 Nov 2000 12:31:56 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Pentium 4 and 2.4/2.5
Date: 8 Nov 2000 09:31:24 -0800
Organization: Transmeta Corporation
Message-ID: <8uc2lc$g4t$1@penguin.transmeta.com>
In-Reply-To: <OE59dY2pjID9Lv40q2H00001e2c@hotmail.com> <E13tGbg-0007oC-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E13tGbg-0007oC-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>rep;nop is a magic instruction on the PIV and possibly some PIII series CPUs
>[not sure]. As far as I can make out it naps momentarily or until bus
>activity thus saving power on spinlocks.

>From what I've heard, the reason Intel _really_ wants "rep nop" is that
without it the CPU will heat up quite efficiently (that's what you do
when you want to run at an eventual 2GHz with all cylinders firing all
the time), causing thermal meltdown on non-thermally protected CPU's and
CPU speed throttling on the ones that _are_ thermally protected (which
will obviously have to be all the shipping ones). 

And the thermal throttling will severly cripple performance.

>The problem is 'rep nop' is not defined on other cpus so we can only really use
>it on the PIII/PIV kernel builds

Intel retroactively defined it for all their CPU's. And I very strongly
suspect that every single other x86 CPU vendor does the same. Why not?
They get a new instruction for free, but just documenting it. Maybe they
can sell the same old chip with a new name ("The Xxxxx Wonderchip. Now
with documetned 'rep nop' support! Get one today!").

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
