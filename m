Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWBGWnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWBGWnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBGWnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:43:14 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:55003 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932431AbWBGWnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:11 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 08:13:56 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Bojan Smojver <bojan@rexursive.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602071105.45688.nigel@suspend2.net> <200602071609.05676.rjw@sisk.pl>
In-Reply-To: <200602071609.05676.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3228044.bnQDT4BSrC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602080814.02894.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3228044.bnQDT4BSrC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 08 February 2006 01:09, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Tuesday 07 February 2006 02:05, Nigel Cunningham wrote:
> > On Tuesday 07 February 2006 10:44, Pavel Machek wrote:
> > > Are you Max Dubois, second incarnation or what?
> > >
> > > > Well, given that the kernel suspend is going to be kept for a=20
while,
> > > > wouldn't it be better if it was feature full? How would the users=20
be
> > > > at
> > >
> > >                                               =20
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > > a disadvantage if they had better kernel based suspend for a while,
> > >
> > > ~~~~~~~~~~~~~~~~
> > >
> > > > followed by u-beaut-cooks-cleans-and-washes uswsusp? That's the=20
part I
> > > > don't get...
> > >
> > > *Users* would not be at disadvantage, but, surprise, there's one=20
thing
> > > more important than users. Thats developers, and I can guarantee you
> > > that merging 14K lines of code just to delete them half a year later
> > > would drive them crazy.
> >=20
> > It would more be an ever-changing interface that would drive them=20
crazy. So=20
> > why don't we come up with an agreed method of starting a suspend and=20
> > starting a resume that they can use, without worrying about whether=20
> > they're getting swsusp, uswsusp or Suspend2? /sys/power/state seems the=
=20
> > obvious choice for this. An additional /sys entry could perhaps be used=
=20
to=20
> > modify which implementation is used when you echo disk=20
> /sys/power/state=20
> > - something like
> >=20
> > # cat /sys/power/disk_method
> > swsusp uswsusp suspend2
> > # echo uswsusp > /sys/power/disk_method
> > # echo > /sys/power/state
> >=20
> > Is there a big problem with that, which I've missed?
>=20
> Userland suspend is driven by the suspending application which only calls
> the kernel to do things it cannot do itself, like freezing (the other)
> processes, snapshotting the system etc.  We use the /dev/snapshot
> device and the ioctl()s in there, so no sysfs files are needed for that.
> It's independent and can coexist with the existing sysfs interface
> just fine.

Yes, but how are you going to get it started from (say) klaptop, which only=
=20
knows "echo disk > /sys/power/state" as the way of starting a suspend? I'm=
=20
suggesting that we create a means whereby the issue of how to start a=20
cycle could be separated from what implementation is used to do the work.=20
That is, a simple extension at the start of the disk specific code that=20
starts swsusp, uswsusp or suspend2 depending upon what you want. Maybe I=20
should just prepare a patch.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3228044.bnQDT4BSrC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6RuqN0y+n1M3mo0RAnqPAKDOvdxx7R8hGfYMWSuIR3PNGVTpXwCgpllp
GYJtYViBrERCI/7pT4/GusM=
=Z/KS
-----END PGP SIGNATURE-----

--nextPart3228044.bnQDT4BSrC--
