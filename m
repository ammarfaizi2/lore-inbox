Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVACO06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVACO06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVACO06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:26:58 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37773 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261460AbVACOZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:25:57 -0500
Message-Id: <200501031424.j03EOV2t029019@laptop11.inf.utfsm.cl>
To: "L. A. Walsh" <law@tlinx.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series (was Re: starting with 2.7) 
In-Reply-To: Message from "L. A. Walsh" <law@tlinx.org> 
   of "Mon, 03 Jan 2005 01:57:27 -0800." <41D91707.6040102@tlinx.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 03 Jan 2005 11:24:31 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"L. A. Walsh" <law@tlinx.org> said:
> I don't know about #3 below, but #1 and #2 are certainly true.
> I always preferred to run a vanilla stable kernel as I did not
> trust the vendors' kernels because their patches were not as well
> eyed as the vanilla kernel.  I prefer to compile a kernel for
> my specific machines, some of which are old and do better with a
> hand-configured kernel rather than a Microsoftian monolith that
> is compiled with all possible options as modules.

The generic kernel + modules is a nice convenience for those that don't
compile their own. And the modules technology has made the need for
custom-compiled kernels all but go away. It is a _huge_ step forward (yes,
I do remember the large collection of Slackware boot disks for all sorts of
weird setups).

> I have one old laptop that sound just doesn't work on no matter
> what the settings -- may be failed hardware, but darned if I can't
> seem to easily stop the loading of sound related modules as hardware
> is probed by automatic hardware probing on each bootup, and the loading
> of sound modules by GUI dependencies on a memory constrained system.

Qualifies as "need for custom-compied kernel". Or even just custom
configured GUI.

> With each new kernel release, I wonder if it will be satisfactory
> to use for a new, base-line, stable vanilla kernel, but post release
> comments seem to prove otherwise. 

Only TeX is guaranteed bug-free.

> It seems that some developers have the opinion that the end-user base
> no longer is their problem or audience and that the distros will patch
> all the little boo-boo's in each unstable 2.6 release.

AFAIU, the current development model is designed to _diminish_ the need of
custom patching by distributions. For example, RH 9 2.4 kernels were mostly
2.6 via backports and random patches. But the patches were only maintained
by RH, so it was a large duplication of effort (not even counting the other
distributions). With 2.6 everybody can work on a up-to-date code base, much
less need of distribution backports and patches (and associated random
incompatibilities) benefits every user.

>                                                         Well, that's
> just plain asking for problems.

Quite to the contrary.

>                                  Just in SuSE's previous release of
> 9.1, it wouldn't boot up, for update, on any system that used xfs
> disks.  Redhat has officially dropped support for end-user distros,
> that leaves...who looking after end users?  Debian, Mandrake? 

>  From what I've read here, stable Debian, it seems, is in the 2.4 series.

Stable Debian is 3 years old.

> I don't know what Mandrake is up to, but I don't want to have to be
> jumping distros because my distro maker has screwed up the kernel with
> one of their patches.

You could complain to the distribution maker (so every one of their users
benefits from your problem, that is the whole point of open source!), undo
the patch, run a vanilla kernel. No need to skip around (doing so is
probably much more work than just changing kernels).

>                        I also wouldn't want to give up reporting
> kernel bugs directly to developers as I would if I am using a non-vanilla,
> or worse, some tainted module.

If it is a distribution kernel, you should complain to them, they will
forward your complaint to the maintainers if it warrants doing so. Only if
vanilla kernel you get to swamp the maintainers directly.

> However, all that being said, there would still be the choosing of
> someone, steady and capable, of holding on to the stable release and
> being it's gate-keeper.

The people in charge decided otherwise, for sound reasons. If you don't
like it, you are free to create you own fork off 2.6.10 (or something) and
stabilize that. That is the wonder of open source...

>                          It seems like it would become quite a chore
> to decide what code is let into the stable version.  It's also
> considered by many to be "less" fun, not only to "manage the
> stable distro", but backport code into the previous distro. 

Lots of rather pointless work. Much of it something each distribution has
to do on their own (because f.ex. vanilla 2.4 is _just fixes_, no backports
of cool (and required) new functionality), instead of cooperating in
building a better overall kernel.

> Maybe no one _qualified_, wanted to manage a stable release. 
> It takes time and possibly enough time to qualify as a
> full-time job.  It takes a special person to find gainful
> employment as a vendor-neutral kernel maintainer.  The alternative is
> to try to work 2 jobs where, in programming, each job might "like"
> to have 60-80 hours of attention per week.  That's a demanding
> sacrifice as well.

Yep. That's why nobody (and that certainly includes you) is entitled to
demand such.

> It may be the case that no one at the last closed door kernel developer
> meeting wanted to undertake the care of a stable kernel.

Andrew Morton had been designated for the job (and he accepted).

>                                                           No
> volunteers...no kernel.  There is less "wiggle room" in the average,
> mature, developer's schedule with the advent of easy outsourcing to
> cheaper labor that doesn't come from societies that breed independence
> and nurture talented, more mature, or eccentric developers that love
> spending spare cycles working on Open Source code.

English, please?

> Nevertheless, it would be nice to see a no-new-features, stable series
> spun off from these development kernels, maybe .4th number releases,
> like 2.6.10 also becomes a 2.6.10.0 that starts a 2.6.10.1, then 2.6.10.2,
> etc...with iteritive bug fixes to the same kernel and no new features
> in such a branch, it might become stable enough for users to have confidence
> installing them on their desktop or stable machines.

See above. The 2.6.9-x kernels from Red Hat/Fedora are targeted to be
exactly that...

> It wouldn't have to be months upon months of diverging code, as jumps
> to a new stable base can be started upon any fairly stable development
> kernel, say 2.6.10 w/e100 fixed, tracing fixed, the slab bug fix, and
> the capabilities bugs fixed going into a 2.6.10.1 that has no new features
> or old features removed.  Serious bug fixes after that could go into a
> 2.6.10.2, etc.  Such point releases would be easier to manage and only
> be updated/maintained as long as someone was interested enough to do it.

That is exactly the model! Just that no vanillla 2.6.9.1 has been needed
yet.

> The same process would be applied to a future dev-kernel that appears to be
> mostly stable after some number of weeks of alpha testing.

... conveniently forgetting that it is a experimental data point that
people start using the kernel (and finding its bugs) only when it leaves
"alpha" (by whatever name), so this doesn't work.

>                                                             It may be
> the case that a given furture dev-kernel has no stable branch off of it
> because it either a) didn't need one, or b) was too far from stable to start
> one.

(a) makes no sense, (b) is a mess that Linux has been able to avoid thus
far.

> Anyway, just a thought for having something of the old with out as much
> of a headache of kernels that diverge for a year or more before getting
> sync'ed up.

That's what you get with the new development model.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
