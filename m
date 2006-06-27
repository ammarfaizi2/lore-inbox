Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932876AbWF0JfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbWF0JfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWF0JfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:35:18 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:55505 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932876AbWF0JfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:35:16 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 19:35:07 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271907.27831.nigel@suspend2.net> <200606271126.28898.rjw@sisk.pl>
In-Reply-To: <200606271126.28898.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9082126.FV47xy7HuM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271935.13261.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9082126.FV47xy7HuM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 19:26, Rafael J. Wysocki wrote:
> > > Now I haven't followed the suspend2 vs swsusp debate very closely, but
> > > it seems to me that your biggest problem with getting this merged is
> > > getting consensus on where exactly this is going. Nobody wants two
> > > different suspend modules in the kernel. So there are two options -
> > > suspend2 is deemed the way to go, and it gets merged and replaces
> > > swsusp. Or the other way around - people like swsusp more, and you are
> > > doomed to maintain suspend2 outside the tree.
> >
> > Generally, I agree, although my understanding of Rafael and Pavel's
> > mindset is that swsusp is a dead dog and uswsusp is the way they want to
> > see things go. swsusp is only staying for backwards compatability. If
> > that's the case, perhaps we can just replace swsusp with Suspend2 and l=
et
> > them have their existing interface for uswsusp. Still not ideal, I agre=
e,
> > but it would be progress.
>
> Well, ususpend needs some core functionality to be provided by the kernel,
> like freezing/thawing processes (this is also used by the STR),
> snapshotting the system memory.  These should be shared with the in-kernel
> suspend, be it swsusp or suspend2.

If I modify suspend2 so that from now on it replaces swsusp, using noresume=
,=20
resume=3D and echo disk > /sys/power/state in a way that's backward compati=
ble=20
with swsusp and doesn't interfere with uswsusp support, would you be happy?=
=20
IIRC, Pavel has said in the past he wishes I'd just do that, but he's not y=
ou=20
of course.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart9082126.FV47xy7HuM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoPvRN0y+n1M3mo0RAsUGAKCSDjNOYevXaHVjSzmrKHmzJiUm8ACgyIon
EicdGrOy4CnzPl9PTkhUedY=
=iWBy
-----END PGP SIGNATURE-----

--nextPart9082126.FV47xy7HuM--
