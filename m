Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVACJ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVACJ5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 04:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVACJ5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 04:57:35 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:6612 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S261413AbVACJ52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 04:57:28 -0500
Message-ID: <41D91707.6040102@tlinx.org>
Date: Mon, 03 Jan 2005 01:57:27 -0800
From: "L. A. Walsh" <law@tlinx.org>
Organization: Tlinx Solutions
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reviving the concept of a stable series (was Re: starting with 2.7)
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <20050102214211.GM29332@holomorphy.com> <20050102221534.GG4183@stusta.de> <20050102232102.GN26717@gallifrey>
In-Reply-To: <20050102232102.GN26717@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know about #3 below, but #1 and #2 are certainly true.
I always preferred to run a vanilla stable kernel as I did not
trust the vendors' kernels because their patches were not as well
eyed as the vanilla kernel.  I prefer to compile a kernel for
my specific machines, some of which are old and do better with a
hand-configured kernel rather than a Microsoftian monolith that
is compiled with all possible options as modules.

I have one old laptop that sound just doesn't work on no matter
what the settings -- may be failed hardware, but darned if I can't
seem to easily stop the loading of sound related modules as hardware
is probed by automatic hardware probing on each bootup, and the loading
of sound modules by GUI dependencies on a memory constrained system.

With each new kernel release, I wonder if it will be satisfactory
to use for a new, base-line, stable vanilla kernel, but post release
comments seem to prove otherwise. 

It seems that some developers have the opinion that the end-user base
no longer is their problem or audience and that the distros will patch
all the little boo-boo's in each unstable 2.6 release.  Well, that's
just plain asking for problems.  Just in SuSE's previous release of
9.1, it wouldn't boot up, for update, on any system that used xfs
disks.  Redhat has officially dropped support for end-user distros,
that leaves...who looking after end users?  Debian, Mandrake? 

 From what I've read here, stable Debian, it seems, is in the 2.4 series.
I don't know what Mandrake is up to, but I don't want to have to be
jumping distros because my distro maker has screwed up the kernel with
one of their patches.  I also wouldn't want to give up reporting
kernel bugs directly to developers as I would if I am using a non-vanilla,
or worse, some tainted module.

However, all that being said, there would still be the choosing of
someone, steady and capable, of holding on to the stable release and
being it's gate-keeper.  It seems like it would become quite a chore
to decide what code is let into the stable version.  It's also
considered by many to be "less" fun, not only to "manage the
stable distro", but backport code into the previous distro. 
Maybe no one _qualified_, wanted to manage a stable release. 
It takes time and possibly enough time to qualify as a
full-time job.  It takes a special person to find gainful
employment as a vendor-neutral kernel maintainer.  The alternative is
to try to work 2 jobs where, in programming, each job might "like"
to have 60-80 hours of attention per week.  That's a demanding
sacrifice as well.

It may be the case that no one at the last closed door kernel developer
meeting wanted to undertake the care of a stable kernel.  No
volunteers...no kernel.  There is less "wiggle room" in the average,
mature, developer's schedule with the advent of easy outsourcing to
cheaper labor that doesn't come from societies that breed independence
and nurture talented, more mature, or eccentric developers that love
spending spare cycles working on Open Source code.

Nevertheless, it would be nice to see a no-new-features, stable series
spun off from these development kernels, maybe .4th number releases,
like 2.6.10 also becomes a 2.6.10.0 that starts a 2.6.10.1, then 2.6.10.2,
etc...with iteritive bug fixes to the same kernel and no new features
in such a branch, it might become stable enough for users to have confidence
installing them on their desktop or stable machines.

It wouldn't have to be months upon months of diverging code, as jumps
to a new stable base can be started upon any fairly stable development
kernel, say 2.6.10 w/e100 fixed, tracing fixed, the slab bug fix, and
the capabilities bugs fixed going into a 2.6.10.1 that has no new features
or old features removed.  Serious bug fixes after that could go into a
2.6.10.2, etc.  Such point releases would be easier to manage and only
be updated/maintained as long as someone was interested enough to do it.

The same process would be applied to a future dev-kernel that appears to be
mostly stable after some number of weeks of alpha testing.  It may be
the case that a given furture dev-kernel has no stable branch off of it
because it either a) didn't need one, or b) was too far from stable to start
one.

Anyway, just a thought for having something of the old with out as much
of a headache of kernels that diverge for a year or more before getting
sync'ed up.

-l
:-)

Dr. David Alan Gilbert wrote:

>For me, as someone who very rarely actually changes any code in
>the kernel, I have always found the stable series useful for
>two reasons:
>
>  1) It encourages me to test the kernel; if I have a kernel
>  that is generally thought to be stable then I will try it on
>  my home machine and report problems - this lets the kernel
>  get tested on a wide range of hardware and situations; if there
>  is no kernel that is liable to be stable changes will get much
>  less testing on a smaller range of hardware.
>
>  2) If I have a bug in a vendor kernel everyone just tells
>  me to go and speak to the vendor - so at least having a stable
>  base to go back to can let me report a bug that isn't due
>  to any vendors patches.
>
>  3) In some cases the commercial vendors don't seem to release
>  source to some of the kernels except to people who have bought
>  the packages, so those vendor kernel fixes aren't 'publically'
>  visible.
>  
>I think (1) is very important - getting large numbers of people
>to test OSS is its greatest asset.
>  
>
