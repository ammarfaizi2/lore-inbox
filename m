Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267253AbUHOXnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267253AbUHOXnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUHOXnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:43:05 -0400
Received: from smtp.virgilio.it ([212.216.176.142]:25510 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S267253AbUHOXmo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:42:44 -0400
Subject: PROBLEM: cdrecord as normal user broken with kernel 2.6.8.1
From: GhePeU <ghepeu@libero.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1092613363.1244.3.camel@KazeNoTani>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 01:42:43 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As in Object: this has been reported by many user I know, with different
chipsets and different IDE cd-burners. Bug wasn't in 2.6.8 rc4.

cdrecord output with kernel 2.6.7 and kernel 2.6.8.1 as root:

# cdrecord dev=/dev/hdc -checkdrive 
Cdrecord-Clone 2.01a36 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
cdrecord: Warning: Running on Linux-2.6.8
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'LITE-ON '
Identifikation : 'LTR-52327S      '
Revision       : 'QS0C'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE FORCESPEED
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R

cdrecord output with kernel 2.6.8.1 as normal user:

$ cdrecord dev=/dev/hdc -checkdrive 
Cdrecord-Clone 2.01a36 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
cdrecord: Warning: Running on Linux-2.6.8
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'LITE-ON '
Identifikation : 'LTR-52327S      '
Revision       : 'QS0C'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE FORCESPEED
Supported modes:

Please note that no supported modes are found. There are many other
errors reported with cdrecord -atip or when trying a c2 errors scan with
readcd:

cdrecord: Operation not permitted. prevent/allow medium removal: scsi
sendcmd: no error 
CDB:  1E 00 00 00 01 00 
status: 0x0 (GOOD STATUS) 
cmd finished after 0.000s timeout 40s


The same happens with CyberDrv CW088D CD-R/RW and PLEXTOR CD-R W4012A,
between the others.

