Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSGXTKN>; Wed, 24 Jul 2002 15:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSGXTKM>; Wed, 24 Jul 2002 15:10:12 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:23516 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317472AbSGXTKJ>; Wed, 24 Jul 2002 15:10:09 -0400
Date: Wed, 24 Jul 2002 22:09:00 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot problem, 2.4.19-rc3-ac1
Message-ID: <20020724190900.GC21047@alhambra.actcom.co.il>
References: <Pine.LNX.4.44.0207241655011.17209-100000@linux-box.realnet.co.sz> <9cffzy95g39.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <9cffzy95g39.fsf@rogue.ncsl.nist.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2002 at 10:57:14AM -0400, Ian Soboroff wrote:
> Zwane Mwaikambo <zwane@linuxpower.ca> writes:
>=20
> > On 24 Jul 2002, Ian Soboroff wrote:
> >=20
> > >  static int trident_suspend(struct pci_dev *dev, u32 unused)
> > >  {
> > > -       struct trident_card *card =3D (struct trident_card *) dev;
> > > +       struct trident_card *card =3D pci_get_drvdata(dev);
> > > =20
> > >         if(card->pci_id =3D=3D PCI_DEVICE_ID_ALI_5451) {
> > >                 ali_save_regs(card);
> > > @@ -3466,7 +3466,7 @@
> > > =20
> > >  static int trident_resume(struct pci_dev *dev)
> > >  {
> > > -       struct trident_card *card =3D (struct trident_card *) dev;
> > > +       struct trident_card *card =3D pci_get_drvdata(dev);
> > > =20
> > >         if(card->pci_id =3D=3D PCI_DEVICE_ID_ALI_5451) {
> > >                 ali_restore_regs(card);
> >=20
> > Thats definitely correct, has this patch been sent to lkml before?
>=20
> I didn't see it in a quick search at the uwsg.ia.edu archive.  The
> last ALi patch I see on 2.4 seems to come from Matt Wu at ALi on
> 4/4/2001.

There have been various updates to trident.c in the -ac tree lately,
from Lei Hu and myself. It is my understanding that Alan Cox will push
them to 2.4 when 2.4.20 opens up.=20

This patch is obviously corrrect, and I'll send it to Alan if no one
has done it yet.=20

> Anyone have a clue on the IDE part of my question? ;-)

Sorry, nope :)
--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9PvtMKRs727/VN8sRAjmiAJsHckK3jC05tjMkvar08Z5dxNsRUACdFAZf
/nY6vUcQj3lTCou8aOfoJy8=
=9cMc
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
