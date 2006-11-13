Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753849AbWKMDmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbWKMDmX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 22:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbWKMDmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 22:42:23 -0500
Received: from mx2.mail.ru ([194.67.23.122]:32807 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1753849AbWKMDmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 22:42:22 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Mon, 13 Nov 2006 06:42:15 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611121436.46436.arvidjaar@mail.ru> <20061112145549.GC4371@ucw.cz>
In-Reply-To: <20061112145549.GC4371@ucw.cz>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611130642.18990.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 12 November 2006 17:55, Pavel Machek wrote:
> On Sun 12-11-06 14:36:41, Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel
> > when I switch on the system after suspend to disk. Actually, after kernel
> > has been loaded, the whole resuming (up to the point I have usable
> > desktop again) takes about three time less than the process of loading
> > kernel + initrd. During loading disk LED is constantly lit. This almost
> > looks like kernel leaves HDD in some strange state, although I always
> > assumed HDD/IDE is completely reinitialized in this case.
>
> Seems like broken hw, really. No state should survive machine
> poweroff.
>

Well, we do have NVRAM do not we?

> Is it notebook?
>

Yes.

> Can you try to unplug system for a few minutes / unplug battery if
> notebook to see if it helps?

No. I unplugged power, removed battery and left it over night. Today morning 
it has shown exactly the same behavior upon resuming (well, upon power-on 
after suspend to disk :))

To recap - this never happens upon simple power off; I do not remember this to 
happen upon suspend to disk until 2.6.19 (I won't claim it never happened, 
just that I do not remember it). This happens consistently in 2.6.19-rc5. I 
am very curious which hardware issue may have such pattern. And in any case 
this does smell like regression (earlier version not triggering this HW issue 
if any)

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFV+maR6LMutpd94wRAmhxAKDCZvzoUtqQguQL1+WmdT/wi3Y3RACgnXep
ra/Qr0wUO43MTAZB2qGWiS0=
=pICz
-----END PGP SIGNATURE-----
