Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313504AbSDJSmi>; Wed, 10 Apr 2002 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313506AbSDJSmh>; Wed, 10 Apr 2002 14:42:37 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:36879 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S313504AbSDJSmd>;
	Wed, 10 Apr 2002 14:42:33 -0400
Date: Wed, 10 Apr 2002 20:42:31 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Generic access to firmware environment variables
Message-ID: <20020410184231.GC8136@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've developed a driver to access environment variables on Alpha
computers from userspace through procfs some time ago. These
days, I updated the driver. While doing this, I also looked
at other architectures; some of them also do have some kind
of environment variables in firmware:

	Alphas			-	SRM firmware
	SGI Workstations	-	ARCS firmware
	MIPS/ITE-Boards		-	PMON
	m68k/MAC		-	?? (info is placed into a
					"bootinfo" struct)
	IA64			-	(_seems_ to know about
					environment...)

They all access environment variables either by name, or by an
internally handles number. For Alpha, I've (now) implemented both,
access by name (if variable name is known/described) and access by
generic number.

I think it would be useful to have something like this for other
architectures as well. So I'm currently thinking about implementing a
base driver (like parport does) and additional modules to implement
machine/architecture specific access methode (like parport_pc).

It's easy to code, so what do you think of this?

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjy0h5YACgkQHb1edYOZ4buk8ACgkDP7hhJ1SImAsTBeEEqLe/AY
B9QAn32CyNRMJGwFoMA8K3apuA0q6NX1
=rqHx
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
