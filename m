Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262516AbTCMRyH>; Thu, 13 Mar 2003 12:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262515AbTCMRyH>; Thu, 13 Mar 2003 12:54:07 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:58385
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262512AbTCMRyF>; Thu, 13 Mar 2003 12:54:05 -0500
Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155!
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030313175454.GP836@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org>
	 <20030313175454.GP836@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1047578690.1322.17.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 10:04:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 09:54, Jens Axboe wrote:
> On Thu, Mar 13 2003, Jeremy Fitzhardinge wrote:
> > I was reading back a freshly burned CD from my shiny new Plexwriter
> > 48/24/48A.  I'm using ide-scsi, so this is an iso9660 filesystem mounted
> 
> out of curiousity, why? ide-cd should work much better than ide-scsi in
> 2.5, if it doesn't I'd like to know.

Mostly because I couldn't make cdrecord work properly with ide-cd - it
kept claiming I had an adaptec disk connected rather than the plextor
cdrom:

: root@ixodes:pts/2; cdrecord -scanbus 'dev=ATAPI:'
Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
scsidev: 'ATAPI:'
devname: 'ATAPI'
scsibus: -1 target: -1 lun: -1
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) 'ADAPTEC ' 'ACB-5500        ' 'FAKE' NON CCS Disk
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *


Maybe I just need to spend more effort on the user-space tools.  Is
there something other than cdrecord I should be using?

	J

