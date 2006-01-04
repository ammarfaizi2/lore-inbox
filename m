Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWADK2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWADK2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWADK2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:28:48 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:59364 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751609AbWADK2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:28:47 -0500
Subject: Re: [PATCH 8/11] Time: i386 Conversion - part 4: ACPI PM variable
	renaming and config change.
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, george@mvista.com,
       zippel@linux-m68k.org, ulrich.windl@rz.uni-regensburg.de,
       tglx@linutronix.de
In-Reply-To: <20060103163554.48ce31a0.akpm@osdl.org>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
	 <20051216010802.19280.46938.sendpatchset@cog.beaverton.ibm.com>
	 <20060103163554.48ce31a0.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 02:33:14 -0800
Message-Id: <1136370805.3788.19.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 16:35 -0800, Andrew Morton wrote:
> john stultz <johnstul@us.ibm.com> wrote:
> >
> > Andrew, All,
> >  	The conversion of i386 to use the generic timeofday subsystem 
> >  has been split into 6 parts. This patch, the fourth of six, renames 
> >  some ACPI PM variables and removes the CONFIG_X86_PM_TIMER option. 
> > 
> >  It applies on top of my timeofday-arch-i386-part3 patch. This patch is 
> >  part the timeofday-arch-i386 patchset, so without the following parts 
> >  it is not expected to compile.
> >  	
> >  Andrew, please consider for inclusion into your tree.
> 
> Problems:
> 
> - The changelogs aren't terribly good.
> 
>   When preparing changelogs, please think of how they will look in the
>   final git record.  This means that metainfo concerning preceding patch
>   dependencies, the number of patches in the series, etc is irrelevant. 
>   The sequence numbering in the Subject: (which you have done correctly) is
>   sufficient.
> 
>   Text such as "please apply", while nice, just has to be removed by
>   myself.  I'm not offended if it doesn't get sent ;)
> 
>   Alert readers will note that I also strip out text such as "this patch
>   does X" from the changelogs.  Because such text is redundant once the
>   patch is merged up.  We _know_ it's a patch - otherwise it wouldn't be in
>   the git tree.
> 
>   And once we strip out the above irrelevencies, your changelogs are
>   awfully spartan for such a substantial piece of work.  Isn't there more
>   to be said?

Good point. I'll fix this in the next release. 

> - The fact that the kernel won't compile without the succeeding patches
>   in the series is unfortunate.  If someone is trying to locate an
>   unrelated regression via `git bisect' and the bisection process happens
>   to land them at one of your it-wont-compile points then they have a big
>   problem.  It can pretty much screw up the whole bisection process.
> 
>   So please try to ensure that the kernel will compile and probably run
>   at all points of a patch series.  If that's too hard then just fold the
>   separate patches into one larger patch (with appropriately expanded
>   changelog) to achieve the desired result.

Ok, I'll try to re-arrange the patches so they compile at each step.


> Anyway, I'll tenatively merge these patches into next -mm so they can get a
> bit of testing.  Which causes a problem, because you don't then have a tree
> against which to raise a new patch series.

I greatly appreciate the inclusion! I'm hoping a bit of time in -mm will
shake out any remaining bugs. 

Although I'm not sure I understand what you mean about me not having a
tree? Do you mean a public git tree? 


> So perhaps it would be best if you were to
> 
> a) Tell me which patches to fold into which other patches to generate a
>    series which compiles at every stage and
> 
> b) Send me a new set of changelogs for the resulting patch series.

I've got a set of chained git trees that store each patch, so its very
easy to re-generate the changelog + patches after I've re-arranged them
as you suggested.

Would a new patch-set to replace the current patchset be preferred here
or do you just want the above?  

Similarly, if we do run into bugs, would you prefer incremental fixup
patches or cumulative replacement patches when a new release of the
patchset is generated?

I'm just getting back from vacation tonight, so I'll send whatever you
prefer sometime tomorrow.

Sorry for the stumbling here, I really appreciate the feedback! 

thanks again,
-john

