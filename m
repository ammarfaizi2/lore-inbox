Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbTCMSwP>; Thu, 13 Mar 2003 13:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbTCMSwP>; Thu, 13 Mar 2003 13:52:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16815 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262501AbTCMSwN>;
	Thu, 13 Mar 2003 13:52:13 -0500
Date: Thu, 13 Mar 2003 20:02:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155!
Message-ID: <20030313190247.GQ836@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org> <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047578690.1322.17.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, Jeremy Fitzhardinge wrote:
> On Thu, 2003-03-13 at 09:54, Jens Axboe wrote:
> > On Thu, Mar 13 2003, Jeremy Fitzhardinge wrote:
> > > I was reading back a freshly burned CD from my shiny new Plexwriter
> > > 48/24/48A.  I'm using ide-scsi, so this is an iso9660 filesystem mounted
> > 
> > out of curiousity, why? ide-cd should work much better than ide-scsi in
> > 2.5, if it doesn't I'd like to know.
> 
> Mostly because I couldn't make cdrecord work properly with ide-cd - it
> kept claiming I had an adaptec disk connected rather than the plextor
> cdrom:
> 
> : root@ixodes:pts/2; cdrecord -scanbus 'dev=ATAPI:'
> Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> scsidev: 'ATAPI:'
> devname: 'ATAPI'
> scsibus: -1 target: -1 lun: -1
> Warning: Using ATA Packet interface.
> Warning: The related libscg interface code is in pre alpha.
> Warning: There may be fatal problems.
> Using libscg version 'schily-0.7'
> scsibus0:
>         0,0,0     0) 'ADAPTEC ' 'ACB-5500        ' 'FAKE' NON CCS Disk
>         0,1,0     1) *
>         0,2,0     2) *
>         0,3,0     3) *
>         0,4,0     4) *
>         0,5,0     5) *
>         0,6,0     6) *
>         0,7,0     7) *
> 
> 
> Maybe I just need to spend more effort on the user-space tools.  Is
> there something other than cdrecord I should be using?

Nope cdrecord is fine, but I think only open by device name works
currently. So you'd need to do

# cdrecord -dev=/dev/hdX -inq

to print inquiry data, for instance.

-- 
Jens Axboe

