Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWBCAYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWBCAYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBCAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:24:12 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:18903 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964826AbWBCAYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:24:10 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 10:20:42 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602030727.48855.nigel@suspend2.net> <200602022310.40783.rjw@sisk.pl>
In-Reply-To: <200602022310.40783.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2443538.9Pbb8D4Cdm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602031020.46641.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2443538.9Pbb8D4Cdm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 03 February 2006 08:10, Rafael J. Wysocki wrote:
> I was referring to the (not so far) future situation when we have
> compression in the userland suspend/resume utilities.  The times of
> writing/reading the image will be similar to yours and IMHO it's usually
> possible to free 1/2 of RAM in a box with 512+ MB of RAM at a little cost
> as far as the responsiveness after resume is concerned.  Thus on machines
> with 512+ MB of RAM
> both solutions will give similar results performance-wise, but the
> userland-driven suspend gives you much more flexibility wrt what you can
> do with the image (eg. you can even send it over the network if need be).
>
> On machines with less RAM suspend2 will probably be better
> preformance-wise, and that may be more important than the flexibility.

Ok. So I bit the bullet and downloaded -mm4 to take a look at this interfac=
e=20
you're making, and I have a few questions:

=2D It seems to be hardwired to use swap, but you talk about writing to a=20
network image above. In Suspend2, I just bmap whatever the storage is, and=
=20
then submit bios to read and write the data. Is anything like that possible=
=20
with this interface? (Could it be extended if not?)
=2D Is there any way you could support doing a full image of memory with th=
is=20
approach? Would you take patches?
=2D Does the data have to be transferred to userspace? Security and efficie=
ncy=20
wise, it would seem to make a lot more sense just to be telling the kernel=
=20
where to write things and let it do bio calls like I'm doing at the moment.
=2D In your Documentation file, you say say opening /dev/snapshot for readi=
ng is=20
done when suspending. Shouldn't that be open read for resume and write for=
=20
suspend?

I'm not saying I'm going to get carried away trying to port Suspend2 to=20
userspace. Just tentatively exploring. But if I did decide to port it, my=20
default position would be to seek not to drop a single feature. I hope that=
's=20
not too unreasonable!

NIgel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2443538.9Pbb8D4Cdm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4qHeN0y+n1M3mo0RAh6/AKCufxD2mKEqAefwOLsWwcSiV9AuPACfZ6GA
G0vwUtnoWFbSK2j+H+O09lY=
=/b98
-----END PGP SIGNATURE-----

--nextPart2443538.9Pbb8D4Cdm--
