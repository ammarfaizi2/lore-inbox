Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVHYJI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVHYJI1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVHYJI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:08:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40169 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964890AbVHYJI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:08:26 -0400
Date: Thu, 25 Aug 2005 11:08:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] Add MCE resume under ia32
Message-ID: <20050825090815.GA1863@elf.ucw.cz>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com> <20050823103256.GB2795@elf.ucw.cz> <1124846001.3007.7.camel@linux-hp.sh.intel.com> <20050824085054.GA4310@elf.ucw.cz> <1124937391.4884.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1124937391.4884.3.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 25-08-05 10:36:31, Shaohua Li wrote:
> On Wed, 2005-08-24 at 10:50 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > > diff -puN arch/i386/power/cpu.c~mcheck_resume arch/i386/power/cpu.c
> > > > > --- linux-2.6.13-rc6/arch/i386/power/cpu.c~mcheck_resume	2005-08-23 09:32:13.054008584 +0800
> > > > > +++ linux-2.6.13-rc6-root/arch/i386/power/cpu.c	2005-08-23 09:41:54.992540480 +0800
> > > > > @@ -104,6 +104,8 @@ static void fix_processor_context(void)
> > > > >  
> > > > >  }
> > > > >  
> > > > > +extern void mcheck_init(struct cpuinfo_x86 *c);
> > > > > +
> > > > >  void __restore_processor_state(struct saved_context *ctxt)
> > > > >  {
> > > > >  	/*
> > > > 
> > > > 
> > > > this should go to some header file and most importantly
> > > If you agree my other points, I'll do this.
> Ok, updated one.
> Reinitialize MCE to avoid MCE non-fatal warning after resume.

ACK.
							Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
