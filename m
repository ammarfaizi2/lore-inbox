Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131917AbRAOXrx>; Mon, 15 Jan 2001 18:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131914AbRAOXrn>; Mon, 15 Jan 2001 18:47:43 -0500
Received: from mail.cps.matrix.com.br ([200.196.9.5]:30474 "EHLO
	mail.cps.matrix.com.br") by vger.kernel.org with ESMTP
	id <S130463AbRAOXr2>; Mon, 15 Jan 2001 18:47:28 -0500
Date: Mon, 15 Jan 2001 21:47:11 -0200
To: linux-kernel@vger.kernel.org
Cc: Albert Cranford <ac9410@bellsouth.net>
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010115214710.C1490@godzillah>
In-Reply-To: <20010112204626.A2740@suse.cz> <E14HDqv-0005Fm-00@the-village.bc.nu> <20010114203823.A17160@pcep-jamie.cern.ch> <20010114233907.C2487@suse.cz> <3A623F1A.6335981B@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A623F1A.6335981B@bellsouth.net>; from ac9410@bellsouth.net on Mon, Jan 15, 2001 at 12:06:50AM +0000
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@debian.org (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Albert Cranford wrote:
> I have a working PA-2007 but use a small hard disk.  Can I help.
[...]
> Detected 239.833 MHz processor.
[...]
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[...]
> hda: WDC AC2540F, ATA DISK drive
> hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hda: set_drive_speed_status: error=0x04 { DriveStatusError }
> hda: 1056384 sectors (541 MB) w/64KiB Cache, CHS=524/32/63, DMA

I have a FIC PA-2007 (the older one, with a 586A bridge instead of the 586B
of later FIC PA-2007 boards), running at 75MHz FSB (PCI bus runs at 37.5MHz,
so I suppose I should use idebus=37.5 if I were to try 2.4.x), and a Quantum
Fireball lct15 30MB.

It works flawlessly in UDMA mode 2 (although I have to force the drive to
UDMA mode 2 with -X66 before enabling dma, because the bogus beta BIOS I use
sets it to UDMA4 which is not supported by the 586A). Kernel is 2.2.18,
without the 2.4.x ide backport.

The lspci output is exactly the same as yours.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
