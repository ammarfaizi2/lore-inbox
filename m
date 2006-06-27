Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWF0XhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWF0XhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWF0XhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:37:22 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:2741 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932183AbWF0XhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:37:21 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend2 - Request for review & inclusion in -mm
Date: Wed, 28 Jun 2006 09:37:14 +1000
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz>
In-Reply-To: <20060627133321.GB3019@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3502736.ZcyVRfxyJ4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606280937.17906.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3502736.ZcyVRfxyJ4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 23:33, Pavel Machek wrote:
> Hi!
>
> > I'd like, at long last, to submit Suspend2 for review and inclusion in
> > -mm.
> >
> > All going well, I'll shortly be sending a number of sets of patches,
> > which together represent the whole of suspend2 as it stands at the
> > moment. Those of you who've looked at Suspend2 code before will see that
> > there are far fewer changes outside of kernel/power than there have been
> > in the past. In some cases, this is because we were early adopters of
> > some functionality that has now been merged, and in others because
> > better, less intrusive ways have been found of doing some things.
> >
> > Some of the advantages of suspend2 over swsusp and uswsusp are:
> >
> > - Speed (Asynchronous I/O and readahead for synchronous I/O)
>
> uswsusp should be able to match suspend2's speed. It can do async I/O,
> etc...
>
> > - Well tested in a wide range of configurations
> > - Supports multiple swap partitions and files
>
> Doable in userspace with uswsusp.

Doable !=3D done.

> > - Supports writing to ordinary files and raw devices.
>
> Should be doable in userspace with uswsusp, too; I actually had raw
> devices version at one point.
>
> > - Userspace helpers for user interface and storage management.
>
> Better put it completely in userspace :-).
>
> > - Support for cancelling the suspend at any point while the image is
> > being written (can be disabled)
>
> uswsusp does that... or did that at some point.
>
> > - Can be configured and reconfigured without rebooting.
>
> No problem for uswsusp.
>
> > - Scripting support
>
> What does that mean?

At boot time, having done anything you need to do to set up access to the=20
image storage, you can:

cat /proc/suspend2/image_exists

The result shows 0 if no image exists, or 1 and a couple of extra lines of=
=20
detail from the header if an image does exist (or -1 if there's no=20
recognisable signature).

You can also echo 0 > /proc/suspend2/image_exists to invalidate an image.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart3502736.ZcyVRfxyJ4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEocEtN0y+n1M3mo0RAtAlAJ0SX5KnpTVBS2zHq3UcoF1+Jydk/gCgjkLi
xXFg2XjmB4ZPaaAwfpqRzCw=
=T/vq
-----END PGP SIGNATURE-----

--nextPart3502736.ZcyVRfxyJ4--
