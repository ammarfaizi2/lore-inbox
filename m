Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132114AbRAJQVm>; Wed, 10 Jan 2001 11:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRAJQVW>; Wed, 10 Jan 2001 11:21:22 -0500
Received: from air.lug-owl.de ([62.52.24.190]:17676 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S132114AbRAJQVM>;
	Wed, 10 Jan 2001 11:21:12 -0500
Date: Wed, 10 Jan 2001 17:21:07 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Which driver took effect?
Message-ID: <20010110172106.H10320@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm building an installer (to install Linux as a .tar.gz off an
SMB share) usind a single floppy with some compiled-in network
drivers. These drivers are modular in the .tgz which gets uncompressed,
but most of them need parameters (normally, you have to supply
a base I/O address). Getting the address is no problem - ifconfig
tells you. But I can't see an easy way (neither in 2.2.x nor in
2.4.x) th be told "eth0 is driven by eepro, eth1 is driven by
ne, ...")

Parsing `dmesg` isn't fun at all (even not with restricted floppy
disk space to store a number of output variants), and different
drivers do have *very* different outputs (if they annouce themselves
at all).

So I'd like to know:

        - Can you tell me a smart way to see which driver handles
          which network interface?
        - Would a patch to add eg. /proc/net/drivers reporting:

                eth0,   eepro,  0x300,  10
                eth1,   ne,     0x240,  5

          be accepted? I think sth like that would be useful at all...

In 2.4.x, register_netdev() would be a good starting point to do
it...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpci/IACgkQHb1edYOZ4bvfxACbBi11sypMEwzzQFF9//l+o2p0
a7EAnjf2NycMtvMz6bOdEnbNw+MlE8ym
=lmjd
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
