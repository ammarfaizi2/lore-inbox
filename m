Return-Path: <linux-kernel-owner+w=401wt.eu-S1752625AbWLQNwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbWLQNwS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 08:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbWLQNwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 08:52:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49397 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbWLQNwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 08:52:17 -0500
Date: Sun, 17 Dec 2006 14:52:16 +0100
From: Jan Kara <jack@suse.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Martin Michlmayr <tbm@cyrius.com>,
       Marc Haber <mh+linux-kernel@zugschlus.de>, Jan Kara <jack@suse.cz>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Mikael Magnusson <mikachu@comhem.se>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061217135215.GB19416@atrey.karlin.mff.cuni.cz>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <20061209092639.GA15443@torres.l21.ma.zugschlus.de> <20061216184310.GA891@unjust.cyrius.com> <Pine.LNX.4.64.0612161909460.25272@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612161909460.25272@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 16 Dec 2006, Martin Michlmayr wrote:
> > * Marc Haber <mh+linux-kernel@zugschlus.de> [2006-12-09 10:26]:
> > > Unfortunately, I am lacking the knowledge needed to do this in an
> > > informed way. I am neither familiar enough with git nor do I possess
> > > the necessary C powers.
> > 
> > I wonder if what you're seein is related to
> > http://lkml.org/lkml/2006/12/16/73
> > 
> > You said that you don't see any corruption with 2.6.18.  Can you try
> > to apply the patch from
> > http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d08b3851da41d0ee60851f2c75b118e1f7a5fc89
> > to 2.6.18 to see if the corruption shows up?
> 
> I did wonder about the very first hunk of Peter's patch, where the
> mapping->private_lock is unlocked earlier now in try_to_free_buffers,
> before the clear_page_dirty.  I'm not at all familiar with that area,
> I wonder if Jan has looked at that change, and might be able to say
> whether it's good or not (earlier he worried about his JBD changes,
> but they wouldn't be implicated if just 2.6.18+Peter's gives trouble).
  Thanks for pointer. I was not aware of this change, I'll have a look
at it on Monday. Actually Mickael has checked that he sees corruption
even if all the JBD changes are backed out so I was going to look for
other changes in VFS that could cause that.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
