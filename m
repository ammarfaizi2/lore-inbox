Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTEJDY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 23:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTEJDY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 23:24:26 -0400
Received: from tomts15-srv.bellnexxia.net ([209.226.175.3]:12730 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263637AbTEJDYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 23:24:23 -0400
Subject: Can't find CDR device in -mm only
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, axboe@suse.de
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1052537820.2441.113.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 May 2003 23:37:01 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The problem first appeared in 2.5.68-mm3 and is not in mainline 2.5.69.
It is present in all -mm releases since.

I have an IDE LG CDRW burner that has always worked fine both with
ide-scsi in 2.4 and without in 2.5. As can be seen in the inquiry out
put below the cdr device is not detected correctly by the -mm kernels.
It seems likely to be a kernel bug but I can't be certain.

Here is the inquiry output from cdrecord 2.0 from 2.5.69-mm3 which is
not working and 2.5.68-mm2 which is. I have straces of this too if that
would be useful. Same config was used for all kernels.

scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
scg__open(/dev/hdc) -2,-2,-2
Warning: Open by 'devname' is unintentional and not supported.
l1: 0x0 l2: 0x10
Bus: 0 Target: 0 Lun: 0 Chan: 0 Ino: 0
Linux sg driver version: 3.5.27
l1: 0x0 l2: 0x3
Bus: 0 Target: 0 Lun: 0 Chan: 0 Ino: 0
Target (0,0,0): DMA max 129024 old max: 64512
SCSI buffer size: 64512
Target (0,0,0): DMA max 129024 old max: 64512
scgo_getbuf: 64512 bytes
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
dev: '/dev/hdc' speed: -1 fs: 4194304 driveropts '(NULL POINTER)'
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.7'
atapi: 1
Device type    : Disk
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'ADAPTEC '
Identifikation : 'ACB-5500        '
Revision       : 'FAKE'
Device seems to be: Adaptec 5500.

scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
scg__open(/dev/hdc) -2,-2,-2
Warning: Open by 'devname' is unintentional and not supported.
l1: 0x0 l2: 0x10
Bus: 0 Target: 0 Lun: 0 Chan: 0 Ino: 0
Linux sg driver version: 3.5.27
l1: 0x0 l2: 0x3
Bus: 0 Target: 0 Lun: 0 Chan: 0 Ino: 0
Target (0,0,0): DMA max 129024 old max: 64512
SCSI buffer size: 64512
Target (0,0,0): DMA max 129024 old max: 64512
scgo_getbuf: 64512 bytes
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
ioctl ret: 0
host_status: 00 driver_status: 00
dev: '/dev/hdc' speed: -1 fs: 4194304 driveropts '(NULL POINTER)'
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.7'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'LG      '
Identifikation : 'CD-RW CED-8120B '
Revision       : '1.03'
Device seems to be: Generic mmc CD-RW.

Regards,

Shane

