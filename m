Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVAMDyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVAMDyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVAMDyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:54:00 -0500
Received: from grendel.firewall.com ([66.28.58.176]:49055 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261424AbVAMDxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:53:37 -0500
Date: Thu, 13 Jan 2005 04:53:31 +0100
From: Marek Habersack <grendel@caudium.net>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113035331.GC9176@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050113032506.GB1212@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20050113032506.GB1212@redhat.com>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2005 at 10:25:06PM -0500, Dave Jones scribbled:
[snip]
>  > Whatever. I happen to believe in openness, and vendor-sec does not. It=
's
>  > that simple.
>=20
> That openness comes at a price. I don't need to bore you with
> analogies, as you know as well as I do how wide and far Linux
> is deployed these days, but doing this openly is just irresponsible.
>
> Someone malicious on getting the announcement of a new kernel.org release
> gets told exactly where the hole is and how to exploit it.
> All they'll need to do is find a target running a vendor kernel before
> updates get deployed.  Whilst this is true to a certain degree
> today, as not everyone deploys security updates in a timely manner
> (some not at all), things can only get worse.
That might be, but note one thing: not everybody runs vendor kernels (for v=
arious
reasons). Now see what happens when the super-secret vulnerability (with
vendor fixes) is described in an advisory. A person managing a park of mach=
ines=20
(let's say 100) with custom, non-vendor, kernels suddenly finds out that th=
ey=20
have a buggy kernel and 100 machines to upgrade while the exploit and the
description of the vuln are out in the wild. They have to port their
custom stuff to the new kernel, compile it, test it (at least a bit), deploy
on 100 machines and pray it doesn't break. During all that time (and the
whole process won't take a day or even two) the evil guys are far ahead of
the poor bastard managing the 100 machines (since all they need is one
exploit which will work on any of our admin's machines). One other factor=
=20
that makes it hard for such a person to apply the patches is simply that th=
ere=20
is no single place to find the security patches in. He goes to securityfocu=
s.com,=20
for instance, and what does he find? A nice description of the vulnerabilit=
y, a
discussion, a list of affected kernel versions and credits which usually
list vendor advisories and kernel versions and very rarely a link to an
archived mail message or a webpage with the patch. Hoping he'll find the
fixes in the vendor kernels, he goes to download source packages from SuSe,
RedHat or Trustix, Debian, Ubuntu, whatever and discovers that it is as easy
to find the patch there as it is to fish it out of the vanilla kernel patch
for the new version. Frustrating, isn't it? Not to mention that he might
need to backport the fix, if he runs an earlier version of the kernel.
And now assume that everything is as extremely open as Linus says - the
admin has the same access to the exact information the vendors on vendor-sec
have, together with the same fix they have (in form of a simple patch
available without fishing for it all over the place). He starts the race
with the bad guys exactly at the same time they start running looking for
the vulnerable machines on the 'Net. Priceless, IMHO.=20
I guess that, contrary to what you've just said above, hiding the
information is irresponsible.
Having said that, I don't think everything should be as extremely open as
Linus would want it to see, but rather the way he proposed (and which many
folks agreed to) with the 5-day (or so) embargo for the advisory release and
with the patch(es)/discussion openly available to anyone interested (based
on the premise that most people learn about vulnerabilities not from
security lists but from security bulletins, tech news sites, user forums et=
c.)

best regards,

marek

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5fC7q3909GIf5uoRAtPiAJ9vBnEOU2cUVS5aK4f/N7wXJPyVFgCfRt2Q
332boBFnxeuwYEPChm5h16g=
=u/zN
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
