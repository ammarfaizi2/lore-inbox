Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291711AbSBNPGU>; Thu, 14 Feb 2002 10:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291712AbSBNPGH>; Thu, 14 Feb 2002 10:06:07 -0500
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:8456 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S291711AbSBNPFt>;
	Thu, 14 Feb 2002 10:05:49 -0500
Date: Thu, 14 Feb 2002 15:05:43 +0000
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fun with OOM on 2.4.18-pre9
Message-ID: <20020214150543.GA13788@amphibian.dyndns.org>
In-Reply-To: <200202141456.IAA24921@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <200202141456.IAA24921@tomcat.admin.navo.hpc.mil>
User-Agent: Mutt/1.3.27i
From: toad <mtoseland@cableinet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2002 at 08:56:10AM -0600, Jesse Pollard wrote:
> toad <mtoseland@cableinet.co.uk>:
> >=20
> > I do a make -j bzImage
> > I have 2 large processes (Kaffe) running in the background. They are
> > driven by scripts like this:
> >=20
> > while true;
> > do su freenet -c java freenet.node.Main;
> > done
> >=20
> > I have 512MB of RAM and no swap on 2.4.18-pre9.
> > Kernel eventually slows to a near complete halt, and starts killing
> > processes.
> > It kills Kaffe several times
> > Out of Memory: Killed process xyz (Kaffe)
> > (no I don't have logs, sorry)
> > Each time it's a different pid, having respawned from its parent
> > process. Then later, it apparently becomes unkillable - each time it
> > respawns it is *the same PID*. VT switching works, but otherwise the
> > system is unresponsive. It is not clear whether the make -j is still
> > running. Immediately before this, it did the same thing with dictd, but
> > eventually got around to Kaffe. After a fairly long wait I rebooted with
> > the reset switch.
> >=20
> > Any more information useful? Is this known behaviour?
>=20
> Known behaviour - ie. don't do that.
>=20
> On most systems a "make -j4", or 6, or even 8 will work. But SOMETHING has
> to give after memory fills up. The number of processes to use for -j
> depends on the system. On mine (256MB, dual pentium pro) I don't do more
> than 6, and 4 works best (lets me run solitare too).
Isn't that what the OOM killer is for?
>=20
> -------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: pollard@navo.hpc.mil
>=20
> Any opinions expressed are solely my own.

--=20
The road to Tycho is paved with good intentions

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8a9JH9dS6LLJqPpURAvYVAJ4lNcl2/iD3O0qh4sqpL6w6uHDgzwCgmUQ7
aH+iMzWVGYlEFeYUgxLnUr0=
=bWvQ
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
