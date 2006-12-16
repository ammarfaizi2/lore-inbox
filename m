Return-Path: <linux-kernel-owner+w=401wt.eu-S1030817AbWLPJFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030817AbWLPJFu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 04:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030821AbWLPJFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 04:05:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4126 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030817AbWLPJFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 04:05:48 -0500
Date: Sat, 16 Dec 2006 09:05:32 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061216090532.GF4049@ucw.cz>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com> <Pine.LNX.4.64.0612131259260.5718@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612131259260.5718@woody.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Seriously, though, please please pretty please do not allow a facility
> > for "going through a simple interface to get accesses to irqs and
> > memory regions" into the mainline kernel, with or without toy ISA
> > examples.
> 
> I do agree.
> 
> I'm not violently opposed to something like this in practice (we've 
> already allowed it for USB devices), but there definitely needs to be a 
> real reason that helps _us_, not just some ass-hat vendor that looks for a 
> way to avoid open-sourcing their driver.
> 
> If there are real and valid uses (and as mentioned, I actually think that 
> the whole graphics-3D-engine-thing is such a use) where a kernel driver 
> simply doesn't work out well, or where there are serious tecnical reasons 
> why it wants to be in user space (and "stability" is not one such thing: 
> if you access hardware directly in user space, and your driver is buggy, 
> the machine is equally deal, and a hell of a lot harder to control to 
> boot).

Well.. it is easier to debug in userspace. While bad hw access can
still kill the box, bad free() will not, and most bugs in early
developent are actually of 2nd kind.
						Pavel
-- 
Thanks for all the (sleeping) penguins.
