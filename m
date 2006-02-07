Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWBGXQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWBGXQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWBGXQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:16:42 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:40670 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030242AbWBGXQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:16:41 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 09:13:17 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bojan Smojver <bojan@rexursive.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080814.02894.nigel@suspend2.net> <20060207230510.GF2753@elf.ucw.cz>
In-Reply-To: <20060207230510.GF2753@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1430180.rLTySaaetx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602080913.22003.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1430180.rLTySaaetx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 08 February 2006 09:05, Pavel Machek wrote:
> > > > # cat /sys/power/disk_method
> > > > swsusp uswsusp suspend2
> > > > # echo uswsusp > /sys/power/disk_method
> > > > # echo > /sys/power/state
> > > >=20
> > > > Is there a big problem with that, which I've missed?
> > >=20
> > > Userland suspend is driven by the suspending application which only c=
alls
> > > the kernel to do things it cannot do itself, like freezing (the other)
> > > processes, snapshotting the system etc.  We use the /dev/snapshot
> > > device and the ioctl()s in there, so no sysfs files are needed for th=
at.
> > > It's independent and can coexist with the existing sysfs interface
> > > just fine.
> >=20
> > Yes, but how are you going to get it started from (say) klaptop, which =
only=20
> > knows "echo disk > /sys/power/state" as the way of starting a suspend? =
I'm=20
> > suggesting that we create a means whereby the issue of how to start a=20
> > cycle could be separated from what implementation is used to do the wor=
k.=20
> > That is, a simple extension at the start of the disk specific code that=
=20
> > starts swsusp, uswsusp or suspend2 depending upon what you want. Maybe =
I=20
> > should just prepare a patch.
>=20
> Please do not patch kernel for that.
>=20
> Proper solution is probably creating s2disk program/script, and teach
> kpowersave/klaptop/etc. to just use it. Then s2disk can detect best
> method to use ... and then just do it. You already have suitable
> script, but I'm not sure what its name is.

You have a good point there - the hibernate script is sufficient for the
task. Ok. I'll give up on this idea and consider it their problem for not
using what's provided already.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1430180.rLTySaaetx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6SmRN0y+n1M3mo0RApn6AJ9YnrFdjjOjcH41zsi31x0D6gSF3ACgpQQb
8GXEmZ5wAKCEP6eBvRi+L6Q=
=DbFB
-----END PGP SIGNATURE-----

--nextPart1430180.rLTySaaetx--
