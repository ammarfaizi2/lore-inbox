Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWA1GIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWA1GIm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 01:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWA1GIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 01:08:42 -0500
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:22179 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751128AbWA1GIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 01:08:41 -0500
Date: Sat, 28 Jan 2006 01:04:16 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.15] i386: allow disabling X86_FEATURE_SEP at
  boot
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, ergot86@gmail.com, torvalds@osdl.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Message-ID: <200601280106_MC3-1-B6F2-9A79@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060127143713.2efc16ed.akpm@osdl.org>

On Fri, 27 Jan 2006 at 14:37:13 -0800, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > Allow the x86 "sep" feature to be disabled at bootup.  This
> > forces use of the int80 vsyscall.
> > 
>
> Why is there a need to do this?

Mainly for testing or benchmarking the int80 vsyscall code.

> > --- 2.6.15a.orig/arch/i386/kernel/cpu/common.c
> > +++ 2.6.15a/arch/i386/kernel/cpu/common.c
> > @@ -27,6 +27,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
> >  static int cachesize_override __devinitdata = -1;
> >  static int disable_x86_fxsr __devinitdata = 0;
> >  static int disable_x86_serial_nr __devinitdata = 1;
> > +static int disable_x86_sep __devinitdata = 0;
> >  
>
> hm, I guess lots of things in there should be __cpuinit/__cpuinitdata. 

I'll try to do that.

> __devinit is a superset of that, but we're being a little wasteful in the
> case of CONFIG_HOTPLUG&&!CONFIG_HOTPLUG_CPU.

-- 
Chuck

