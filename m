Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLBF0y>; Sat, 2 Dec 2000 00:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129476AbQLBF0o>; Sat, 2 Dec 2000 00:26:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129464AbQLBF0j>; Sat, 2 Dec 2000 00:26:39 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3
Date: 1 Dec 2000 20:55:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <909vcs$3oo$1@cesium.transmeta.com>
In-Reply-To: <200012020409.UAA04058@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200012020409.UAA04058@adam.yggdrasil.com>
By author:    "Adam J. Richter" <adam@yggdrasil.com>
In newsgroup: linux.dev.kernel
> 
> 	Well, alas, it appears that linux-2.4.0-test12-pre3 freezes hard
> while reading the base address registers of the first PCI device
> (the "host bridge").  Actually, I think the problem is some kind of
> system management interrupt occuring at about this time, since the
> exact point where the printk's stop gets earlier as I add more
> printk's.  With few printk's the printk's stop while the 6th base
> address configuration register is being read; with more printk's it
> stops at the second one, and it will stop in different places with
> different boots, at least with the not-quite-stock kernels that I usually
> use.  Also, turning off interrupts during this code has no effect, so
> I do not think it is directly caused by the something in the PictureBook
> pepperring the processor with unexpected interrupts (I thought it might have
> to do with the USB-based floppy disk).
> 

It's a slight bug in the Linux PCI probing code that triggers when
there is ongoing DMA activity during PCI probing.  Linus already have
a fix for it; I expect that it will be in the next prepatch.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
