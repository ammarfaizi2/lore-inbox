Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVBTJSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVBTJSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 04:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVBTJSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 04:18:34 -0500
Received: from [195.32.84.175] ([195.32.84.175]:30923 "EHLO
	host01.pcaserver.com") by vger.kernel.org with ESMTP
	id S261709AbVBTJS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 04:18:26 -0500
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Kjartan Maraas <kmaraas@broadpark.no>,
       Lorenzo Colitti <lorenzo@colitti.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>
	<200502151742.55362.s0348365@sms.ed.ac.uk>
	<1108563926.4986.3.camel@localhost.localdomain>
	<200502182049.11088.s0348365@sms.ed.ac.uk>
Reply-To: ML ACPI-devel <acpi-devel@lists.sourceforge.net>
From: Luca Capello <luca@pca.it>
Date: Sun, 20 Feb 2005 10:21:04 +0100
In-Reply-To: <200502182049.11088.s0348365@sms.ed.ac.uk> (Alistair John
 Strachan's message of "Fri, 18 Feb 2005 20:49:11 +0000")
Message-ID: <87ekfbvb7j.fsf@gismo.pca.it>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri 18 Feb 2005 21:49, Alistair John Strachan wrote:
> I discovered that either the i2c_core.ko or i2c_i801.ko modules cause the=
 hang=20
> on resume! If you stop the entire i2c subsystem from being loaded by hotp=
lug=20
> (note this is the BUS driver, not the sensors driver!), then resume works=
=20
> perfectly! Presumably there's a bug in the resuming of this module.

Well, on my IBM ThinkPad T42p (ATI FireGL T2 128MB), I can resume with
both I2C modules loaded, so probably the problem is not specific to
the I2C subsystem.

> In other news, USB devices only work after I remove uhci_hcd and ehci_hcd=
 and=20
> reload them.

I just tested two USB devices after S3 resuming without having removed
the USB modules (uhci-hcb and ehci-hcd):

=2D Logitech USB Wheel Mouse (046d:c00c, USB 1.x), it works with no
  problem on console, but not on X (this was caused by the fact that
  I've two corepointer on my XF86Config-4, in fact after having
  corrected this error and restarted X, the USB mouse works)

=2D Mitsubishi Chemical 2.5" HD Case (05e3:0702, USB 2.0 [1], with a
  SAMSUNG MP0804H 80GB), it works with no problem :-D

> The s3_bios workaround allows video to kind of work, but I can't use anyt=
hing=20
> other than vga=3Dnormal (vesafb results in corruption), and the screen is=
 no=20
> longer artificially resized to fill the LCD, it's native res and centered=
=20
> (which sure is annoying).

Again, IMHO the problem is specific to your machine: I use the
radeonfb (with acpi_sleep=3Ds3_bios) and the resume is ok (both in
console and Debian XFree86-4.3.0.dfsg.1-11, radeon driver).

Thx, bye,
Gismo / Luca

[1] http://www.qbik.ch/usb/devices/showdescr.php?id=3D3039

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCGFaLVAp7Xm10JmkRAmCvAJ96dE6QMZ7wfu93rsPet+4ocBZkngCfaFSy
ef9c6EATNoT+/ceN3Q8F1bg=
=WCCz
-----END PGP SIGNATURE-----
--=-=-=--
