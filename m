Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWBIXZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWBIXZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWBIXZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:25:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58338 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750819AbWBIXZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:25:12 -0500
Date: Fri, 10 Feb 2006 00:24:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060209232453.GC3389@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091245.34833.nigel@suspend2.net> <20060209092555.GB2940@elf.ucw.cz> <200602091926.38666.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602091926.38666.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've begun briefly to have a look at this.
> > >
> > > Part of the problem I have, both with doing incremental patches for
> > > swsusp and with doing a userspace version, is that some of the
> > > fundamentals are redesigned in suspend2. The most important of these is
> > > that we store the metadata in bitmaps (for pageflags) and extents (for
> > > storage) instead of pbes. Do you have thoughts on how to overcome that
> > > issue? Are you willing, for example, to do work on switching swsusp to
> > > use a different method of storing its data?
> >
> > Any changes to userspace are a fair game. OTOH kernel provides linear
> > image to be saved to userspace, and what it uses internally should not
> > be important to userland parts. (And Rafael did some changes in that
> > area to make it more effective, IIRC).
> 
> What about providing the possibility of using the 2 pagesets I use at the 
> moment? I'm not suggesting it should be compulsory, but perhaps an ioctl to 
> say "I want to save a Suspend2 style image"?

I'd prefer to get the low-hanging fruits, first. LZF compression seems
like a first target.

Of course, adding ioctl to do suspend2-style snapshot is possible, but
I fear it will be too intrusive, and would prefer to do it after
getting the simple stuff done. 

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
