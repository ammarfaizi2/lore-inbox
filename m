Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135594AbRD1SiG>; Sat, 28 Apr 2001 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135595AbRD1Shz>; Sat, 28 Apr 2001 14:37:55 -0400
Received: from cc265407-a.hwrd1.md.home.com ([24.3.45.174]:7040 "EHLO
	athens.nanticoke.ellicott-city.md.us") by vger.kernel.org with ESMTP
	id <S135594AbRD1Shv>; Sat, 28 Apr 2001 14:37:51 -0400
Date: Sat, 28 Apr 2001 14:37:50 -0400
From: Tim Meushaw <meushaw@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: CD-RW ide-scsi problem presists with 2.4.4 (was Re: Problem with 2.4.1/2.4.3 and CD-RW ide-scsi drive)
Message-ID: <20010428143750.A689@pobox.com>
In-Reply-To: <20010411225356.A574@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010411225356.A574@pobox.com>; from meushaw@pobox.com on Wed, Apr 11, 2001 at 10:53:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had received info that this may have been fixed in 2.4.3-ac5.  I
didn't get the chance to test it there, but I installed 2.4.4 this
morning.  Alas, I receive exactly the same errors with 2.4.4 as I did
previously with 2.4.3.

One thing that did differ, though, shortly after I sent this first
email, magically the drive started working properly.  I was able to
mount disks perfectly.  However, I had to reboot for some reason or
another, and the problem came back and has stayed with me ever since.
As far as I know I didn't do anything to make it work when it did, it
just "started working", which isn't an answer I like, but that's all I
can say.... :-)

Tim

On Wed, Apr 11, 2001 at 10:53:57PM -0400, Tim Meushaw wrote:
> Hi there.  I just got a new CD-RW drive and am trying to get it working
> under Linux.  I've got the ide-scsi modules all loaded, but have weird
> errors when trying to mount a disk.
> 
> Here are the messages from "dmesg" that I get when the ide-cd and
> ide-scsi modules are loaded.  My DVD-ROM is /dev/hdc, and the CD-RW is
> /dev/hdd (or /dev/sr0):
> 
> -----------------------------------------------------
> hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> ide-cd: ignoring drive hdd
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: SONY      Model: CD-RW  CRX160E    Rev: 1.0e
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> -----------------------------------------------------
> 
> So, it looks like the drive is attached to /dev/sr0 properly.  Then, I
> run "cdrecord -scanbus" to make sure:
> 
> -----------------------------------------------------
> Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
> Linux sg driver version: 3.1.17
> Using libscg version 'schily-0.1'
> scsibus0:
>         0,0,0     0) 'SONY    ' 'CD-RW  CRX160E  ' '1.0e' Removable CD-ROM
> -----------------------------------------------------
> 
> So, it REALLY looks like it's working.  However, here's what I get when
> I try to mount an ordinary data CD:
> 
> -----------------------------------------------------
> athens:~# mount -t iso9660 /dev/sr0 /cdrw
> mount: block device /dev/sr0 is write-protected, mounting read-only
> SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
> [valid=0] Info fld=0x0, Current sd0b:00: sense key Hardware Error
> Additional sense indicates Logical unit communication CRC error (Ultra-DMA/32)
>  I/O error: dev 0b:00, sector 64
> isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=32
> mount: wrong fs type, bad option, bad superblock on /dev/sr0,
>        or too many mounted file systems
> -----------------------------------------------------
> 
> I've tried this with both kernel 2.4.1 and 2.4.3 and have the exact same
> error.  I've also tried multiple data CDs and have the same messages.
> The CD-RW is a Sony CRX-160E, plugged in to an Asus A7V motherboard (the
> PCI bus is described by "lspci" as "VIA Technologies, Inc. VT8363/8365
> [KT133/KM133 AGP]").  I'm not sure what other information I can provide,
> but I'll be happy to give anything else that might be needed to help fix
> this problem.
> 
> Thanks a lot!
> Tim
> 
> -- 
> Timothy A. Meushaw
> meushaw@pobox.com
> http://www.pobox.com/~meushaw/



-- 
Timothy A. Meushaw
meushaw@pobox.com
http://www.pobox.com/~meushaw/
