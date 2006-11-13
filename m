Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933129AbWKMW7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbWKMW7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933131AbWKMW7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:59:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:65464 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933129AbWKMW7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:59:16 -0500
Date: Mon, 13 Nov 2006 23:55:00 +0100
From: Stefan Seyfried <seife@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20061113225500.GF2760@suse.de>
References: <200611121436.46436.arvidjaar@mail.ru> <200611130642.18990.arvidjaar@mail.ru> <20061113081528.GB18022@suse.de> <200611132154.38644.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611132154.38644.arvidjaar@mail.ru>
X-Operating-System: openSUSE 10.2 (i586) Beta2, Kernel 2.6.18.2-4-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 09:54:38PM +0300, Andrey Borzenkov wrote:
> Hash: SHA1
> 
> On Monday 13 November 2006 11:15, Stefan Seyfried wrote:
> > The most important question:
> > What filesystem is your /boot on? I'd bet quite some money that it is
> > reiser or some other journaling FS (not ext3).
> >
> 
> there is no /boot, I use single / which is reiser.

ok, so your /boot is on reiser. Q.E.D.

> > I am pretty sure that it will also happen if you do "updatedb &", wait a
> > minute and then do a _HARD_ power off.
> >
> > I am pretty sure that it has nothing to do with the kernel version, just
> > with the layout of your /boot partition (which of course changes with every
> > kernel update). In other words: until now, you just have been lucky.
> 
> The idea is nice; unfortunately it fails to explain the difference 
> between 'poweroff'

filesystem cleanly unmounted

> and 'suspend disk'

filesystem unclean.

> cases. I doubt disk layout is changed 
> between them.

Try the "updatedb &, then _HARD_ poweroff" test described above. It will take
long to load grub afterwards.

-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
