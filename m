Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274701AbRIYXLL>; Tue, 25 Sep 2001 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274697AbRIYXKt>; Tue, 25 Sep 2001 19:10:49 -0400
Received: from [195.223.140.107] ([195.223.140.107]:56048 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274695AbRIYXKn>;
	Tue, 25 Sep 2001 19:10:43 -0400
Date: Wed, 26 Sep 2001 01:11:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Olivier Sessink <olivier@lx.student.wau.nl>, linux-kernel@vger.kernel.org
Subject: Re: weird memory related problems, negative memory usage or fake memory usage?
Message-ID: <20010926011116.X8350@athlon.random>
In-Reply-To: <20010926003626.L8350@athlon.random> <Pine.LNX.4.33L.0109251952330.26091-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109251952330.26091-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Sep 25, 2001 at 07:54:07PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 07:54:07PM -0300, Rik van Riel wrote:
> On Wed, 26 Sep 2001, Andrea Arcangeli wrote:
> > On Mon, Sep 24, 2001 at 07:03:20PM -0300, Rik van Riel wrote:
> > > On Mon, 24 Sep 2001, Olivier Sessink wrote:
> 
> > > >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
> > > >  1262 root       5 -10 50764  -1M  1320 S <   2.7 99.9   0:01 XFree86
> > >
> > > It seems Andrea wasn't careful with the merge and
> > > backed out some of the locking wrt mm->rss.
> >
> > thanks for forwarding this report, actually I just noticed this
> > here and that's good so I can reproduce :)
> >
> > it is possible it is my mistake, but I don't think so, infact I
> > don't recall to have changed rss stuff or locking around it.
> 
> Mmm, then it could also be one of the bugs which got
> fixed in -ac but where Linus never reacted to the

possibly yes but maybe not, dunno right now or I would be just sending
the fix inline in this email :).  As said I never seen it before Ben's
tlb shootdown was merged into mainline, but again I repeat it can
_really_ be just an unlucky coincidence. But I guess because of this
coincidence the tlb shootdown will be the first things I will audit
tomorrow.

Andrea
