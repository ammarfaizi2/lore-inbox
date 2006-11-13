Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932790AbWKMSyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWKMSyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWKMSyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:54:47 -0500
Received: from mx27.mail.ru ([194.67.23.64]:2638 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S932790AbWKMSyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:54:46 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Mon, 13 Nov 2006 21:54:38 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <200611121436.46436.arvidjaar@mail.ru> <200611130642.18990.arvidjaar@mail.ru> <20061113081528.GB18022@suse.de>
In-Reply-To: <20061113081528.GB18022@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611132154.38644.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 13 November 2006 11:15, Stefan Seyfried wrote:
> Hi,
>
> On Mon, Nov 13, 2006 at 06:42:15AM +0300, Andrey Borzenkov wrote:
> > On Sunday 12 November 2006 17:55, Pavel Machek wrote:
> > > On Sun 12-11-06 14:36:41, Andrey Borzenkov wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> > > >
> > > > This is rather funny; in 2.6.19-rc5 grub is *really* slow loading
> > > > kernel when I switch on the system after suspend to disk. Actually,
> > > > after kernel has been loaded, the whole resuming (up to the point I
> > > > have usable
>
> The most important question:
> What filesystem is your /boot on? I'd bet quite some money that it is
> reiser or some other journaling FS (not ext3).
>

there is no /boot, I use single / which is reiser.

> > > > desktop again) takes about three time less than the process of
> > > > loading kernel + initrd. During loading disk LED is constantly lit.
> > > > This almost looks like kernel leaves HDD in some strange state,
> > > > although I always assumed HDD/IDE is completely reinitialized in this
> > > > case.
> > >
> > > Seems like broken hw, really. No state should survive machine
> > > poweroff.
>
> No. Broken FS / crappy GRUB.
>
> > To recap - this never happens upon simple power off; I do not remember
> > this to
>
> I am pretty sure that it will also happen if you do "updatedb &", wait a
> minute and then do a _HARD_ power off.
>
> I am pretty sure that it has nothing to do with the kernel version, just
> with the layout of your /boot partition (which of course changes with every
> kernel update). In other words: until now, you just have been lucky.

The idea is nice; unfortunately it fails to explain the difference 
between 'poweroff' and 'suspend disk' cases. I doubt disk layout is changed 
between them.

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWL9uR6LMutpd94wRAh0NAJ4o2hU4E/BsMOJXPxqX8OSH8OR/nwCfdLPz
DWHM1gAFYTvc9WtyNv+qq08=
=EaDe
-----END PGP SIGNATURE-----
