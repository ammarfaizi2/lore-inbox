Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUF0IyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUF0IyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 04:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUF0IyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 04:54:09 -0400
Received: from gprs212-68.eurotel.cz ([160.218.212.68]:17537 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261347AbUF0IyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 04:54:05 -0400
Date: Sun, 27 Jun 2004 10:51:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       trivial@rustcorp.com.au
Subject: Re: swsusp: kill useless exports
Message-ID: <20040627085115.GA32267@elf.ucw.cz>
References: <20040625115642.GA2307@elf.ucw.cz> <20040626160857.343e9cb3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626160857.343e9cb3.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > These exports seem totally unneccessary as swsusp can't be module
> > anyway. Idea by Patrick Mochel. Please apply,
> > 							Pavel
> > 
> > --- linux-cvs//arch/i386/power/cpu.c	2004-06-25 13:08:23.000000000 +0200
> > +++ linux/arch/i386/power/cpu.c	2004-06-24 23:37:00.000000000 +0200
> > @@ -147,7 +147,3 @@
> >  {
> >  	__restore_processor_state(&saved_context);
> >  }
> > -
> > -
> > -EXPORT_SYMBOL(save_processor_state);
> > -EXPORT_SYMBOL(restore_processor_state);
> 
> These are called from apm.c, which can be built as a module.
> 
> (grep!)

Ouch, sorry about that, I'll add a comment so this "cleanup" does not came
up in future.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
