Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTEJOeU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTEJOeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:34:19 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:18068 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264274AbTEJOeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:34:18 -0400
Subject: Re: Can't find CDR device in -mm only
From: Shane Shrybman <shrybman@sympatico.ca>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030510092041.GN812@suse.de>
References: <1052537820.2441.113.camel@mars.goatskin.org>
	 <20030510092041.GN812@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1052578016.2369.7.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 May 2003 10:46:57 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Sat, 2003-05-10 at 05:20, Jens Axboe wrote:
> On Fri, May 09 2003, Shane Shrybman wrote:
> > Hi,
> > 
> > The problem first appeared in 2.5.68-mm3 and is not in mainline 2.5.69.
> > It is present in all -mm releases since.
> 
> Curious. Looking at patches between .68-mm2 and -mm3 reveals nothing
> major, in fact the only thing touching anything in that area seems to be
> the dynamic request allocation patch. Could you try 2.5.69 with the
> attached patch to verify that it still works (or doesn't)? There might
> be a small offset in deadline-iosched.c, should be nothing to worry
> about.

Still doesn't work with 2.5.69 + rq_dyn. The output from cdrecord is
below.

BTW, I also tried a 2.5.68-mm3 with 64bit_dev_t, blockdev-aio-support,
and disk_name-size-check backed out but still encountered the problem.

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

Regards,

Shane

