Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292718AbSBZTRL>; Tue, 26 Feb 2002 14:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292725AbSBZTQy>; Tue, 26 Feb 2002 14:16:54 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:5896 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S292728AbSBZTQj>;
	Tue, 26 Feb 2002 14:16:39 -0500
Date: Tue, 26 Feb 2002 20:16:26 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI Watchdog detected LOCKUP
Message-ID: <20020226191626.GA11283@paradigm.rfc822.org>
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org> <3C7BDC57.A835D657@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <3C7BDC57.A835D657@zip.com.au>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2002 at 11:04:55AM -0800, Andrew Morton wrote:
> > __block_prepare_write: zeroing uptodate buffer!
>=20
> Yup.   This happens when the disk fills up.  Andrea and I were
> discussing it over the weekend.   There's a new patch in the -aa
> kernels which doesn't quite fix it :(
>=20
> We'll fix it in 2.4.19-pre somehow.  It's possible that this problem
> causes a chnuk of zeroes to be written into the file when you hit
> ENOSPC, which is rather rude.  But your file was truncated anyway.

I dont think the machine had full filesystems at all.

> SCSI error recovery deadlocked.
>=20
> Now it's *just* conceivable that the __block_prepare_write() problem
> caused a junk request to be sent down to the driver, which caused
> the driver to enter recovery, which it then screwed up.   But I
> doubt it.
>=20
> It's also conceivable that the NMI watchdog code itself caused
> problems also.   Back in the days when it was permanently enabled,
> some machines kept going silly until nmi watchdog was enabled.

I have seen a lot of deadlocks on these machines for the last months - I
never got ANY output - Nothing in the syslog, no oops. I am running
now with the nmi_watchdog for 4 weeks and have seen 10-15 crashes on 2
machines with no output. This was the first deadlock with some output=20
at all which is very frustrating.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8e98KUaz2rXW+gJcRAnkCAJ9NK+N46JzJjipoRt1VzVjHibmyLgCgksJU
QSKBT+f7V7nynlXuFdSvrAs=
=bS7Q
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
