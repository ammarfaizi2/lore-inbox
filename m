Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWFYTAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWFYTAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWFYTAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:00:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54450 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S932438AbWFYTAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:00:13 -0400
X-Auth-Info: +Q/9X2iiMATeEmbWEydnLLqHp/t9ghX3LHVcGUbAEpA=
X-Auth-Info: +Q/9X2iiMATeEmbWEydnLLqHp/t9ghX3LHVcGUbAEpA=
X-Auth-Info: +Q/9X2iiMATeEmbWEydnLLqHp/t9ghX3LHVcGUbAEpA=
X-Auth-Info: +Q/9X2iiMATeEmbWEydnLLqHp/t9ghX3LHVcGUbAEpA=
X-Auth-Info: +Q/9X2iiMATeEmbWEydnLLqHp/t9ghX3LHVcGUbAEpA=
Date: Sun, 25 Jun 2006 21:00:48 +0200
From: Christian Lohmaier <cloph@openoffice.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Christian Lohmaier <lohmaier@gmx.de>
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read atip wiith cdrecord
Message-ID: <20060625190048.GA5784@bm617259.muenchen.org>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org> <20060624144739.78bde590.akpm@osdl.org> <Pine.LNX.4.61.0606251304450.28911@yvahk01.tjqt.qr> <20060625043622.e42c7254.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060625043622.e42c7254.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *, thanks for cc'ing me,

On Sun, Jun 25, 2006 at 04:36:22AM -0700, Andrew Morton wrote:
> On Sun, 25 Jun 2006 13:05:59 +0200 (MEST)
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > >>            Summary: kernel hangs when trying to read atip wiith cdrecord
> > >>     Kernel Version: 2.6.16.1
> > 
> > >> Most recent kernel where this bug did not occur: 2.6.16.1 (yes, the 
> > >> same version - it works with my dvd-burner, but not with my cd-burner), 
> > >> the 2.4 series worked with both, but there I have been using ide-scsi)
> > 
> > Can you try a newer version and/or (or both) with an original cdrecord (if 
> > not already done so) or cdrecord-prodvd?

I tried with 2.6.17.1, but the problem remains (I use original cdrecord)

Since I have a relatively old glibc I cannot use the newer versions of
cdrecord-prodvd, but cdrecord-prodvd-2.01b31-i686-pc-linux-gnu sometimes
works. I did work sometimes, but even when it wors and prints the atip -
compared to using my dvd-recorder it takes ages to print the results.

But now that I tried to double-check, it hung as well. It printed one
additional line after the supported modes, namely:
Drive buf size : 1806336 = 1764 KB

But then hangs. (full output see below)
 
> > [...]
> > Try -dev=/dev/hdX

That did not make a difference either, apart from the slightly different
warning message at the beginning.

# cdrecord-prodvd-2.01b31-i686-pc-linux-gnu -v dev=ATAPI:1,0,0 -atip
Cdrecord-ProDVD-Clone 2.01b31 (i686-pc-linux-gnu) Copyright (C) 1995-2004 J�rg Schilling
Unlocked features:
Limited  features:
TOC Type: 1 = CD-ROM
scsidev: 'ATAPI:1,0,0'
devname: 'ATAPI'
scsibus: 1 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
Using libscg version 'schily-0.8'.
SCSI buffer size: 64512
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'CyberDrv'
Identifikation : 'CW058D CD-R/RW  '
Revision       : '160D'
Device seems to be: Generic mmc CD-RW.
Current: Removable Disk
Profile: CD-RW
Profile: CD-R
Profile: CD-ROM
Profile: Removable Disk (current)
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-2 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1806336 = 1764 KB

ciao
Christian
-- 
NP: Limp Bizkit - Re-entry
