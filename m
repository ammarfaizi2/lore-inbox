Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVEBR7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVEBR7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEBR7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:59:42 -0400
Received: from mx3.mail.ru ([194.67.23.149]:36123 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S261631AbVEBR6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:58:54 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Date: Mon, 2 May 2005 21:58:47 +0400
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200505012021.56649.arvidjaar@mail.ru> <20050502023047.4c965f3e.akpm@osdl.org> <200505021618.44007.arvidjaar@mail.ru>
In-Reply-To: <200505021618.44007.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1283588.mhWGY9AFWL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505022158.48713.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1283588.mhWGY9AFWL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 02 May 2005 16:18, Andrey Borzenkov wrote:
> On Monday 02 May 2005 13:30, Andrew Morton wrote:
> > Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > >  > It's pretty simple to convert khubd to use the kthread API.=20
> > >  > Something like this (untested):
> > >
> > >  Something strange is going on with this patch.
> > >
> > >  insmod usbcore; insmod uhci-hcd works as expected, finds out all
> > > devices, triggers hotplug etc. But
> > >
> > >  {pts/2}% sudo insmod ./usbcore.ko
> > >  {pts/2}% sudo mount -t usbfs -o devmode=3D0664,devgid=3D43 none
> > > /proc/bus/usb {pts/2}% sudo modprobe usb-interface
> > >
> > >  results in
> > >
> > > ...
> > >  uhci_hcd 0000:00:1f.2: Unlink after no-IRQ?  Controller is probably
> > > using the wrong IRQ.
> > >  usb 1-1: khubd timed out on ep0out
> >
> > Does this only happen when the convert-khubd-to-kevent patch is applied?
=2E..
> (I am
> downloading vanilla kernel + -mm to give it a try).
>

I cannot reproduce it on 2.6.12-rc3[-mm2], with or without patch in this=20
thread. It looks like whatever it was it was fixed in the meantime.

regards

=2Dandrey

--nextPart1283588.mhWGY9AFWL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCdmpYR6LMutpd94wRAprUAKCtmvqE/vQh80e69Y2lc/BBXcSPoACfW+6M
T4aBFi62bKJxFgp7NO7bHBA=
=+Fs2
-----END PGP SIGNATURE-----

--nextPart1283588.mhWGY9AFWL--
