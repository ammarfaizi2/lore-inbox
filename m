Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289040AbSAFVNm>; Sun, 6 Jan 2002 16:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289035AbSAFVM0>; Sun, 6 Jan 2002 16:12:26 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:61347 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289038AbSAFVLq>; Sun, 6 Jan 2002 16:11:46 -0500
Date: Sun, 6 Jan 2002 14:11:45 -0700
Message-Id: <200201062111.g06LBjx17390@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <3C38BCE6.3030302@zytor.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
	<20020106204311.C2596@butterlicious.bodgit-n-scarper.com>
	<3C38BCE6.3030302@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Matt Dainty wrote:
> 
> > Okey dokey,
> > 
> > Please find attached a second, better patch to add devfs support to the i386
> > cpuid and msr drivers. Now it doesn't nuke the cpu/X directories on
> > unloading and only enumerates CPUs based on smp_num_cpus instead of NR_CPUS.
> 
> If you don't understand why this is idiotic, then let me enlighten you: 
> there is no sensible reason why /dev/cpu/%d should only be populated 
> after having run a CPU-dependent device driver.  /dev/cpu/%d should be 
> always populated; heck, that's the only way you can sensibly handle 
> hotswapping CPUs.

I've already privately told Matt that it would be nice if creation of
/dev/cpu/%d was handled by generic boot code, and not a driver.
However, I don't see that as essential for the CPUID and MSR drivers.

> I WILL NOT accept a patch as long as devfs is as fucked in the head
> as it currently is.  Unfortunately, that seems like it will be a
> long long time.

No need to get rude.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
