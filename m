Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSKCQV6>; Sun, 3 Nov 2002 11:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSKCQV6>; Sun, 3 Nov 2002 11:21:58 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:1408 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262122AbSKCQV4>;
	Sun, 3 Nov 2002 11:21:56 -0500
Date: Sun, 3 Nov 2002 10:29:02 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Working ide-cd burn/rip, 2.5.44
Message-Id: <20021103102902.77ae876b.arashi@arashi.yi.org>
In-Reply-To: <20021103094229.GJ3612@suse.de>
References: <20021102184357.7091fd4d.arashi@arashi.yi.org>
	<20021103094229.GJ3612@suse.de>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002 10:42:29 +0100
Jens Axboe <axboe@suse.de> wrote:

> On Sat, Nov 02 2002, Matt Reppert wrote:
> > Just FYI. I tested the ide-cd based CD burning and reading with the
> > cdrtools alpha ... kernel 2.5.44-mm6, cdrtools-1.11a39. If I boot
> > into a clean system, only load ide-cd (none of the ide-scsi-related
> > bits), and "do it", it works well.
> 
> You definitely don't want anything _less_ than 2.5.45 at all, it's a
> miracle it appears to work :-)
> 
> Please retest 2.5.45, thanks, and you should probably add this patch to
> fix the cdb output length issue.

Hmmm ...

3-arashi:~$ uname -r
2.5.45
3-arashi:~$ /opt/schily/bin/cdrecord dev=ATAPI:0,0,0 -checkdrive
Cdrecord 1.11a39 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J�rg Schilling
scsidev: 'ATAPI:0,0,0'
devname: 'ATAPI'
scsibus: 0 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'
Device type    : Disk
Version        : 0
Response Format: 0
Vendor_info    : 'ADAPTEC '
Identifikation : 'ACB-5500        '
Revision       : 'FAKE'
Device seems to be: Adaptec 5500.
/opt/schily/bin/cdrecord: Sorry, no CD/DVD-Drive found on this target.

...

3-arashi:~$ uname -r
2.5.44-mm6
3-arashi:~$ /opt/schily/bin/cdrecord dev=ATAPI:0,0,0 -checkdrive
Cdrecord 1.11a39 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J�rg Schilling
scsidev: 'ATAPI:0,0,0'
devname: 'ATAPI'
scsibus: 0 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-R   PX-W1210A'
Revision       : '1.07'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
3-arashi:~$ 

Makes for some interesting goings-on ... I'm guessing you want more
info on what I'm running? :) Tell me what to send, I'll send it.

Matt
