Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUBCXQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUBCXQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:16:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:59320 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266187AbUBCXPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:15:48 -0500
Date: Tue, 3 Feb 2004 15:14:56 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 016 release
Message-ID: <20040203231455.GB22058@kroah.com>
References: <20040203201359.GB19476@kroah.com> <1075841390.7473.57.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075841390.7473.57.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 10:49:51PM +0200, Martin Schlemmer wrote:
> On Tue, 2004-02-03 at 22:13, Greg KH wrote:
> 
> > 
> > 	  Right now, udevsend and udev are built against klibc (udevsend
> > 	  is only 2.5Kb big), and udevd is linked dynamically against
> > 	  glibc, due to it using pthreads.  This is ok, as udev can
> > 	  still be placed into initramfs and run at early boot, it's
> > 	  only after init starts up that udevsend and udevd will kick
> > 	  in.
> > 
> 
> I am guessing this breaks group names (and not gid's) in
> udev.permissions?  Or was support added to klibc?

Sorry, that should have read something to the effect that the .rpm is
built using klibc, and that udevd can't be build against it yet due to
pthreads being used.

It's entirely possible to build everything against glibc, and then you
get back the group name stuff for the udev.permission file.

thanks,

greg k-h
