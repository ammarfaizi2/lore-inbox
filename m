Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbULGLqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbULGLqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbULGLqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:46:47 -0500
Received: from gprs214-197.eurotel.cz ([160.218.214.197]:31616 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261794AbULGLqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:46:31 -0500
Date: Tue, 7 Dec 2004 12:46:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Message-ID: <20041207114615.GA1356@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine> <20041205211823.GD1012@elf.ucw.cz> <1102374924.13483.9.camel@tyrosine> <20041207094439.GC1469@elf.ucw.cz> <1102419597.13483.33.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102419597.13483.33.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > -
> > > +extern dev_t swsusp_resume_device;
> > >  
> > >  static int noresume = 0;
> > >  char resume_file[256] = CONFIG_PM_STD_PARTITION;
> > 
> > Move it to include/linux/suspend.h
> 
> swsusp_resume_device? Ok.

Yes.

> > > +        p = memchr(buf, '\n', n);
> > > +        len = p ? p - buf : n;
> > > +
> > > +        if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
> > > +                res = MKDEV(maj, min);
> > > +                if (maj == MAJOR(res) && min == MINOR(res)) {
> > 
> > You mkdev, than test that MKDEV worked? Could you add a comment why
> > its needed?
> 
> That's just cut and pasted from name_to_dev_t - I assumed there was some
> subtlety going on there.

Ok, maybe there's some subtlety ;-). If someone knows, please
comment...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
