Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161874AbWKJQxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161874AbWKJQxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161875AbWKJQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:53:07 -0500
Received: from xenotime.net ([66.160.160.81]:44779 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161874AbWKJQxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:53:04 -0500
Date: Fri, 10 Nov 2006 08:53:11 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-Id: <20061110085311.54fd65f2.rdunlap@xenotime.net>
In-Reply-To: <4554AC12.6040407@osdl.org>
References: <200611090757.48744.a1426z@gawab.com>
	<20061109090502.4d5cd8ef@freekitty>
	<200611101852.14715.a1426z@gawab.com>
	<9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com>
	<4554AC12.6040407@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 08:42:58 -0800 Stephen Hemminger wrote:

> Jesper Juhl wrote:
> > On 10/11/06, Al Boldi <a1426z@gawab.com> wrote:
> >> Stephen Hemminger wrote:
> > [...]
> >> > There are bugfixes which are too big for stable or -rc releases, 
> >> that are
> >> > queued for 2.6.20. "Bugfix only" is a relative statement. Do you 
> >> include,
> >> > new hardware support, new security api's, performance fixes.  It 
> >> gets to
> >> > be real hard to decide, because these are the changes that often cause
> >> > regressions; often one major bug fix causes two minor bugs.
> >>
> >> That's exactly the point I'm trying to get across; the 2.6 dev model 
> >> tries to
> >> be two cycles in one, dev and stable, which yields an awkward catch22
> >> situation.
> >>
> >> The only sane way forward in such a situation is to realize the 
> >> mistake and
> >> return to the focused dev-only / stable-only model.
> >>
> >> This would probably involve pushing the current 2.6 kernel into 2.8 and
> >> starting 2.9 as a dev-cycle only, once 2.8 has structurally stabilized.
> >>
> >
> > That was not what I was arguing for in the initial mail at all.
> > I think the 2.6 model works very well in general. All I was pushing
> > for was a single cycle focused mainly on bug fixes once in a while.
> >
> I like the current model fine. From a developer point of view:

I don't think that it's great, but having even/odd stable/development
is even worse.

But I agree with Jesper and Andrew's comments in general, that
we do have stability problems and we have a lack of people
who are working on bugs.

>   * More branches means having to fix and retest a bug more places.
>      Workload goes up geometrically with number of versions.
>      So most developers end up ignoring fixing more than 2 versions;
>      anything more than -current and -stable are ignored.
>  * Holding off the tide of changes doesn't work. It just leads to
>     massive integration headaches.
>  * Many bugs don't show up until kernel is run on wide range of hardware,
>     but kernel doesn't get exposed to wide range of hardware and
>     applications until after it is declared stable. It is a Catch-22.
>     The current stability range  of
>            -subtree ... -mm ... 2.6.X ... 2.6.X.Y... 2.6.vendor
>      works well for most people. The people it doesn't work for are trying
>      to get something for nothing. They want stability and the latest kernel
>      at the same time.
> 
> There are some things that do need working on:
>   * Old bugs die, the bugzilla database needs a 6mo prune out.
> 
>   * Bugzilla.kernel.org is underutilized and is only a small sample of the
>     real problems. Not sure if it is a training, user, behaviour issue or
>     just that bugzilla is crap.

Behavior, ease of use vs. email.

>   * Vendor bugs (that could be fixed) aren't forwarded to lkml or bugzilla

ack

>   * LKML is an overloaded communication channel, do we need:
>       linux-bugs@vger.kernel.org ?

Either that or lkml is/remains for bug reporting and we move development
somewhere else.  Or my [repeated] preference:

do development on specific mailing lists (although there would
likely need to be a fallback list when it's not clear which mailing
list should be used)

>    * Developers can't get (or afford to buy) the new hardware that causes
>       a lot of the pain. Just look at the number of bug reports due to new
>       flavors of motherboards, chipsets, etc. I spent 3mo on a bug that took
>       one day to fix once I got the hardware.

Yep.

---
~Randy
