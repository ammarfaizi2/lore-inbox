Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272413AbRIFGSm>; Thu, 6 Sep 2001 02:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272414AbRIFGSe>; Thu, 6 Sep 2001 02:18:34 -0400
Received: from tank.panorama.sth.ac.at ([193.170.53.11]:15883 "EHLO
	tank.panorama.sth.ac.at") by vger.kernel.org with ESMTP
	id <S272413AbRIFGSU>; Thu, 6 Sep 2001 02:18:20 -0400
Date: Thu, 6 Sep 2001 08:18:43 +0200
From: Peter Surda <shurdeek@panorama.sth.ac.at>
To: linux-kernel@vger.kernel.org
Subject: (solved) memcpy to videoram eats too much CPU on ATI cards
Message-ID: <20010906081842.D27619@shurdeek.cb.ac.at>
In-Reply-To: <E15bRy4-0004Va-00@the-village.bc.nu> <200108272140.XAA20798@cave.bitwizard.nl> <20010828000127.M17545@shurdeek.cb.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010828000127.M17545@shurdeek.cb.ac.at>; from shurdeek on Tue, Aug 28, 2001 at 12:01:27AM +0200
X-Operating-System: Linux shurdeek 2.4.3-20mdk
X-Editor: VIM - Vi IMproved 6.0z ALPHA (2001 Mar 24, compiled Mar 26 2001 12:25:08)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2001 at 12:01:27AM +0200, Peter Surda wrote:
> So the conclusion is basically that the card can't chew data that fast an=
d I
> should use busmastering instead of memcpy (and other drivers should do th=
at
> too because "hidden load" occurs anyway). I'm working on it.
Just to end this thread in a victorous manner ;-), thanks to Michel D=E4nzer
<michdaen@iiic.ethz.ch> and me, there is now a working implementation of
busmastered video transfers for the r128 driver, and it has been submitted =
to
all relevant lists and maintainers. It indeed solved the problem, CPU time
eaten by video transfers is negligible and DVD and "DivX ;-)" playback was
never so smooth. With software-only DVD decoder, watching fullscreen DVD
leaves 50-60% CPU time idle on a Duron 650, even on action-packed scenes. If
I catch someone claiming again that Linux isn't suitable for multimedia, I =
can
just laugh now :-).

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505=
122023

--
               Dudes! May the Open Source be with you.

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lxVCzogxsPZwLzcRApJdAJ4iU1qtb4j/cCqTCwtwXm/TUApypwCfSOGM
gb/MyAaDSrm54yqsG939AFo=
=S/G3
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
