Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbRBMLUr>; Tue, 13 Feb 2001 06:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129592AbRBMLUh>; Tue, 13 Feb 2001 06:20:37 -0500
Received: from air.lug-owl.de ([62.52.24.190]:28942 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129288AbRBMLUa>;
	Tue, 13 Feb 2001 06:20:30 -0500
Date: Tue, 13 Feb 2001 12:20:14 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adam Lackorzynski <al10@inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bridge handling 2.4.0-test10 -> 2.4.2-pre3
Message-ID: <20010213122013.A31590@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: Adam Lackorzynski <al10@inf.tu-dresden.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010212140419.A11619@lug-owl.de> <20010213003815.A17962@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010213003815.A17962@inf.tu-dresden.de>; from al10@inf.tu-dresden.de on Tue, Feb 13, 2001 at 12:38:15AM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2001 at 12:38:15AM +0100, Adam Lackorzynski wrote:

Hi Adam!

> On Mon Feb 12, 2001 at 14:04:20 +0100, Jan-Benedict Glaw wrote:
> > I've got a "Bull Express5800/Series" (dual P3) with a DAC1164 RAID
> > controller. The mainboard is ServerWorks based and however, 2.4.2-pre3
> > fails to find the RAID controller. I think there's a problem at
> > scanning PCI busses behind PCI bridges. Here's the PCI bus layout as
> > 2.4.0-test10 recognizes it:
>=20
> There's was a change in the PCI bus scan code in pre3.
>=20
> --- pci-pc.c.orig       Tue Feb 13 00:02:50 2001
> +++ pci-pc.c    Tue Feb 13 00:19:29 2001
> @@ -953,9 +953,6 @@
[Removal of serverworks fixup routines]

That patch cured the problem; the box is up'n'running again. Thanks!

Is there somebody to work on specivic serverworks fixup routines or
should this patch simply go into stock kernel (to not treat serverworks
machines specifically)?

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjqJGGwACgkQHb1edYOZ4bsNfACeL+Sv/mq9P4h3zAi42GmhIcnu
3XYAnjj5WukfBvXov9G5ouK9teM+yZZ3
=QR9h
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
