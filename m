Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264249AbTCXP22>; Mon, 24 Mar 2003 10:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264250AbTCXP22>; Mon, 24 Mar 2003 10:28:28 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:42254 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S264249AbTCXP2Z>;
	Mon, 24 Mar 2003 10:28:25 -0500
Date: Mon, 24 Mar 2003 16:39:33 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Testing: What do you want?
Message-ID: <20030324153933.GH30613@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3E7F1A2D.4050306@coyotegulch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <3E7F1A2D.4050306@coyotegulch.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-24 09:46:05 -0500, Scott Robert Ladd <coyote@coyotegulch.co=
m>
wrote in message <3E7F1A2D.4050306@coyotegulch.com>:
> For the most part, the 2.5 series has worked very well for me, albeit=20
> with a few glitches (radeonfb, for example, as reported last week.) I'll=
=20
> build the 2.5.65 kernel on my Sparc later today, and see how well it=20
> works there.

sparc32? If you get it to build or even to boot, please drop me a note
with at least this information I'm *really* interested in:

	- Machine type
	- CPU(s)
	- .config file
	- gcc -v
	- ld -v

Last time I looked at it, sparc32 wasn't in any good state (esp. SMP) in
2.5.x. This is because Dave S. Miller stopped spending a lot of hacking
time (he has to work for other things now and only merges patches he
gets sent, where he formerly did tons on active development for
sparc32).

I'm in the progress of a (private) attempt to build a Linux Test Centre.
(I've already mentioned that - read my last mail in the thread
aboutremoving .gz files from kernel.org.)

The idea is to have automatic kernel builds (for all available
architectures I've collected test hardware for:) and run tests. This
needs to be achieved with automatic cross-compilation of kernels (you
don't want to let a m68k compile it's own kernel:), installation and
choosing this for booting. I've got some quite nice ideas there
(including electronic power switches, serial console management etc.),
but yet, I'm not assured that I'll get the room I may get near
Halle/Westf (Germany).

What is _most_ important to testing is this:

	- *fast* response.
			Developers don't like to wait like a month
			before they hear they broke something. If there
			are (untested) patches timely in between, it may
			even get hard to sort the broken part out (cf.
			sparc32 at 2.5.x).

			So the basics are doing automated _compile_
			tests. This includes keeping tables (file name -
			responsible person, architecture - responsible
			person) for automated notification, as well as a
			quite good system to switch certain .config
			items off (so if you find some compile error,
			you have to automatically (if possible) switch
			off the corresponding feature and start again).

	- Decoded Oopses.
			With the in-kernel kksymoops, this is (most of
			the time) quite easy to do if you've got serial
			console working.

			Possibly implementing kgdb for more
			architectures could help also.

			If you then get an answer by a developer, you
			also need to response on a fast manner. Give any
			information to the developers as early as
			possible. They don't like asking for every
			piece. They like mails containing anything they
			need (structured and readable).

			If you then receive patches for review, you'd
			also be capable of automatically including them,
			starting a new compile/install/boot-up, ...

	- Runtime test (stability).
			Some Kernels first start booting, but freeze
			days later. These are the hard ones:( By
			possibility, you haven't got any information on
			this...
=09
=2E..and all this for as many machines/architectures with as different as
possibly hardware attached.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+fya1Hb1edYOZ4bsRAommAJ42FJ35XC9hyKnLjo3DNRmzJ+2AjACfdU06
JH7zeZ6JQD7/sruToggeRhY=
=1ghg
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
