Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWCSMA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWCSMA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 07:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWCSMA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 07:00:56 -0500
Received: from woodchuck.digriz.org.uk ([217.147.82.209]:34441 "EHLO
	woodchuck.digriz.org.uk") by vger.kernel.org with ESMTP
	id S1751489AbWCSMAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 07:00:55 -0500
Date: Sun, 19 Mar 2006 12:00:47 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-ID: <20060319120047.GA26018@inskipp.digriz.org.uk>
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org> <200603190134.01833.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <200603190134.01833.kernel-stuff@comcast.net>
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Parag Warudkar <kernel-stuff@comcast.net> [20060319 01:34:01 -0500]:
>
> On Saturday 18 March 2006 19:53, Andrew Morton wrote:
> > I might stick a once-off WARN_ON() in there so someone gets in
> > and works out why we keep on having to graft mysterious null-pointer
> > avoidances into cpufreq.
> cpufreq_conservative should be marked broken on SMP - I have used it on U=
P=20
> boxes without trouble but I can't even safely modprobe it on SMP - it nea=
rly=20
> ate my filesystem. =20
>=20
> And there seem to be multiple different problems with it - I get differen=
t=20
> oopses depending upon whether or not I have loaded it before or after the=
=20
> ondemand module.  Weird enough - cpufreq_conservative shares much of it's=
=20
> code with cpufreq_ondemand, which works without any problem.=20
>=20
Well its drifted a bit, however I submitted a number of patches here about=
=20
two weeks ago to bring it back into line and hopefully make it HOTPLUG safe.

The new set of patches pretty much make conservative's codebase identical t=
o=20
ondemands....as no one has posted back having used these or anything what a=
m=20
I to do?!

> Let me know if anyone has objection to marking cpufreq_conservative=20
> depends !SMP - I am planning to submit  a patch soon.
>=20
Doesn't bother me, what does is no one is trying to updates to conservative=
=20
before deciding to declare it borked?

Hey ho....

Alex

> Parag

--=20
 _______________________________________=20
/ Misfortunes arrive on wings and leave \
\ on foot.                              /
 ---------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEHUfvNv5Ugh/sRBYRAgyUAKCDNkdz5aq2oaxvPnyEdNkO9xIrkQCfUGyD
sJYQLGowT9uMCdxunDfv1Jk=
=Vvsm
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
