Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbUBCRqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUBCRqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:46:16 -0500
Received: from aurora.fi.muni.cz ([147.251.50.200]:57509 "EHLO
	aurora.fi.muni.cz") by vger.kernel.org with ESMTP id S266024AbUBCRqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:46:10 -0500
Date: Tue, 3 Feb 2004 18:46:06 +0100
From: Martin =?iso-8859-2?Q?Povoln=FD?= <xpovolny@aurora.fi.muni.cz>
To: John Bradford <john@grabjohn.com>
Cc: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040203174606.GG3967@aurora.fi.muni.cz>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos> <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk> <yw1xsmhsf882.fsf@kth.se> <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne: Tue, Feb 03, 2004 at 04:35:19PM +0000, John Bradford napsal:
> Quote from mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=):
> > John Bradford <john@grabjohn.com> writes:
> > 
> > >> That's not what he said and, I assure you that if he unmounted
> > >> it there would not be any buffers to flush. Execute `man umount`.
> > >
> > > I think the original poster was referring to the cache on the device.

I don't know what cache, I don't understand it :-(

> > >
> > > I.E.
> > >
> > > mount disc
> > > view contents
> > > unmount disc
> > > erase disc - but don't erase the CD-R drive's cache of the media
> > > mount disc
> > > view old contents of the media from the CD-R drive's cache

That's it exactly.

> > 
> > If that's the case, the drive is broken.  We can't help that.

That's possible, it's a cheap combo from LG. I have even seen it on the
list of droken drives (the ones that died trying to install mandrake)
[http://archives.mandrakelinux.com/expert/2003-10/msg02116.php], even
though it's a CDRW.

It that case sorry for bothering you with crappy hw problem.

> 
> Is it actually a requirement for drives to support anything other than
> a full erase properly?  Is the 'fast' erase valid per spec, or does it
> just happen to work on 99% of devices?  Is this problem reproducable
> if a full erase is done instead of a fast erase?

Yes, it is:

$ cdrecord dev=/dev/hdc -blank=all -v
Cdrecord-Clone 2.01a19 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
SCSI buffer size: 64512
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'HL-DT-ST'
Identifikation : 'RW/DVD GCC-4480B'
Revision       : '1.00'
Device seems to be: Generic mmc2 DVD-ROM.
Current: 0x000A
Profile: 0x000A (current)
Profile: 0x0009
Profile: 0x0008
Profile: 0x0002 (current)
Profile: 0x0010
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-2 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1591744 = 1554 KB
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 2
  Reference speed: 6
  Is not unrestricted
  Is erasable
  Disk sub type: High speed Rewritable (CAV) media (1)
  ATIP start of lead in:  -11077 (97:34/23)
  ATIP start of lead out: 359849 (79:59/74)
  1T speed low:  4 1T speed high: 10
  2T speed low:  2 2T speed high: 10
  power mult factor: 2 6
  recommended erase/write power: 5
  A1 values: 24 2C DC
  A2 values: 14 A4 4A
Disk type:    Phase change
Manuf. index: 11
Manufacturer: Mitsubishi Chemical Corporation
Starting to write CD/DVD at speed 10 in real BLANK mode for single session.
Last chance to quit, starting real write    0 seconds. Operation starts.
Performing OPC...
Blanking entire disk
Blanking time:  514.223s
pie:martin:~
$ mount /cdrom
pie:martin:~
$ ls -l /cdrom/
celkem 64
dr-xr-xr-x    2 root     root        36864 2004-02-03 18:00 Beskydy2003-2004
dr-xr-xr-x    2 root     root         4096 2004-02-03 18:00 Cukl-Leden2004
dr-xr-xr-x    2 root     root         4096 2004-02-03 18:00 unsorted
dr-xr-xr-x    2 root     root        20480 2004-02-03 18:00 Vanoce2003

pie:martin:~
$ eject /cdrom/; eject -t /cdrom/
pie:martin:~
$ LC_ALL=C mount /cdrom/
/dev/cdrom: Input/output error
mount: I could not determine the filesystem type, and none was specified

Could it be also cdrecord problem? Couldn't cdrecord execute some command
to flush the cdrom's cache after erasing?

Thank you all for your interest.

-- 
Martin Povolný, xpovolny@fi.muni.cz, http://www.fi.muni.cz/~xpovolny
