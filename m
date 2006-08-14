Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751917AbWHNHds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbWHNHds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWHNHdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:33:47 -0400
Received: from 1wt.eu ([62.212.114.60]:40974 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751917AbWHNHdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:33:47 -0400
Date: Mon, 14 Aug 2006 09:30:21 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Grant Coady <gcoady.lk@gmail.com>, Kasper Sandberg <lkml@metanurb.dk>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.33 released
Message-ID: <20060814073021.GA31660@1wt.eu>
References: <200608110418.k7B4IqDn017355@hera.kernel.org> <1155318180.23933.7.camel@localhost> <20060811190923.GJ8776@1wt.eu> <e8eqd2ho9a92hiqohjfmkhsbohl5beabvf@4ax.com> <1155539524.2886.178.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155539524.2886.178.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 09:12:04AM +0200, Arjan van de Ven wrote:
> On Sat, 2006-08-12 at 12:18 +1000, Grant Coady wrote:
> > On Fri, 11 Aug 2006 21:09:23 +0200, Willy Tarreau <w@1wt.eu> wrote:
> > 
> > >Hello,
> > >
> > >On Fri, Aug 11, 2006 at 07:43:00PM +0200, Kasper Sandberg wrote:
> > >> On Fri, 2006-08-11 at 04:18 +0000, Marcelo Tosatti wrote:
> > >> > final:
> > >> > 
> > >> > - 2.4.33-rc3 was released as 2.4.33 with no changes.
> > >> I have one suggestion for the 2.4 tree, next time a few changes is
> > >> introduced, they could be put as a bugfix release, as with the 2.6
> > >> branch now, so that it doesent end up taking years for a new 2.4
> > >> release, and instead a point release(if any such thing happens at all)
> > >
> > >This has already the case with the hotfix tree since 18 months or so. A
> > >hotfix release is issued when there are important fixes. Anyway, I was
> > >thinking about releasing pre-releases more often. Also, you might have
> > >noticed that the slowdown is more important during -rc for obvious reasons.
> > 
> > >To solve this problem, I intend to maintain a 'next' branch in the tree
> > >which will contain the fixes that can wait for next version. It should
> > >help us batch the fixes and reduce the latency between important fixes
> > >and the associated release.
> > 
> > Perhaps time to follow the 2.6.nn-stable naming scheme?  Since you're in 
> > the driver's seat now?  This may be less confusing to 2.4 series users.
> 
> Maybe a strange question.. but why bother?
> The criteria for a patch going into 2.4 are already stricter than the
> 2.6 -stable criteria (in practice), so why not just release a new "full"
> kernel instead when this is required/needed ?

That's what I thought first, but it's not always that easy. There are fixes
in some drivers which need some review and some tests for instance. Also,
other difficult fixes cannot be released without a strong validation (thinking
about the unlink() race which we got wrong several times). Intermediate fixes
are useful to quickly fix security issues. That's also why I mostly don't put
driver patches in the hotfix tree.

Cheers,
Willy

