Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751936AbWCAX3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWCAX3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWCAX3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:29:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:20452 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751936AbWCAX3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:29:34 -0500
Subject: Re: [PATCH] leave APIC code inactive by default on i386
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20060301225103.GE1440@redhat.com>
References: <43D03AF0.3040703@us.ibm.com>
	 <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
	 <20060301043353.GJ28434@redhat.com>
	 <1141248546.30185.44.camel@localhost.localdomain>
	 <20060301221404.GA1440@redhat.com>
	 <1141253258.30185.60.camel@localhost.localdomain>
	 <20060301225103.GE1440@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f4/Czz95gw4tY4JRNSFB"
Date: Wed, 01 Mar 2006 15:29:31 -0800
Message-Id: <1141255771.30185.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f4/Czz95gw4tY4JRNSFB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-01 at 17:51 -0500, Dave Jones wrote:
> On Wed, Mar 01, 2006 at 02:47:38PM -0800, Darrick J. Wong wrote:
>  > On Wed, 2006-03-01 at 17:14 -0500, Dave Jones wrote:
>  >=20
>  > > In light of Matthew's comments in this thread though, I'm also wonde=
ring
>  > > if we can now get by without this diff, and just enable it by defaul=
t now
>  > > that the kernel respects that the BIOS and leaves it alone if it's b=
een
>  > > disabled.
>  >=20
>  > Actually, it seems that there are Lenovo ThinkCenter P4 machines with
>  > buggy BIOSes that tell us that we can enable the APIC ... but doing so
>  > eventually causes the system to hang.  Granted, the Google-recommended
>  > fixes are "noapic" or "Update the BIOS", but perhaps it would be best =
to
>  > leave it off _except_ for the few cases where we know that we need it.
>  >=20
>  > (Then again, the correct solution in this case is to fix the BIOS...)
>=20
> Indeed. And also blacklist the bad ones with DMI entries.

Yeah.  Since the kernel honors the BIOS's APIC settings, we might as
well enable the APIC code by default.

--D

--=-f4/Czz95gw4tY4JRNSFB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEBi5ba6vRYYgWQuURAs67AJ99ZvNEAk/zXkjg+ETUxKT8v1riQQCdGPML
diLZEuOdDFflo571bE97u3Q=
=6HT8
-----END PGP SIGNATURE-----

--=-f4/Czz95gw4tY4JRNSFB--

