Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSBMWdX>; Wed, 13 Feb 2002 17:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSBMWdN>; Wed, 13 Feb 2002 17:33:13 -0500
Received: from dwcs.net ([209.142.196.187]:32898 "EHLO dwcs.net")
	by vger.kernel.org with ESMTP id <S289018AbSBMWdG>;
	Wed, 13 Feb 2002 17:33:06 -0500
Date: Wed, 13 Feb 2002 17:32:35 -0500 (EST)
From: bob@dwcs.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.x ALI IDE strangeness
Message-ID: <Pine.LNX.4.40.0202131655290.3878-100000@dwcs.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using any 2.4.x kernel, including the very latest one, with my
Fujitsu Lifebook P which uses the ALI  M5229 IDE controller it acts much
different than when using any 2.2.x  kernels that I have tried.  When
using the latest 2.2 kernels and not including specific support for the
ALI controller the kernel detects the controller and lets me use DMA.
When compiling in ALI IDE support in either 2.2 or 2.4 kernels the system
hangs when the controller is detected.
That isn't really much of a problem in the 2.2 kernels because I can just
use the generic IDE support.  In the 2.4 kernel series though, I can't
enable DMA.  When booting with a 2.4 kernel I get this:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using
pci=biosirq.
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device:  DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)

Then hdparm absolutely will not let me enable DMA giving me this error:

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


Changing the PNP OS value in the BIOS to either Yes or No does absolutely
nothing and using "pci=biosirq" just makes the part that says "Please try
using pci=biosirq." go away.

However, on accident I discovered if I boot with a 2.2 kernel, reset the
computer instead of powering off, then boot with a 2.4 kernel it will let
me enable DMA.

Is there anything I could try to make DMA work with the 2.4 series?

