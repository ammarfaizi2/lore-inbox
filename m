Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272447AbTHIRCi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272454AbTHIRCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:02:37 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:20195 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S272447AbTHIRCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:02:35 -0400
Date: Sat, 9 Aug 2003 10:11:32 -0700
From: John Wendel <jwendel10@comcast.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS Corruption with VIA MVP3 + UDMA/DMA
Message-Id: <20030809101132.446c6cc3.jwendel10@comcast.net>
In-Reply-To: <20030809155708.GA3606@hh.idb.hist.no>
References: <16128.19218.139117.293393@charged.uio.no>
	<3F007EBF.9020506@sbcglobal.net>
	<3F10729F.7070701@sbcglobal.net>
	<3F34E6D1.7030900@sbcglobal.net>
	<1060439826.4938.88.camel@dhcp22.swansea.linux.org.uk>
	<20030809155708.GA3606@hh.idb.hist.no>
Organization: WizardControl
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 17:57:08 +0200
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> I have a pc with a VIA MVP3, that I use as an x-terminal.
> Using dma is not an option, I got the impression that ide
> developers consider the chip so broken they don't want to
> try make that work. That is ok with me, I wouldn't consider
> running anything needing good io performance on that old thing.
> 
> What is worse is that 2.6 ide don't work with it at all.
> Booting attempts die early of io errors, sometimes it don't
> even find the root fs superblock, other times dies a little later.
> So it is sort of left behind, running 2.5.69-mm3 which at least works
> in pio mode. The harddisk is a old 240MB thing with debian
> shoehorned onto it.
> 
> There is no AGP card in the machine, so AGP is clearly not necessary
> to get io trouble.
> 
> Here's the lspci output, if anyone is interested:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3]
> (rev 04) 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x
> [Apollo MVP3/Pro133x AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
> [Apollo VP] (rev 41)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC
> Bus Master IDE (rev 06)
> 00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
> 00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
> [Cyclone] (rev 64)
> 00:0b.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
> 
> Helge Hafting

Just another data point, for what it's worth.

I've got one of these puppies that works perfectly except I cannot
enable DMA on the CD-RW drive. I normally run a vanilla 2.4.19 kernel,
but it also works fine with the RedHat 8.0 kernel (whatever that is?). I
only have one hard disk at the moment (80GB WD) but before the old one
died, I routinely copied 800 MB files (video) between disks with no
errors. The CD burner works fine at 16X. I'm running an AMD K6-III 350
with a 25 Mhz overclock, rock solid. The MB is a FIC VIA 503+.

A normal load on the machine is a continuous 200KB/sec download on the
cable modem using PAN, XMMS, Firebird, and Sylpheed. XMMS skips are very
rare! Mplayer works great with a few dropped frames on really high res
DIVX video.

So I don't think you can point the finger at the MVP3 chipset.

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 41)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
IDE (rev 06)
00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1
Audio Controller] (rev 03)
00:0a.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet
10/100 model NC100 (rev 11)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee
(rev 03)

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 9729/255/63, sectors = 156301488, start = 0

I'll be happy to supply any info that can help anyone. I know this
problem has been bugging people for a long time.

--

John
