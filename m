Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWB1TrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWB1TrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWB1TrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:47:17 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:42686
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932533AbWB1TrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:47:16 -0500
Date: Tue, 28 Feb 2006 13:46:29 -0600
From: Matt Mackall <mpm@selenic.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060228194628.GP4650@waste.org>
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223204110.GE6213@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 03:41:10PM -0500, Dave Jones wrote:
> On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
> 
>  > > > >  config X86_P4_CLOCKMOD
>  > > > > 	depends on EMBEDDED
>  > > > 
>  > > > This one is an x86_64 only issue, and yes, it's wrong.
>  > > 
>  > > That's for P4, not X86_64... And since P4 clock modulation does not provide
>  > > almost any energy savings it was "hidden" under embedded.
>  > 
>  > But the EMBEDDED dependency is only on x86_64:
>  > 
>  > arch/i386/kernel/cpu/cpufreq/Kconfig:
>  > config X86_P4_CLOCKMOD
>  >         tristate "Intel Pentium 4 clock modulation"
>  >         select CPU_FREQ_TABLE
>  >         help
>  > 
>  > arch/x86_64/kernel/cpufreq/Kconfig:
>  > config X86_P4_CLOCKMOD
>  >         tristate "Intel Pentium 4 clock modulation"
>  >         depends on EMBEDDED
>  >         help
>  > 
>  > And if the option is mostly useless, what is it good for?
> 
> It's sometimes useful in cases where the target CPU doesn't have any better
> option (Speedstep/Powernow).  The big misconception is that it
> somehow saves power & increases battery life. Not so.
> All it does is 'not do work so often'.  The upside of this is
> that in some situations, we generate less heat this way.

This is perplexing. Less heat equals less power usage according to the
laws of thermodynamics.

-- 
Mathematics is the supreme nostalgia of our time.
