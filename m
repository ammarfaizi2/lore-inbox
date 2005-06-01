Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVFAUq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFAUq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFAUpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:45:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261217AbVFAUmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:42:53 -0400
Date: Wed, 1 Jun 2005 22:42:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: [PATCH] Don't explode on swsusp failure to find swap
Message-ID: <20050601204207.GA11163@elf.ucw.cz>
References: <1117523585.5826.18.camel@gaston> <1117583403.5826.72.camel@gaston> <20050601092742.GC6693@elf.ucw.cz> <200506012120.40607.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506012120.40607.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
> > --- a/kernel/power/swsusp.c
> > +++ b/kernel/power/swsusp.c
> > @@ -975,13 +975,6 @@ extern asmlinkage int swsusp_arch_resume
> >  
> >  asmlinkage int swsusp_save(void)
> >  {
> > -	int error = 0;
> > -
> > -	if ((error = swsusp_swap_check())) {
> > -		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
> > -				"swapon -a!\n");
> > -		return error;
> > -	}
> >  	return suspend_prepare_image();
> >  }
> 
> I think we can move the contents of suspend_prepare_image() directly to
> swsusp_save().  It's not used anywhere else.

I thought about that, too, but bugfixes first, cleanups next.

									Pavel
