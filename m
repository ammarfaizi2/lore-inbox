Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRAVXzS>; Mon, 22 Jan 2001 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130238AbRAVXzI>; Mon, 22 Jan 2001 18:55:08 -0500
Received: from air.lug-owl.de ([62.52.24.190]:26885 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S135637AbRAVXrN>;
	Mon, 22 Jan 2001 18:47:13 -0500
Date: Tue, 23 Jan 2001 00:47:10 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Freeze: atyfb & XFree4.0.1
Message-ID: <20010123004709.B4721@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010122172009.A1437@lug-owl.de> <Pine.LNX.4.05.10101222118440.13798-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.05.10101222118440.13798-100000@callisto.of.borg>; from geert@linux-m68k.org on Mon, Jan 22, 2001 at 09:20:07PM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert!

On Mon, Jan 22, 2001 at 09:20:07PM +0100, Geert Uytterhoeven wrote:
> On Mon, 22 Jan 2001, Jan-Benedict Glaw wrote:
> > I just discovered a solid freeze:
> > jbglaw@jbglaw-sid:~$ uname -r
> > 2.4.1-pre8
> > jbglaw@jbglaw-sid:~$ grep aty /etc/lilo.conf
> >         append=3D"video=3Datyfb:800x600

[...and X4 with accelerated ati driver, *not* the framebuffer driver]

> >=20
> >=20
> > Now, when I switch from X to a configured virtual console (eg. tty1),
> > everything is okay. But if I press <Ctrl><Alt><F12> (for example)
> > the system just dies. I've not yet attached a serial console,
> > but SysRq keys seem to not be functional, as well as the NumLock
> > LED doesn't change when pressing the NumLock key...
>=20
> XFree86 4.x is not fbdev-aware (yet), unless you specify some
> `UseFBDev' option keyword (exact syntax may differ, I don't run 4.x yet).

I'll have a deeper look at that all, but switching between virtual
terminals and the X screen works perfectly. *Only* switching to
a not priviously allocated VC (ie. 8th VT which is unused in most
distributions) locks up the machine...

I think there's missing some little check somewhere;)

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpsxn0ACgkQHb1edYOZ4bvCoACfc/IfTRzOWjmtIDyVlyMbd1Nu
KMMAniMgBJm5EGU590cswKsPFs46M5Yi
=574g
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
