Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287627AbSAHLwx>; Tue, 8 Jan 2002 06:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287631AbSAHLwn>; Tue, 8 Jan 2002 06:52:43 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:13063 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S287627AbSAHLwi>; Tue, 8 Jan 2002 06:52:38 -0500
Date: Tue, 8 Jan 2002 12:02:07 +0000
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: rgooch@ras.ucalgary.ca, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Message-ID: <20020108120207.A15498@mould.bodgit-n-scarper.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	rgooch@ras.ucalgary.ca, hpa@zytor.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca> <3C38BC6B.7090301@zytor.com> <200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca> <3C38BD32.6000900@zytor.com> <200201070131.g071VrM20956@vindaloo.ras.ucalgary.ca> <3C38FAB0.4000503@zytor.com> <200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca> <20020108111302.A14860@mould.bodgit-n-scarper.com> <20020108201451.088f7f99.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108201451.088f7f99.rusty@rustcorp.com.au>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 08:14:51PM +1100, Rusty Russell wrote:
> On Tue, 8 Jan 2002 11:13:02 +0000
> Matt Dainty <matt@bodgit-n-scarper.com> wrote:
> 
> > On Sun, Jan 06, 2002 at 06:40:58PM -0700, Richard Gooch wrote:
> > > 
> > > So I'd like to propose a new file (say kernel/smp.c) which has generic
> > > startup code for each CPU. To start with, it can have a
> > > generic_cpu_init() function, which is called by each arch. Note that
> > > this function would be called for the boot CPU too.
> > 
> > Would this also be hacked into whatever Hotswap CPU support exists? Such
> 
> We use /proc/sys/cpu/#/.  I don't understand what /dev/cpu/xxx is supposed to
> do.

/dev/cpu/[0...]/... contains (on i386 at least), the cpuid and msr character
devices, except on devfs-enabled boxen, these don't appear automatically.

Matt
-- 
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"
