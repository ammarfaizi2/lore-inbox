Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWJHVSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWJHVSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWJHVSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:18:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13006 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751461AbWJHVSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:18:33 -0400
Date: Sun, 8 Oct 2006 23:18:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Keith Chew <keith.chew@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIOS THRM-Throttling and driver timings
Message-ID: <20061008211821.GA4280@elf.ucw.cz>
References: <20f65d530610030729o42658bd6hcc204f8deac4a33e@mail.gmail.com> <1159886437.2891.532.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159886437.2891.532.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We have a motherboard that has Thermal Throttling in the BIOS (which
> > we cannot disable). This causes the CPU usage to go up and down when
> > the CPU temperature reaches (and stays around) the Throttling
> > temperature point.
> > 
> > What we would like to know is whether this will affect the timings in
> > drivers, eg the wireless drivers we are using. What can we check in
> > drivers' code that will tell us that its operations may be affected
> > the throttling?
> > 
> > In the past few days, we noticed that some of the linux units we
> > deployed freezes after deveral hours of operation, we are now trying
> > to reproduce the problem in our test environment. Some insight on the
> > affect of throttling will help us narrow down the search.

> in general linux should be ok with this happening. However for specific
> cases... you'll need to provide more information; you're not
> mentioning

Really? AFAICT P4 will happily slow down behind our backs, making at
least udelays() with interrupts disabled sleep for too long.

> (also: if you actually HIT throttling, there is something very very
> wrong; you're not supposed to hit that unless the fan is defective, but
> never in "normal" healthy operation. If you do hit it without hardware
> defects then there is most likely a fundamental airflow problem you'll
> want to fix urgently)

At least in toshiba notebook, I was hitting thermal throttling even
through both fans were okay. There are many misdesigned machines out
there, I fear.
								Pavel 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
