Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWFYJMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWFYJMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWFYJMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:12:02 -0400
Received: from master.altlinux.org ([62.118.250.235]:8974 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932138AbWFYJMA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:12:00 -0400
Date: Sun, 25 Jun 2006 13:11:41 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       enrico.scholz@informatik.tu-chemnitz.de, greg@kroah.com, rl@hellgate.ch
Subject: Re: + via-rhine-on-epia-pd-needs.patch added to -mm tree
Message-Id: <20060625131141.fc7c6718.vsu@altlinux.ru>
In-Reply-To: <449DBF48.2050607@garzik.org>
References: <200606242219.k5OMIxxY006085@shell0.pdx.osdl.net>
	<449DBF48.2050607@garzik.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__25_Jun_2006_13_11_41_+0400_3N+g6cdaQ8Ppcr44"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__25_Jun_2006_13_11_41_+0400_3N+g6cdaQ8Ppcr44
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Jun 2006 18:40:08 -0400 Jeff Garzik wrote:

> akpm@osdl.org wrote:
> > The patch titled
> >=20
> >      via-rhine on epia-pd needs irq-quirk
> >=20
> > has been added to the -mm tree.  Its filename is
> >=20
> >      via-rhine-on-epia-pd-needs.patch
> >=20
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to =
find
> > out what to do about this
> >=20
> > ------------------------------------------------------
> > Subject: via-rhine on epia-pd needs irq-quirk
> > From: <enrico.scholz@informatik.tu-chemnitz.de>
> >=20
> >=20
> > See http://bugzilla.kernel.org/show_bug.cgi?id=3D6744
> >=20
> > VT6102 [Rhine-II] needs a routing of IRQ 9 to IRQ 11.
> >=20
> > Without it, I get
> >=20
> > | irq 9: nobody cared (try booting with the "irqpoll" option)
> > | <c0136636> __report_bad_irq+0x36/0x80  <c01367ee> note_interrupt+0x16=
e/0x1a0
> > | <c01c7f12> acpi_ev_sci_xrupt_handler+0x12/0x20  <c01361a3> handle_IRQ=
_event+0x23/0x50
> > | <c013623f> __do_IRQ+0x6f/0xa0  <c0105246> do_IRQ+0x36/0x50
> > | =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > | <c010362a> common_interrupt+0x1a/0x20  <c0118fec> __do_softirq+0x2c/0=
x80
> > | <c0110520> do_page_fault+0x0/0x556  <c0105298> do_softirq+0x38/0x40
> > | =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > | <c0105256> do_IRQ+0x46/0x50  <c010362a> common_interrupt+0x1a/0x20
> > | <c0110520> do_page_fault+0x0/0x556  <c0110651> do_page_fault+0x131/0x=
556
> > | <c0110520> do_page_fault+0x0/0x556  <c010374f> error_code+0x4f/0x60
> > | handlers:
> > | [<c01c2be0>] (acpi_irq+0x0/0x20)
> > | Disabling IRQ #9
> >=20
> > Cc: Greg KH <greg@kroah.com>
> > Cc: Roger Luethi <rl@hellgate.ch>
> > Cc: Jeff Garzik <jeff@garzik.org>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> >=20
> >  drivers/pci/quirks.c |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff -puN drivers/pci/quirks.c~via-rhine-on-epia-pd-needs drivers/pci/q=
uirks.c
> > --- a/drivers/pci/quirks.c~via-rhine-on-epia-pd-needs
> > +++ a/drivers/pci/quirks.c
> > @@ -662,6 +662,7 @@ static void quirk_via_irq(struct pci_dev
> >  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
> >  	}
> >  }
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, 0x3065,   quirk_via_irq);
> >  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0=
, quirk_via_irq);
> >  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1=
, quirk_via_irq);
> >  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2=
, quirk_via_irq);
>=20
> It strikes me as very unwise to do this.  I know that some VIA Rhine=20
> exist on a PCI card, which is a valid case where this quirk should -not-=
=20
> be executed.

And would it break anything?  A normal PCI device will just ignore the
value in PCI_INTERRUPT_LINE, so the only "problem" which this could
cause is an unneeded printk.

> The VIA quirk is only for on-motherboard devices, which have special PCI=
=20
> interrupt line behavior (makes some internal PIC connections).
>=20
> How can we solve this conditionally?  I agree this is needed...  for=20
> on-mobo devices.  But 0x3065 is not always glued in, AFAIK.

I can think only about checking other devices on the same PCI bus - if
this 0x3065 device is at devfn 0x12.0, and there is a VIA ISA bridge at
devfn 0x11.0, it is probably a builtin device which needs the quirk.

--Signature=_Sun__25_Jun_2006_13_11_41_+0400_3N+g6cdaQ8Ppcr44
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEnlNNW82GfkQfsqIRAo4MAJ9pYLdTCH5EmOIQDyNoArQzx2LiygCfS4QR
wDUFaY/yg/co0q4QjUQdDr8=
=mE+0
-----END PGP SIGNATURE-----

--Signature=_Sun__25_Jun_2006_13_11_41_+0400_3N+g6cdaQ8Ppcr44--
