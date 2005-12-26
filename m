Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVLZB7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVLZB7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 20:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVLZB7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 20:59:55 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:1046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750954AbVLZB7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 20:59:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYguAO23K1ZkEYkWy8709esOhf+GGD4dpP+B4/x6hphymKchjyjcH5eNQN/DuKSwnqMCG+ufvH2IehFGtOQLzc9ytXGk/Gz0hWERbqh9EO2oo38+xAytF3+ugyGnkDQ7cCINJWt64lFE5h9FJsgJuP69FP1L1J1RVkvp9eTBYbU=
Message-ID: <37219a840512251759q21d91974m12eafabf0c83947f@mail.gmail.com>
Date: Sun, 25 Dec 2005 20:59:54 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Cc: davidsen@tmr.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       axboe@suse.de, herbert@gondor.apana.org.au, michael.madore@gmail.com,
       david-b@pacbell.net, gregkh@suse.de, paulmck@us.ibm.com, gohai@gmx.net,
       luca.risolia@studio.unibo.it, p_christ@hol.gr
In-Reply-To: <20051223195455.3cc4b1a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051222011320.GL3917@stusta.de>
	 <20051222005209.0b1b25ca.akpm@osdl.org>
	 <20051222135718.GA27525@stusta.de>
	 <20051222060827.dcd8cec1.akpm@osdl.org> <43AC1791.1080806@tmr.com>
	 <37219a840512230932m5c371f80gbde4cf652bbd1728@mail.gmail.com>
	 <20051223195455.3cc4b1a2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/05, Andrew Morton <akpm@osdl.org> wrote:
> Michael Krufky <mkrufky@gmail.com> wrote:
> >
> > On 12/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
> > > Andrew Morton wrote:
> > > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > >>not a post-2.6.14 regression
> > > >>
> > > >
> > > >
> > > > Well yeah.  But that doesn't mean thse things have lower priority that
> > > > post-2.6.14 regressions.
> > > >
> > > > I understand what you're doing here, but we should in general concentrate
> > > > upon the most severe bugs rather than upon the most recent..
> > >
> > > Hypocratic oath: "First, do no harm."
> > >
> > > If a new kernel version can't make things *better*, at least it
> > > shouldn't make them *worse*. New features are good, performance
> > > improvements are good, breaking working systems with an update is not good.
> > >
> > > I'm with Adrian on this, if you want people to test and report with -rc
> > > kernels, then there should be some urgency to addressing the reported
> > > problems.
> >
> > I agree.  Quite frankly, I am extremely surprised that this matter is
> > even up for discussion.  Is it really so important to release 2.6.15
> > before the end of 2005 that we dont even have the time to fix
> > regressions that have already been reported in older kernels?
>
> No, the release dates aren't critical at all.
>
> The problem is that if we allow the release to be stalled by bugs it allows
> one sluggish maintainer to block the entire kernel.  At some point in time
> we do need to just give up and hope that the bug will get fixed in 2.6.x.y
> or that it'll just magically fix itself later on (this happens, for various
> reasons).
>
> We get in the situation where lots of people are sitting there with arms
> folded, complaining about lack of a new kernel release while nobody is
> actually working on the bugs.  Nobody knows why this happens.
>
> > ESPECIALLY given that patches are said to be available?
>
> Things get lost.  If there's a patch which needs applying and we've missed
> it, please please please rediff it, add your Signed-off-by and loudly mail
> the thing out daily.
>
> > IMHO, I agree that new regressions are most important to fix, but I
> > feel that old regressions are extremely important to fix as well.  If
> > we know of more regressions that CAN be fixed before a kernel release,
> > why not do it?
>
> Fixing many of these things is not trivial, as I'm sure you know from
> personal experience.  The great majority are in drivers and, almost
> axiomatically, the guy who added the regression cannot reproduce it on his
> hardware (otherwise he wouldn't have shipped the diff).  So the debugging
> process involves drawn out to-and-fro with the reporter.  And it requires
> quite a bit of work by and help from the original reporter.  Depressingly,
> developers often just don't bother entering into this process in the first
> place and we shed another batch of mainline testers/users.
>
> > Why should there be any rush to release the next mainline version?  To
> > make it in time for Christmas?  A better Christmas gift to the world
> > would be a new release without regressions, be it a month late, who
> > cares?  (I know -- not likely, but at least we should try)
>
> We'll regularly hold up a release due to an identified set of bugs.  But if
> we do this we need to be very clear on what those bugs are and we need to
> be assured that there's a developer actively working on each bug and that
> the reporter is responding.  Without all of that in place, the whole
> release process would get stalled for arbitrary amounts of time.
>
> We need someone who does nothing but track and report upon bugs.  It would
> be a full-time job.  We don't have asuch a person.  We hope that individual
> maintainers and subsystem maintainers will track the bugs in their area of
> responsibility so that such a person is not necessary.  But the maintainers
> don't do this.  You see the result.

Fair enough... (not much else I can say to that -- you're right)

...  btw, I tested -rc7 and it's smooth as butter...

-MiKE
