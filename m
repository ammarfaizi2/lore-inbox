Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbUAFROL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUAFROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:14:10 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:38792 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S264536AbUAFRMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:12:39 -0500
Date: Tue, 6 Jan 2004 18:12:36 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6 IPsec (Kame) appears to be working, but it isn't
Message-ID: <20040106171236.GA3068@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I am not sure this is the best place to ask, but I don't want to
feel the *BSD wrath against Linux at kame.net, and I could not find
a mailing list for Linux IPsec, so please feel free to point me
elsewhere, but don't shoot, okay?

I configured two 2.6.0 hosts to do simple manually keyed transport
IPsec, just like Ralf (thanks!) wrote at www.ipsec-howto.org. When
I now ping one end from the other, tcpdump reports successful packet
exchanges on both sides:

  10.201.165.118 > 10.201.23.21:
    AH(spi=3D0x00000200,seq=3D0x2d): ESP(spi=3D0x00000201,seq=3D0x2d) (DF)
  10.201.23.21 > 10.201.165.118:
    AH(spi=3D0x00000300,seq=3D0x6): ESP(spi=3D0x00000301,seq=3D0x6)

However, the ping application at 10.201.165.118 sees none of the
replies:

  wall:~# ping 10.201.23.21
  PING 10.201.23.21 (10.201.23.21) from 10.201.165.118 : 56(84) bytes of da=
ta.

  --- 10.201.23.21 ping statistics ---
  19 packets transmitted, 0 received, 100% loss, time 17997ms

The same applies to normal IP packets (e.g. TCP port 25):

  10.201.165.118 > 10.201.23.21:
    AH(spi=3D0x00000200,seq=3D0x2e): ESP(spi=3D0x00000201,seq=3D0x2e) (DF)
  10.201.23.21 > 10.201.165.118:
    AH(spi=3D0x00000300,seq=3D0x7): ESP(spi=3D0x00000301,seq=3D0x7) (DF)
  10.201.165.118 > 10.201.23.21:
    AH(spi=3D0x00000200,seq=3D0x2f): ESP(spi=3D0x00000201,seq=3D0x2f) (DF)
  10.201.23.21 > 10.201.165.118:
    AH(spi=3D0x00000300,seq=3D0x8): ESP(spi=3D0x00000301,seq=3D0x8) (DF)
  10.201.23.21 > 10.201.165.118:
    AH(spi=3D0x00000300,seq=3D0x9): ESP(spi=3D0x00000301,seq=3D0x9) (DF)
  10.201.23.21 > 10.201.165.118:
    AH(spi=3D0x00000300,seq=3D0xa): ESP(spi=3D0x00000301,seq=3D0xa) (DF)

Would you agree that this is weird? What am I doing wrong?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"i love deadlines. i like the whooshing
 sound they make as they fly by."
                                                      -- douglas adams

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+uyEIgvIgzMMSnURAomZAJ9LN73VU27XHMvLdhTnsYIIgsM7FwCeMisp
OEoWWWgoLZSTNVVEcYk9fWU=
=UGDo
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
