Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289288AbSBJEnV>; Sat, 9 Feb 2002 23:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289293AbSBJEnN>; Sat, 9 Feb 2002 23:43:13 -0500
Received: from iggy.triode.net.au ([203.63.235.1]:10967 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S289288AbSBJEm4>; Sat, 9 Feb 2002 23:42:56 -0500
Date: Sun, 10 Feb 2002 15:42:09 +1100
From: Linux Kernel Mailing List <kernel@iggy.triode.net.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALI 15X3 DMA Freeze
Message-ID: <20020210154209.A15150@iggy.triode.net.au>
In-Reply-To: <20020210124207.C5191@iggy.triode.net.au> <E16Zjlb-0000Bh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16Zjlb-0000Bh-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 10, 2002 at 02:30:59AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've picked up ide.2.4.17.02072002.patch from www.linux-ide.org
and compiled it with 2.4.17. I presume that this was the patch
you were referring to?

With Andre's IDE patch and 2.4.17, my machine locked up when 
compiling 2.4.17 with both the DMA on and the DMA off.

With patch-2.4.18-pre9, the machine only locked up when
DMA was set on, with DMA off, I could recompile the kernel
as many times as I wanted. 

Following are kernel messages from the kernel boot with
Andre's IDE patch.

Feb 10 15:25:10 solaris kernel: Calibrating delay loop... 3158.83 BogoMIPS
Feb 10 15:25:10 solaris kernel: PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Feb 10 15:25:10 solaris kernel: ALI15X3: IDE controller on PCI bus 00 dev 20
Feb 10 15:25:10 solaris kernel: ALI15X3: chipset revision 196
Feb 10 15:25:10 solaris kernel: ALI15X3: not 100%% native mode: will probe irqs later
Feb 10 15:25:10 solaris kernel: ALI15X3: ATA-66/100 forced bit set (WARNING)!!
Feb 10 15:25:10 solaris kernel: ALI15X3: simplex device:  DMA disabled
Feb 10 15:25:10 solaris kernel: ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
Feb 10 15:25:10 solaris kernel: ALI15X3: simplex device:  DMA disabled
Feb 10 15:25:10 solaris kernel: ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
Feb 10 15:25:11 solaris random: Initializing random number generator:  succeeded

Feb 10 15:25:10 solaris kernel: ide_setup: ide0=ata66
Feb 10 15:25:10 solaris kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Feb 10 15:25:10 solaris kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 10 15:25:10 solaris kernel: ALI15X3: IDE controller on PCI bus 00 dev 20
Feb 10 15:25:10 solaris kernel: ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
Feb 10 15:25:10 solaris kernel: ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
Feb 10 15:25:10 solaris kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 10 15:25:10 solaris kernel: ide1 at 0x170-0x177,0x376 on irq 15

Please let me know what to try to test next.

Regards.  Paul



On Sun, Feb 10, 2002 at 02:30:59AM +0000, Alan Cox wrote:
> > I'm using kernel 2.4.18-pre9, which has a problem when I switch DMA on 
> > the IDE hard drive. With DMA enabled, I cannot complete a kernel
> > compile without the machine locking up. The motherboard is an
> 
> Start by picking up the ide updates either from the -ac kernel or from
> Andre's web site. 

