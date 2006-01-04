Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWADAgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWADAgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWADAgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:36:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751169AbWADAgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:36:40 -0500
Date: Tue, 3 Jan 2006 16:35:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, george@mvista.com,
       zippel@linux-m68k.org, ulrich.windl@rz.uni-regensburg.de,
       tglx@linutronix.de, johnstul@us.ibm.com
Subject: Re: [PATCH 8/11] Time: i386 Conversion - part 4: ACPI PM variable
 renaming and config change.
Message-Id: <20060103163554.48ce31a0.akpm@osdl.org>
In-Reply-To: <20051216010802.19280.46938.sendpatchset@cog.beaverton.ibm.com>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
	<20051216010802.19280.46938.sendpatchset@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> Andrew, All,
>  	The conversion of i386 to use the generic timeofday subsystem 
>  has been split into 6 parts. This patch, the fourth of six, renames 
>  some ACPI PM variables and removes the CONFIG_X86_PM_TIMER option. 
> 
>  It applies on top of my timeofday-arch-i386-part3 patch. This patch is 
>  part the timeofday-arch-i386 patchset, so without the following parts 
>  it is not expected to compile.
>  	
>  Andrew, please consider for inclusion into your tree.

Problems:

- The changelogs aren't terribly good.

  When preparing changelogs, please think of how they will look in the
  final git record.  This means that metainfo concerning preceding patch
  dependencies, the number of patches in the series, etc is irrelevant. 
  The sequence numbering in the Subject: (which you have done correctly) is
  sufficient.

  Text such as "please apply", while nice, just has to be removed by
  myself.  I'm not offended if it doesn't get sent ;)

  Alert readers will note that I also strip out text such as "this patch
  does X" from the changelogs.  Because such text is redundant once the
  patch is merged up.  We _know_ it's a patch - otherwise it wouldn't be in
  the git tree.

  And once we strip out the above irrelevencies, your changelogs are
  awfully spartan for such a substantial piece of work.  Isn't there more
  to be said?

- The fact that the kernel won't compile without the succeeding patches
  in the series is unfortunate.  If someone is trying to locate an
  unrelated regression via `git bisect' and the bisection process happens
  to land them at one of your it-wont-compile points then they have a big
  problem.  It can pretty much screw up the whole bisection process.

  So please try to ensure that the kernel will compile and probably run
  at all points of a patch series.  If that's too hard then just fold the
  separate patches into one larger patch (with appropriately expanded
  changelog) to achieve the desired result.


Anyway, I'll tenatively merge these patches into next -mm so they can get a
bit of testing.  Which causes a problem, because you don't then have a tree
against which to raise a new patch series.

So perhaps it would be best if you were to

a) Tell me which patches to fold into which other patches to generate a
   series which compiles at every stage and

b) Send me a new set of changelogs for the resulting patch series.

OK?
