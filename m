Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUBRLVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUBRLVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:21:09 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:57225 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S264450AbUBRLVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:21:04 -0500
Date: Wed, 18 Feb 2004 12:20:53 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: the crux with DMA
Message-ID: <20040218112052.GA8001@diamond.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.2-diamond i686
X-Mailer: Mutt 1.5.5.1+cvs20040105i (2003-11-05)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I have two machines with 7200 UPM ATA drives. Both are running the
2.6.2 kernel. One has an AMD-768 IDE chipset and reiserfs, the other
a combination of VT82C586 and Promise 20269 with ext3.

Both machines seem to have a problem with DMA, which wasn't
a problem with the 2.4 kernel series. The symptoms are simple: if
I have DMA turned on, sustained high disk usage will cause complete
freezes in both machines. Sometimes, one gets a couple of kernel
oops before the eventual lockup, which is usually related to
journaling code, but it's never really the same. With a 2.4 kernel,
these lockups did not happen. With DMA turned off, I have also not
been able to reproduce the crashes.

I know that neither, reiserfs nor ext3, are high-performance, and
a switch to xfs has long been on my TODO list, but I first want to
get this problem worked out -- I can't mirror the disk otherwise
without crashing 40 times, so I can't create new filesystems.

Any advice is appreciated!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"science without religion is lame,
 religion without science is blind."
                                                    -- albert einstein

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAM0qUIgvIgzMMSnURAvKXAJ9yauUO3geKt13BaWPd35kgG4H79gCeLLMz
a5yOzUWSdrJ9seHdJElZ76o=
=faOh
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
