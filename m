Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752809AbWKLTOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWKLTOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 14:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbWKLTOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 14:14:11 -0500
Received: from mx27.mail.ru ([194.67.23.64]:55326 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1752809AbWKLTOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 14:14:10 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Sun, 12 Nov 2006 22:13:58 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611121436.46436.arvidjaar@mail.ru> <200611121546.46013.arvidjaar@mail.ru> <200611121434.28421.rjw@sisk.pl>
In-Reply-To: <200611121434.28421.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611122213.59709.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 12 November 2006 16:34, Rafael J. Wysocki wrote:
> On Sunday, 12 November 2006 13:46, Andrey Borzenkov wrote:
> > On Sunday 12 November 2006 15:26, Rafael J. Wysocki wrote:
> > > Hi,
> > >
> > > On Sunday, 12 November 2006 12:36, Andrey Borzenkov wrote:
> > > > This is rather funny; in 2.6.19-rc5 grub is *really* slow loading
> > > > kernel when I switch on the system after suspend to disk. Actually,
> > > > after kernel has been loaded, the whole resuming (up to the point I
> > > > have usable desktop again) takes about three time less than the
> > > > process of loading kernel + initrd. During loading disk LED is
> > > > constantly lit. This almost looks like kernel leaves HDD in some
> > > > strange state, although I always assumed HDD/IDE is completely
> > > > reinitialized in this case.
> > >
> > > Can you please see what's in the /sys/power/disk file?
> >
> > {pts/0}% cat /sys/power/disk
> > shutdown
>
> Can you please write "platform" to this file before the suspend and see if
> anything changes?
>

No, nothing changes.

I tested a bit more; I currently have 2.6.18.1, 2.6.18.2 and 2.6.19-rc5 
installed. Booting after "poweroff" is OK from within all versions - there is 
no delay. Resuming after suspend under 2.6.18.x is mostly OK, at least it is 
much less obvious (I had some feeling it may have been "a bit slower" under 
2.6.18.2 but may be it is just illusion). Resuming after suspend under 
2.6.19-rc5 results in noticeable delay and constantly busy HDD LED during 
grub phase.

Yes, it is notebook. I will test Pavel's suggestion later.

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFV3J3R6LMutpd94wRAjBoAJ9UBc0KXM4/8ANCwUn17gbHrhTKawCgiJjg
qdsJw+JV4LLL4mP5hz+NYVI=
=Y1of
-----END PGP SIGNATURE-----
