Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbTAVH5I>; Wed, 22 Jan 2003 02:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbTAVH5I>; Wed, 22 Jan 2003 02:57:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63900 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267384AbTAVH5H>;
	Wed, 22 Jan 2003 02:57:07 -0500
Date: Wed, 22 Jan 2003 09:05:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       greg@ulima.unil.ch, linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030122080558.GX20780@suse.de>
References: <200301220109.h0M19qNV021906@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200301220109.h0M19qNV021906@burner.fokus.gmd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22 2003, Joerg Schilling wrote:
> >From: Gregoire Favre <greg@ulima.unil.ch>
> 
> >after reporting this problem, someone pointed me that I should try
> >without DAO, I have tried this:
> 
> >mkisofs -dvd-video -V $1 $2 | cdrecord-prodvd driveropts=burnfree -dummy -v dev=/dev/hdc fs=64m speed=1 -eject tsize={$SIZE}s -
> 
> >And got this:
> 
> >Cdrecord-ProDVD-Clone 2.0 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
> >Unlocked features: ProDVD Clone 
> >Limited  features: speed 
> >This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
> >TOC Type: 1 = CD-ROM
> >scsidev: '/dev/hdc'
> >devname: '/dev/hdc'
> >scsibus: -2 target: -2 lun: -2
> >Warning: Open by 'devname' is unintentional and not supported.
> >Linux sg driver version: 3.5.27
> >Using libscg version 'schily-0.7'
> >Driveropts: 'burnfree'
> >atapi: 1
> >Device type    : Removable CD-ROM
> >Version        : 2
> >Response Format: 2
> >Capabilities   : 
> >Vendor_info    : 'SONY    '
> >Identifikation : 'DVD RW DRU-500A '
> >Revision       : '1.0f'
> >Device seems to be: Generic mmc2 DVD-R/DVD-RW.
> >Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
> >Driver flags   : DVD SWABAUDIO BURNFREE 
> >Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
> >Drive buf size : 8126464 = 7936 KB
> >FIFO size      : 67108864 = 65536 KB
> >Track 01: data  4001 MB        
> >Total size:     4001 MB = 2048512 sectors
> >Current Secsize: 2048
> >Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 249984
> >Starting to write CD/DVD at speed 1 in dummy TAO mode for single session.
> >Last chance to quit, starting dummy write in 9 seconds.  0.24% done, estimate finish Tue Jan 21 23:09:02 2003
> >   8 seconds.  0.49% done, estimate finish Tue Jan 21 23:09:03 2003
> >   7 seconds.  0.73% done, estimate finish Tue Jan 21 23:06:46 2003
> >   6 seconds.  0.98% done, estimate finish Tue Jan 21 23:07:21 2003
> >   5 seconds.  1.22% done, estimate finish Tue Jan 21 23:07:41 2003
> >   4 seconds.  1.46% done, estimate finish Tue Jan 21 23:07:55 2003
> >   0 seconds. Operation starts.
> >Waiting for reader process to fill input buffer ... input buffer ready.
> >BURN-Free is ON.
> >Starting new track at sector: 0
> >Track 01:    4 of 4001 MB written (fifo  96%)  16.1x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
> >CDB:  2A 00 00 00 08 B8 00 00 1F 00
> >status: 0x1 (GOOD STATUS)
> >resid: 63488
> >cmd finished after 0.008s timeout 100s
> 
> I can't tell you what happened because the kernel is broken :-(
> 
> If you fix the kernel, you will get a readble error message,

How helpful. How about saying what's broken instead and I'd be happy to
fix it.

-- 
Jens Axboe

