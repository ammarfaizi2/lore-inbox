Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUEQJNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUEQJNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 05:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUEQJNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 05:13:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37280 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264952AbUEQJNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 05:13:34 -0400
Date: Mon, 17 May 2004 11:13:34 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Kara <jack@ucw.cz>, linux-kernel@vger.kernel.org, lukasz@wsisiz.edu.pl,
       j.borsboom@erasmusmc.nl, crosser@average.org, torvalds@osdl.org
Subject: Re: [PATCH] Quota fix 2
Message-ID: <20040517091334.GC29746@atrey.karlin.mff.cuni.cz>
References: <20040515192824.GB21471@atrey.karlin.mff.cuni.cz> <20040516000401.506d8456.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516000401.506d8456.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@ucw.cz> wrote:
> >
> >   another fix for quota code - it fixes the problem with recursion into
> >  filesystem when inode of quota file needs a page + some other allocation
> >  problems.
> 
> It makes sense.
> 
> > I hope I got the GFP mask setting right..
> 
> nope!  Here's a fix against your patch.
  Originally I had in the patch something similar but then I read the
comment at mapping_set_gfp_mask():
/*
 * This is non-atomic.  Only to be used before the mapping is activated.
 * Probably needs a barrier...
 */
and so changed that to clear_bit(). Anyway thanks for fixing.

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
