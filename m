Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLaQ2Y>; Sun, 31 Dec 2000 11:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQLaQ2O>; Sun, 31 Dec 2000 11:28:14 -0500
Received: from air.lug-owl.de ([62.52.24.190]:25101 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129383AbQLaQ2F>;
	Sun, 31 Dec 2000 11:28:05 -0500
Date: Sun, 31 Dec 2000 16:57:35 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Whats the problem
Message-ID: <20001231165734.F15712@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.3.96.1001230222916.20774B-100000@kohinoor.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1001230222916.20774B-100000@kohinoor.csa.iisc.ernet.in>; from sourav@csa.iisc.ernet.in on Sat, Dec 30, 2000 at 10:46:04PM +0530
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2000 at 10:46:04PM +0530, Sourav Sen wrote:
>=20
> I am unable to compile the following code, can anyone say whats the
> problem :
>=20
> The main error msg is like the following:
>=20
> 	parse error before `EXPORT_SYMTAB_not_defined'
                            ^^^^^^^^^^^^^^^^^^^^^^^^^

Well, the problem is that 'EXPORT_SYMTAB' is not defined;)
>=20
> CC=3Dgcc
> MODCFLAGS=3D-Wall -DMODULE -D__KERNEL__ -DLINUX

should be:

MODCFLAGS=3D-Wall -DMODULE -DEXPORT_SYMTAB -D__KERNEL__ -DLINUX

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpPV24ACgkQHb1edYOZ4btQLgCfZI9dAIHTLf/CRYeqQsFx3RV3
HMsAnRl3wRCaIqk+EsuV4qfdtCUSg5/b
=aCFp
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
