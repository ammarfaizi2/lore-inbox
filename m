Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132585AbRAVQUa>; Mon, 22 Jan 2001 11:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132674AbRAVQUU>; Mon, 22 Jan 2001 11:20:20 -0500
Received: from air.lug-owl.de ([62.52.24.190]:60434 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S132585AbRAVQUP>;
	Mon, 22 Jan 2001 11:20:15 -0500
Date: Mon, 22 Jan 2001 17:20:10 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Freeze: atyfb & XFree4.0.1
Message-ID: <20010122172009.A1437@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I just discovered a solid freeze:
jbglaw@jbglaw-sid:~$ uname -r
2.4.1-pre8
jbglaw@jbglaw-sid:~$ grep aty /etc/lilo.conf
        append=3D"video=3Datyfb:800x600

Parts of /etc/X11/XF86Config-4:

	Section "Device"
		Identifier	"Generic Video Card"
		Driver		"ati"
	EndSection
        SubSection "Display"
                Depth           24
                Modes           "1024x768"
        EndSubSection


Now, when I switch from X to a configured virtual console (eg. tty1),
everything is okay. But if I press <Ctrl><Alt><F12> (for example)
the system just dies. I've not yet attached a serial console,
but SysRq keys seem to not be functional, as well as the NumLock
LED doesn't change when pressing the NumLock key...

MfG, JBG


--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpsXbkACgkQHb1edYOZ4buFMwCfYz0QcPcrkC+E7WZv/GxcvEDN
W/8An2YGOBH43BIAVAuNKgHdeWZCkKUf
=3SZA
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
