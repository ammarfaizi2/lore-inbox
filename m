Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWAYRSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWAYRSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWAYRSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:18:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26443 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750799AbWAYRSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:18:38 -0500
Date: Wed, 25 Jan 2006 18:20:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, rlrevell@joe-job.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: Rationale for RLIMIT_MEMLOCK?)
Message-ID: <20060125172014.GK4212@suse.de>
References: <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe> <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr> <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de> <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr> <43D7AE00.nailDFJ61L10Z@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D7AE00.nailDFJ61L10Z@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> >
> > >> And if you check the amount of completely unneeded code Linux currently has 
> > >> just to implement e.g. SG_IO in /dev/hd*, it could even _save_ space in the 
> > >> kernel when converting to a clean SCSI based design.
> > >
> > >Please point me at that huge amount of code. Hint: there is none.
> >
> > I'm getting a grin:
> >
> > 15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0 grep SG_IO
> > (no results)
> >
> > Looks like it's already non-redundant :)
> 
> everything in drivers/block/scsi_ioctl.c  is duplicate code and I am sure I 
> would find more if I take some time....

axboe@nelson:[.]r/src/linux-2.6-block.git $ size block/scsi_ioctl.o
   text    data     bss     dec     hex filename
   2844     256       0    3100     c1c block/scsi_ioctl.o

And it's not everything that's duplicated, basically only the ioctl
parsing is. So either admit that there isn't a a lot of duplicated code,
or "take some time" and point me at it. Otherwise refrain from making
obviously false statements in the future.

-- 
Jens Axboe

