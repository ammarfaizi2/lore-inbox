Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754285AbWKMISV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbWKMISV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbWKMISV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:18:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:62604 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754284AbWKMISU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:18:20 -0500
Date: Mon, 13 Nov 2006 09:15:28 +0100
From: Stefan Seyfried <seife@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20061113081528.GB18022@suse.de>
References: <200611121436.46436.arvidjaar@mail.ru> <20061112145549.GC4371@ucw.cz> <200611130642.18990.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611130642.18990.arvidjaar@mail.ru>
X-Operating-System: openSUSE 10.2 (i586) Beta2, Kernel 2.6.18.2-4-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 13, 2006 at 06:42:15AM +0300, Andrey Borzenkov wrote:
> On Sunday 12 November 2006 17:55, Pavel Machek wrote:
> > On Sun 12-11-06 14:36:41, Andrey Borzenkov wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel
> > > when I switch on the system after suspend to disk. Actually, after kernel
> > > has been loaded, the whole resuming (up to the point I have usable

The most important question:
What filesystem is your /boot on? I'd bet quite some money that it is reiser
or some other journaling FS (not ext3).

> > > desktop again) takes about three time less than the process of loading
> > > kernel + initrd. During loading disk LED is constantly lit. This almost
> > > looks like kernel leaves HDD in some strange state, although I always
> > > assumed HDD/IDE is completely reinitialized in this case.
> >
> > Seems like broken hw, really. No state should survive machine
> > poweroff.

No. Broken FS / crappy GRUB.

> To recap - this never happens upon simple power off; I do not remember this to 

I am pretty sure that it will also happen if you do "updatedb &", wait a
minute and then do a _HARD_ power off.

I am pretty sure that it has nothing to do with the kernel version, just with
the layout of your /boot partition (which of course changes with every kernel
update). In other words: until now, you just have been lucky.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
