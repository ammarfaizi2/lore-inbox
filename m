Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbTKEOjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 09:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTKEOjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 09:39:14 -0500
Received: from ns.suse.de ([195.135.220.2]:57225 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262932AbTKEOhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 09:37:34 -0500
Date: Wed, 5 Nov 2003 12:26:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031105112615.GL1477@suse.de>
References: <3FA69CDF.5070908@gmx.de> <3FA8D059.7010204@cyberone.com.au> <20031105102904.GK1477@suse.de> <200311050554.38147.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311050554.38147.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Gene Heskett wrote:
> On Wednesday 05 November 2003 05:29, Jens Axboe wrote:
> >On Wed, Nov 05 2003, Nick Piggin wrote:
> >> Prakash K. Cheemplavam wrote:
> >> >SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the
> >> > mouse stutters slighty when burning (in atapi mode). I am now
> >> > using as sheduler. Shoudl I try deadline or do you this it is
> >> > something else? Should I open a new topic?
> >>
> >> This is more likely to be the CPU scheduler or something holding
> >> interrupts for too long. Are you running anything at a modified
> >
> >                 ^^^^^^^^
> >
> >precisely, that's why the actual interface that cdrecord uses is the
> >primary key to knowing what the problem is.
> 
> Similar problem here Jens.
> 
> I have the emulation stuff turned on, and use /dev/scd0 to access my
> 12/10/32 Creative burner.  I failed to complete an iso burn yesterday,
> useing test9-mm1, and the initial logged message indicate an IRQ timeout.

Well don't, ide-scsi must not be used. So the dozens of messages to that
effect on this list, and Dave Jones 2.6 kernel document for more info.

-- 
Jens Axboe

