Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWGFK0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWGFK0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWGFK0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:26:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48344 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030201AbWGFK0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:26:52 -0400
Date: Thu, 6 Jul 2006 12:26:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       klibc@zytor.com
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Message-ID: <20060706102635.GF5303@elf.ucw.cz>
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <200607061037.11177.ncunningham@linuxmail.org> <44AC5F5C.7070907@zytor.com> <200607061145.08590.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607061145.08590.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ah. So it's still valid to have resume= and noresume on the commandline,
> > > and klibc greps /proc/cmdline?
> >
> > Correct.
> >
> > > So, for Suspend2, would I be ok just leaving people to add the echo
> > >
> > >>/proc/suspend2/do_resume, as we currently do for initrds and initramfses?
> >
> > Well, presumably you want to adjust kinit so that it invokes
> > /proc/suspend2/do_resume, instead of or in addition to
> > /sys/power/resume; see usr/kinit/resume.c (the code should be bloody
> > obvious, I hope...)
> 
> It is.
> 
> Is there a klibc howto somewhere? I tried googling for 'klibc howto', reading 
> the files in Documentation/ and browsing your klibc mailing list archive 
> before asking!
> 
> What I'm wondering specifically is: Say a user needs to run some commands to 
> set up access to encrypted storage before they can resume. At the moment, 
> we'd tell them to put these commands and the echo > do_resume in their 
> linuxrc (or init) script prior to mounting their root filesystem. Forgive me 
> if I'm asking a stupid question but it's not immediately obvious to me how 
> they would now do that. I'd much rather follow a simple howto than
> spend a 

Same way as they did it before....? klibc is supposed to be
backward-compatible, as far as userland can tell.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
