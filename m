Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSBUW3v>; Thu, 21 Feb 2002 17:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBUW3k>; Thu, 21 Feb 2002 17:29:40 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:19078 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S284264AbSBUW3W>;
	Thu, 21 Feb 2002 17:29:22 -0500
Date: Thu, 21 Feb 2002 23:29:21 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202212229.XAA01930@harpo.it.uu.se>
To: stone@hkust.se
Subject: Re: Seagate IDE tape problems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 20:00:24 +0100, Magnus Stenman wrote:
>I'm having trouble with a Seagate IDE tape drive that previously
>worked with 2.2.x kernels. (tape is a STT8000A travan drive)
>
>The box has an ABIT m/b with intel 815 chipset.
>
>On 2.2 I used the ide tape modules which let me access the drive on
>ht0, but that did not work at all on 2.4.x.
>
>I'm now using scsi_mod, ide-scsi and st and it seems
>to mostly work. However, sometimes backups fail, and
>I always get a couple of error messages every backup.
>
>Linux version 2.4.9-21 (bhcompile@stripples.devel.redhat.com) (gcc
>version 2.96 20000731 (Red Hat Linux 7.1 2.\

i.e., a RH7.2 update kernel, not a standard kernel

>96-98)) #1 Thu Jan 17 14:16:30 EST 2002
>Uniform Multi-Platform E-IDE driver Revision: 6.31
>ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
>PIIX4: IDE controller on PCI bus 00 dev f9
>PIIX4: chipset revision 17
>PIIX4: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
>hda: SAMSUNG SV2042H, ATA DISK drive
>hdc: SAMSUNG SV3063H, ATA DISK drive
>hdd: Seagate STT8000A, ATAPI TAPE drive
>...
>hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete
>DataRequest CorrectedError Index Error }
>hdd: status error: error=0x7f
>hdd: DMA disabled

FWIW, I have an identical unit (STT8000A) and it has worked
perfectly for me up to 2.4.18-pre, on 440BX and 850 chipset boxes.
I don't use scsi emulation for it, just the regular ide-tape driver,
and I don't have a hard drive on the same channel (it's hdd with hdc
being a HP CD-writer).

/Mikael
