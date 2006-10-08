Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWJHTlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWJHTlh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWJHTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:41:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24761 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751362AbWJHTlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:41:36 -0400
Date: Sun, 8 Oct 2006 21:41:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: /sys/.../power/state Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061008194124.GB4042@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071916.27315.oliver@neukum.org> <200610071703.24599.david-b@pacbell.net> <200610081524.09946.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610081524.09946.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The power management functions without 
> > > timeout are also exported. For other power control features like
> > > cpu frequency considerable effort has been made to export them to
> > > user space.
> > 
> > Yes, and many of us use the much lighter weight kernel based control
> > models by preference.   Why waste hundreds of Kbytes of userspace for
> > a daemon when a few hundred bytes of kernel code can implement a
> > better and more reactive kernel policy for cpufreq?
> 
> That's an important aspect. How about implementing autosuspend
> first and keeping the sysfs-based suspension for now? If autosuspend

Current sysfs-based suspension allows people to do bad stuff to
drivers, like confusing them, oopsing them, etc. It is so broken that
it can not be fixed. (When I suspend my USB this way, I end up with
dead USB. When I suspend my sound card, I get any soundcard users in
unrecoverable D state.)

Now... you can prove me wrong, but that likely means auditing all the
drivers with suspend() and/or resume() methods. I'm not prepared to do
that work... are you?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
