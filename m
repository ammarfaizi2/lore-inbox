Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267080AbSLKJA5>; Wed, 11 Dec 2002 04:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbSLKJA5>; Wed, 11 Dec 2002 04:00:57 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:60876 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S267080AbSLKJA4>; Wed, 11 Dec 2002 04:00:56 -0500
Date: Wed, 11 Dec 2002 10:08:39 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1
Message-ID: <20021211090829.GD8741@charite.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo@conectiva.com.br>:
 
> So here goes the first pre of 2.4.21 including the new IDE code merged
> from Alan's tree.
> 
> Test it carefully, since the new IDE code is not yet fully tested.

And, alas, I do have problems with exactly that code. Background:

I've been trying the -ac kernels for quite some time now, but on my
new Toshiba Satellite Pro 6100 they all fail miserably.

I made three screenshots which illuminate the problem:
http://www.stahl.bau.tu-bs.de/~hildeb/kernel/

* 2.4.20/2.4.19/2.4.20-ck1 all boot OK, the old IDE code detects my drives.
* 2.4.19-acX, 2.4.20-ac1 or 2.4.21-pre1 boot, but then fail to detect my drives.

My /etc/lilo.conf contains as addiditonal boot parameters only:

append="hdc=ide-scsi max_scsi_luns=1 video=vesa:ywrap,mtrr"

lspci reports:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go] (rev a3)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller (rev 42)
02:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
02:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
02:0d.0 System peripheral: Toshiba America Info Systems: Unknown device 0805 (rev 03)

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
"Looking at the proliferation of personal web pages on the net, it
looks like very soon everyone on earth will have 15 Megabytes of fame." 
 -MG Siriam

