Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129763AbQK0Vsw>; Mon, 27 Nov 2000 16:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129406AbQK0Vsm>; Mon, 27 Nov 2000 16:48:42 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:55826 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S129763AbQK0Vsf>; Mon, 27 Nov 2000 16:48:35 -0500
Date: Mon, 27 Nov 2000 22:16:23 +0100
From: Kurt Garloff <kurt@garloff.de>
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
        David Brown <usb-storage@davidb.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: USB-Storage drivers
Message-ID: <20001127221623.D24187@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
        Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
        David Brown <usb-storage@davidb.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: multipart/mixed; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthew, David, Linus,

any particular reason why the support for special dongles in the usb-storage
driver can not be selected during kernel configuration? (See attached patch=
).

I can only tell about the Freecom support in the usb-storage driver: It
works flawlessly for me driving some OnStream USB30 tape drive (with the
osst driver). So, I think it should be offered to people who want to try.

Of course, it's up to you. Maybe you want to put some ifdef CONFIG_EXPERIME=
NTAL
around it or a little help text. But I'd definitely appreciate the
possibility to compile the drivers without patching the Config file.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations <k.garloff@phys.tue.nl>   [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-storage-config.diff"

diff -uNr linux-2.4.0-t11.ac2.reiser.ide.osst/drivers/usb/Config.in linux-2.4.0-t11.ac2.reiser.ide.osst.usb/drivers/usb/Config.in
--- linux-2.4.0-t11.ac2.reiser.ide.osst/drivers/usb/Config.in	Sun Nov 12 04:04:30 2000
+++ linux-2.4.0-t11.ac2.reiser.ide.osst.usb/drivers/usb/Config.in	Wed Nov 22 22:00:40 2000
@@ -64,6 +64,10 @@
    dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
    if [ "$CONFIG_USB_STORAGE" != "n" ]; then
       bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
+      bool '    USB Mass Storage HP8200e support' CONFIG_USB_STORAGE_HP8200e
+      bool '    USB Mass Storage SDDR09  support' CONFIG_USB_STORAGE_SDDR09
+      bool '    USB Mass Storage DPCM    support' CONFIG_USB_STORAGE_DPCM
+      bool '    USB Mass Storage FreeCom support' CONFIG_USB_STORAGE_FREECOM
    fi
    dep_tristate '  USS720 parport driver' CONFIG_USB_USS720 $CONFIG_USB $CONFIG_PARPORT
    dep_tristate '  DABUSB driver' CONFIG_USB_DABUSB $CONFIG_USB

--AjmyJqqohANyBN/e--

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Is8mxmLh6hyYd04RAlZSAKCdqHNfm7wIbEQ09xKIRACEqxVzbQCfZ8Xo
/tcMKN6hwd3tKnS8FQJae0U=
=f/dt
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
