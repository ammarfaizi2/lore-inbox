Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270802AbTGNUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270807AbTGNULg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:11:36 -0400
Received: from main.gmane.org ([80.91.224.249]:64717 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270802AbTGNUKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:10:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: USB bugs (was: networking bugs and bugme.osdl.org)
Date: Mon, 14 Jul 2003 13:25:33 -0700
Message-ID: <m2isq4etz6.fsf_-_@tnuctip.rychter.com>
References: <1056755336.5459.16.camel@dhcp22.swansea.linux.org.uk> <20030627.172123.78713883.davem@redhat.com>
 <1056827972.6295.28.camel@dhcp22.swansea.linux.org.uk>
 <20030628.150328.74739742.davem@redhat.com>
 <m2vfu765cx.fsf@tnuctip.rychter.com> <20030713041557.GC2695@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
X-Spammers-Please: blackholeme@rychter.com
Cancel-Lock: sha1:95WB3xGvudktsQJJDusOqedCbao=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Greg" =3D=3D Greg KH <greg@kroah.com>:
 Greg> On Sat, Jul 12, 2003 at 10:07:42AM -0700, Jan Rychter wrote:
 >> It hasn't. The result is a system that works for you (and other
 >> active developers), but not for everyone. As an example -- try
 >> running Linux on a modern laptop, connecting some USB devices, using
 >> ACPI, or bluetooth. Observe the resulting problems and
 >> crashes. You'll hit loads of obscure bugs that have been reported,
 >> but never got looked at in detail. I certainly have hit them and
 >> reported most, and most got dropped in various places.

 Greg> What USB bugs have you reported that have gotten dropped?

I'm sorry -- perhaps I shouldn't have said that. The USB bugs were
actually the ones that did get attention. I overgeneralized, perhaps
because I'm frustrated with the amount of problems that I get with Linux
these days.

I went ahead and retested all of my known USB problems against
2.4.22-pre5. It seems all usb-storage ones are gone, and there is only
one bluetooth showstopper, fairly simple to reproduce:

1. boot the machine (using uhci)
2. insert a PCI BCM2033-based bluetooth adapter, observe the firmware
   getting loaded, don't actually bring the hci0 interface up,
3. remove the adapter, everything looks fine
4. try to rmmod uhci and get:
  kmem_cache_destroy: Can't free all objects c12c7b40
  uhci: not all urb_priv's were freed

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ExHBLth4/7/QhDoRAhs8AJ9YhzgjgvCQ6KVKQo1dZpRtqyBsBwCfRZiv
ETHUFC1MzN119AG/BYeAJ34=
=FhXM
-----END PGP SIGNATURE-----
--=-=-=--

