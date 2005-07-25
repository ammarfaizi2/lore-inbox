Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVGYWI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVGYWI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVGYWI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:08:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261195AbVGYWHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:07:38 -0400
Date: Tue, 26 Jul 2005 00:07:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725220729.GG8684@elf.ucw.cz>
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <d120d500050725081664cd73fe@mail.gmail.com> <20050725165014.B7629@flint.arm.linux.org.uk> <d120d50005072509022ccbdd0a@mail.gmail.com> <20050725171311.D7629@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725171311.D7629@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The problem is that the parent doesn't actually know how many
> > > devices to create nor what to call them, and they're logically
> > > indistinguishable from each other so there's no logical naming
> > > system.
> > 
> > Then we should probably not try to force them into driver model. Have
> > parent device register struct device and when sub-drivers register
> > they could attach class devices (like input devices) directly to the
> > "main" device thus hiding presence of sub-sections of the chip from
> > sysfs completely. My point is that we should not be using
> > class_interface here - its purpose is diferent.
> 
> If you look at _my_ version, you'll notice that it doesn't use the
> class interface stuff.  A previous version of it did, and this seems
> to be what the collie stuff is based upon.
> 
> What I suggest is that the collie folk need to update their driver
> to my version so that we don't have two different forks of the same

Yep, will do, and sorry for the confusion.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
