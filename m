Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWH0Teo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWH0Teo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 15:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWH0Teo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 15:34:44 -0400
Received: from compunauta.com ([69.36.170.169]:9184 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S932256AbWH0Teo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 15:34:44 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't enable DMA over ATA on Intel Chipset 2.6.16
Date: Sun, 27 Aug 2006 14:34:35 -0500
User-Agent: KMail/1.9.1
References: <200608271239.32507.gustavo@compunauta.com> <200608271316.22992.gustavo@compunauta.com> <44F1E42B.2010601@garzik.org>
In-Reply-To: <44F1E42B.2010601@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608271434.35840.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Domingo, 27 de Agosto de 2006 13:27, escribió:
> Gustavo Guillermo Pérez wrote:
> > El Domingo, 27 de Agosto de 2006 12:57, escribió:
> >> Gustavo Guillermo Pérez wrote:
> >>> Hello list, I can't enable DMA on this chipset, even forcing with the
> >>> options provided in kconfig.
> >>
> >> Google around for combined mode, and/or set your BIOS to something other
> >> than legacy IDE mode.
> >
> > already tryed with BIOS legacy
>
> Right, that is the problem.
forgot to said "off"
BIOS has Enhaced or Combined mode, but no one of this options helps.
Disabling SATA, and using a normal ATAPI Hard Drive, let me use DMA for Atapi 
Devices and works.

But I see this problem on a newest sony vaio laptop too, having the same 
chipset, on this one there is no option for sata, cause there is no sata...

00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Express Memory 
Controller Hub (rev 04)
00:02.0 Display controller: Intel Corporation 82915G/GV/910GL Express Chipset 
Family Graphics Controller (rev 04)
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
High Definition Audio Controller (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d4)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface 
Bridge (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
IDE Controller (rev 04)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
Controller (rev 04)
01:00.0 Multimedia video controller: Internext Compression Inc iTVC16 
(CX23416) MPEG-2 Encoder (rev 01)
01:01.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 
AGP 8x] (rev c1)
01:02.0 Communication controller: Agere Systems V.92 56K WinModem (rev 03)
01:08.0 Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ - PRO/100 VE 
(LOM) Ethernet Controller (rev 04)
01:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
(rev 80)
root@rp-1 /home/gus # hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 16383/255/63, sectors = 156368016, start = 0

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
