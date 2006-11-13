Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933154AbWKMXNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbWKMXNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933156AbWKMXNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:13:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:12248 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S933154AbWKMXNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:13:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Tue, 14 Nov 2006 00:11:09 +0100
User-Agent: KMail/1.9.1
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
References: <200611121436.46436.arvidjaar@mail.ru> <200611132154.38644.arvidjaar@mail.ru> <20061113225500.GF2760@suse.de>
In-Reply-To: <20061113225500.GF2760@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140011.10093.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13 November 2006 23:55, Stefan Seyfried wrote:
> On Mon, Nov 13, 2006 at 09:54:38PM +0300, Andrey Borzenkov wrote:
> > Hash: SHA1
> > 
> > On Monday 13 November 2006 11:15, Stefan Seyfried wrote:
> > > The most important question:
> > > What filesystem is your /boot on? I'd bet quite some money that it is
> > > reiser or some other journaling FS (not ext3).
> > >
> > 
> > there is no /boot, I use single / which is reiser.
> 
> ok, so your /boot is on reiser. Q.E.D.
> 
> > > I am pretty sure that it will also happen if you do "updatedb &", wait a
> > > minute and then do a _HARD_ power off.
> > >
> > > I am pretty sure that it has nothing to do with the kernel version, just
> > > with the layout of your /boot partition (which of course changes with every
> > > kernel update). In other words: until now, you just have been lucky.
> > 
> > The idea is nice; unfortunately it fails to explain the difference 
> > between 'poweroff'
> 
> filesystem cleanly unmounted
> 
> > and 'suspend disk'
> 
> filesystem unclean.
> 
> > cases. I doubt disk layout is changed 
> > between them.
> 
> Try the "updatedb &, then _HARD_ poweroff" test described above. It will take
> long to load grub afterwards.

Alternatively, you can use a recent -mm kernel with the bdevs freezing patch
and see if that helps GRUB. ;-)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
