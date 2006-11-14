Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966442AbWKNXNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966442AbWKNXNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966457AbWKNXNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:13:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32401 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966442AbWKNXNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:13:13 -0500
Date: Wed, 15 Nov 2006 00:12:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Christian Hoffmann <chrmhoffmann@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Message-ID: <20061114231256.GC2676@elf.ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611142247.55137.chrmhoffmann@gmail.com> <20061114225629.GA2676@elf.ucw.cz> <200611142358.00616.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611142358.00616.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 2006-11-14 23:57:59, Rafael J. Wysocki wrote:
> On Tuesday, 14 November 2006 23:56, Pavel Machek wrote:
> > Hi!
> > 
> > > > > I tried netconsole, and it somehow works, but when suspending it says in
> > > > > an "infinite" loop:
> > > > >
> > > > > unregister_netdevice: waiting for eth2 to become free. Usage count = 1
> > > >
> > > > Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
> > > >
> > > > Rafael
> > > 
> > > I tried that patch, but the last message I see over netconsole (using tg3) is:
> > > Suspending console(s)
> > > and then nothing. Nothing on resume at all :(
> > > 
> > > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume 
> > > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel programmer 
> > > at all, so I might do something wrong or in the wrong place.
> > 
> > Linus has crazy "write some info to CMOS" hack... which should be
> > usable here.
> 
> No, it's i386-only.

Ok, so you could debug it on i386 kernel :-). Actually trying if s2ram
works in 32-bit mode _would_ be interesting.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
