Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946010AbWBCWbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946010AbWBCWbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWBCWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:31:05 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:14001 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422690AbWBCWav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:30:51 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 23:41:41 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602031020.46641.nigel@suspend2.net> <20060203131602.GD2972@elf.ucw.cz>
In-Reply-To: <20060203131602.GD2972@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1829667.cgRmIxRPRs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602032341.46043.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1829667.cgRmIxRPRs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 03 February 2006 23:16, Pavel Machek wrote:
> On P=E1 03-02-06 10:20:42, Nigel Cunningham wrote:
> > Hi.
> >
> > On Friday 03 February 2006 08:10, Rafael J. Wysocki wrote:
> > > On machines with less RAM suspend2 will probably be better
> > > preformance-wise, and that may be more important than the flexibility.
> >
> > Ok. So I bit the bullet and downloaded -mm4 to take a look at this
> > interface you're making, and I have a few questions:
>
> Great, thanks.
>
> > - It seems to be hardwired to use swap, but you talk about writing to a
> > network image above. In Suspend2, I just bmap whatever the storage is,
> > and then submit bios to read and write the data. Is anything like that
> > possible with this interface? (Could it be extended if not?)
>
> No, it is not hardwired. There's special swap support, but you do not
> need to use it.
>
> > - Is there any way you could support doing a full image of memory with
> > this approach? Would you take patches?
>
> Doing full image is certainly possible; it is not important if kernel
> does the writing or userspace does it. Taking patches definitely
> depends how they'd look like...

Would you actually do some work on generating them? I'm concerned that I'm=
=20
going to end up putting more work into making patches, only to have you nac=
k=20
them for (what seem to me like) arbitrary reasons. I feel like all you're=20
doing at the moment is pouring cold water on my work. Seeing you put some=20
work into making mileage from the work I've put into Suspend2 would encoura=
ge=20
me a lot. Forgive me if I sound pretty negative - between a couple of month=
s=20
of humid weather, lack of sleep and the event of the last few weeks, I'm no=
t=20
in the best frame of mind at the moment. Perhaps it would be better for me=
=20
just to say "I give full permission for you and Rafael to rip out of Suspen=
d2=20
anything you find useful.", leave it at that and go find another hobby for =
a=20
while.

Regards,

Nigel

> > - Does the data have to be transferred to userspace? Security and
> > efficiency wise, it would seem to make a lot more sense just to be
> > telling the kernel where to write things and let it do bio calls like I=
'm
> > doing at the moment.
>
> As far as I can see, transfering data to userspace and back does not
> really cost much:
>
> pavel@amd:~$ time head -c $[1024*1024*1024] < /dev/zero > /dev/null
> 0.16user 0.27system 0.43 (0m0.439s) elapsed 100.00%CPU
>
> ...2000MB/sec is the limit (thinkpad x32).
> 								Pavel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1829667.cgRmIxRPRs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD412aN0y+n1M3mo0RAuhSAJ9ULqeU5bVx+Bq0q+cUJxWHAB7N5gCbBLVC
lj4hJtElEtOeNB2dp9ADOhQ=
=y/ew
-----END PGP SIGNATURE-----

--nextPart1829667.cgRmIxRPRs--
