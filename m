Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267859AbUHPSqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267859AbUHPSqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267871AbUHPSqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:46:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63983 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267859AbUHPSpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:45:23 -0400
Date: Mon, 16 Aug 2004 20:43:06 +0200 (MEST)
Message-Id: <200408161843.i7GIh68m009609@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: lef@freil.com, linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 09:23:40 -0400, Lawrence E. Freil wrote:
>Iteresting idea, here is the /proc/mtrr output:
>
>reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
>reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
>reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
>reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
>reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
>reg05: base=0x3e000000 ( 992MB), size=  16MB: write-back, count=1
>reg06: base=0xf0000000 (3840MB), size=   2MB: write-combining, count=1
>
>The memory in question is the block from 896 to 1Gig.  Looks pretty
>normal.

How does the E820 memory map look? (At the top of the dmesg log.)

Your BIOS left the [1008MB,1024MB[ range uncached. Try booting
with "mem=1008M". If that fixes the performance problem,
complain to your mainboard vendor that their BIOS is broken.

/Mikael
