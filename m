Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966435AbWKNW4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966435AbWKNW4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966434AbWKNW4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:56:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65465 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966435AbWKNW4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:56:47 -0500
Date: Tue, 14 Nov 2006 23:56:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Message-ID: <20061114225629.GA2676@elf.ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611140008.55059.rjw@sisk.pl> <200611142247.55137.chrmhoffmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611142247.55137.chrmhoffmann@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I tried netconsole, and it somehow works, but when suspending it says in
> > > an "infinite" loop:
> > >
> > > unregister_netdevice: waiting for eth2 to become free. Usage count = 1
> >
> > Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
> >
> > Rafael
> 
> I tried that patch, but the last message I see over netconsole (using tg3) is:
> Suspending console(s)
> and then nothing. Nothing on resume at all :(
> 
> Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume 
> (radeon_pm.c) didn't help: I don't see them. But I am not a kernel programmer 
> at all, so I might do something wrong or in the wrong place.

Linus has crazy "write some info to CMOS" hack... which should be
usable here.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
