Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUBMRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267004AbUBMRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:44:25 -0500
Received: from users.linvision.com ([62.58.92.114]:28806 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S266784AbUBMRoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:44:22 -0500
Date: Fri, 13 Feb 2004 18:44:18 +0100
From: Erik Mouw <erik@harddisk-recovery.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Message-ID: <20040213174418.GA31694@bitwizard.nl>
References: <200402122106.41947.bzolnier@elka.pw.edu.pl> <20040213083718.GA11914@alpha.home.local> <200402131823.53939.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402131823.53939.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 06:23:53PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Great, but I wonder why cable bits are set incorrectly.
> Probably it's a BIOS bug, maybe BIOS update will help?

I think there is something wrong in the cable detection code. I've
tried chasing the bug a couple of weeks ago, but got distracted by
other work. On an AMD-768 based motherboard disks run in UDMA5 without
problem using linux-2.4.20, but on 2.4.24 (or anything with the new IDE
code), I can't get any further than UDMA2. At first glance it looks
like the 80-pin bits in the chipset registers aren't set. When I
manually force them, the driver has no problem running the disks in
UDMA5.

So far I've seen this behaviour with the following chipset:

  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].

But rumours are that even on Intel ICH2 it goes wrong (haven't
confirmed this myself).

FWIW, I'm using modular IDE, I still have to test it with IDE built
into the kernel.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Eigen lab: Delftechpark 26, 2628 XH, Delft, Nederland
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
