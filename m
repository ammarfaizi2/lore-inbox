Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbTL3LIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbTL3LIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:08:06 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:21011 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S265751AbTL3LID convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:08:03 -0500
Date: Tue, 30 Dec 2003 12:08:00 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-mm2 error: cdrecord dev=ATAPI:0,0,0 driveropts=help -checkdrive
Message-ID: <20031230110800.GA21367@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wanted to test ide-cd instead of ide-scsi for my SONY DVD RW DRU-500A
2.0g and I got:

cdrecord dev=ATAPI:0,0,0 driveropts=help -checkdrive
Cdrecord-Clone 2.01a20-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to <warly@mandrakesoft.com>.
Note: The author of cdrecord should not be bothered with problems in this version.
scsidev: 'ATAPI:0,0,0'
devname: 'ATAPI'
scsibus: 0 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   : 
Vendor_info    : 'SONY    '
Identifikation : 'DVD RW DRU-500A '
Revision       : '2.0g'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Driver options:
burnfree        Prepare writer to use BURN-Free technology
noburnfree      Disable using BURN-Free technology

So it seems to recognize it perfectly, I haven't tried to burn something,
but in syslog:

Dec 30 11:58:15 greg kernel: hda: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
Dec 30 11:58:16 greg kernel:  hda: hda1
Dec 30 11:58:16 greg kernel: end_request: I/O error, dev hdc, sector 0
Dec 30 11:58:16 greg modprobe: FATAL: Error running install command for block_major_33 
Dec 30 11:58:16 greg modprobe: FATAL: Error running install command for block_major_33 

In hda I have my IDE ZIP 250 Mb...

Please CC to me as I am not on this ml ;-)

	Grégoire
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
