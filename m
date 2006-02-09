Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWBIJ0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWBIJ0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWBIJ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:26:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23256 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030320AbWBIJ0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:26:13 -0500
Date: Thu, 9 Feb 2006 10:25:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060209092555.GB2940@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602082208.56599.nigel@suspend2.net> <20060209000617.GG2654@elf.ucw.cz> <200602091245.34833.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602091245.34833.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning ;-).

> > At one point you said you'd like to work with us, and earlier in the
> > threads you stated that porting suspend2 to userland should be easy.
> > 
> > [I do not think that putting suspend2 into git is useful thing to
> > do. Of course, it is your option; but it seems to me that people
> > likely to use suspend2 are not the kind of people that use git.]
> > 
> > It would be very helpful if you could install uswsusp, then try to
> > make suspend2 run in userland on top of uswsusp interface. Not
> > everything will be possible that way, but it most of features should
> > be doable that way. I'd hate to code yet another splashscreen code,
> > for example...
> 
> I've begun briefly to have a look at this.
> 
> Part of the problem I have, both with doing incremental patches for swsusp
> and with doing a userspace version, is that some of the fundamentals are
> redesigned in suspend2. The most important of these is that we store the
> metadata in bitmaps (for pageflags) and extents (for storage) instead of
> pbes. Do you have thoughts on how to overcome that issue? Are you
> willing, for example, to do work on switching swsusp to use a different
> method of storing its data?

Any changes to userspace are a fair game. OTOH kernel provides linear
image to be saved to userspace, and what it uses internally should not
be important to userland parts. (And Rafael did some changes in that
area to make it more effective, IIRC). 
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
