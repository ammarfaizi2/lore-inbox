Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWAYOyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWAYOyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWAYOyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:54:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6201 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751187AbWAYOyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:54:46 -0500
Date: Wed, 25 Jan 2006 15:55:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: Rationale for RLIMIT_MEMLOCK?)
Message-ID: <20060125145544.GA4212@suse.de>
References: <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe> <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr> <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de> <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Jan Engelhardt wrote:
> 
> >> And if you check the amount of completely unneeded code Linux currently has 
> >> just to implement e.g. SG_IO in /dev/hd*, it could even _save_ space in the 
> >> kernel when converting to a clean SCSI based design.
> >
> >Please point me at that huge amount of code. Hint: there is none.
> 
> I'm getting a grin:
> 
> 15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0 grep SG_IO
> (no results)
> 
> Looks like it's already non-redundant :)

SG_IO turns requests into REQ_BLOCK_PC (or blk_pc_request()) types, so
you should probably check for that as well. But it's truly a miniscule
amount of code, and if I got off my ass and folded cdrom_newpc_intr()
and cdrom_pc_intr() into one (that was the intention), it would be even
less.

It just looks like Joerg needs to do his homework, before spreading
false information on lkml. Then again, all his "arguments" are the same
as last time (and the time before, and before, and so on).

-- 
Jens Axboe

