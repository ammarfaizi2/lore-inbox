Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262986AbTCNK0t>; Fri, 14 Mar 2003 05:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbTCNK0t>; Fri, 14 Mar 2003 05:26:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18871 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262986AbTCNK0s>;
	Fri, 14 Mar 2003 05:26:48 -0500
Date: Fri, 14 Mar 2003 12:37:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
Message-ID: <20030314113732.GC791@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org> <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org> <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org> <20030314104219.GA791@suse.de> <1047637870.1147.27.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047637870.1147.27.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Jeremy Fitzhardinge wrote:
> On Fri, 2003-03-14 at 02:42, Jens Axboe wrote:
> > Looks much better. Somehow the 'random' rpm you had didn't do SG_IO,
> > odd.
> 
> Hm, not better enough.  When I test a burn, I get this:
> 
> # cdrecord -dummy -data -isosize perforce.iso
> Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.7'
> Device type    : Removable CD-ROM
> Version        : 0
> Response Format: 1
> Vendor_info    : 'PLEXTOR '
> Identifikation : 'CD-R   PX-W4824A'
> Revision       : '1.04'
> Device seems to be: Generic mmc CD-RW.
> Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
> Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC
> Supported modes:
> cdrecord: Drive does not support TAO recording.
> cdrecord: Illegal write mode for this drive.
> exit status 255
> 
> I'm guessing the "Supported modes:" line should have something on it
> (TAO, at least).  With ide-scsi it does print many modes.

I've seen this bug reported before. But that's interesting, will try it
on my test box. Linus reported some problem with single byte commands
months ago, maybe this is related.

Can you send me the output of -prcap?

-- 
Jens Axboe

