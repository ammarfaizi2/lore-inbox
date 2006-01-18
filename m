Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWARWrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWARWrr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWARWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:47:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31900 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932574AbWARWrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:47:46 -0500
Date: Wed, 18 Jan 2006 23:47:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mita@miraclelinux.com, Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces
Message-ID: <20060118224732.GA1812@elf.ucw.cz>
References: <200601170126_MC3-1-B602-EFCB@compuserve.com> <20060116224234.5a7ca488.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116224234.5a7ca488.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Print stack backtraces in multiple columns, saving screen space.
> > Number of columns is configurable and defaults to one so 
> > behavior is backwards-compatible.
> > 
> > Also removes the brackets around addresses when printing more
> > that one entry per line so they print as:
> >     <address>
> > instead of:
> >     [<address>]
> > This helps multiple entries fit better on one line.
> > 
> > Original idea by Dave Jones, taken from x86_64.
> > 
> 
> Presumably this is going to bust ksymoops.  Also the various other custom
> oops-parsers which people have written themselves.
> 
> > +config STACK_BACKTRACE_COLS
> 
> It's pretty sad to go and make something like this a config option.  But
> given that it is, believe it or not, an exported-to-userspace interface, I
> guess there's not much choice.

I don't think we should call printk()s "userspace interface". Yes,
someone may do dmesg | custom-grep-to-find-all-the-hardware, but
thats clearly stupid. I also believe that oops dump is so closely tied
to kernel that it is fair to change... plus this should better not be
configurable, or userspace will have hard time parsing it.
								Pavel
-- 
Thanks, Sharp!
