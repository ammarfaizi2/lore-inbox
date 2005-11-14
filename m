Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVKNRhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVKNRhb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKNRha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:37:30 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:9656 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751206AbVKNRh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:37:29 -0500
Date: Mon, 14 Nov 2005 18:37:27 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org
Subject: [PATCH] Make usbdevice_fs.h (again) useable from userspace
Message-ID: <20051114173727.GL4773@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1R6ZDISWaA1muLP0"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Make usbdevice_fs.h (again) useable from userspace If
	we have CONFIG_COMPAT enabled, then userspace programs using
	usbdevice_fs.h won't compile anymore. Signed-off-by: Harald Welte
	<laforge@netfilter.org> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 TW_EV                  BODY: Odd Letter Triples with EV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1R6ZDISWaA1muLP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Make usbdevice_fs.h (again) useable from userspace

If we have CONFIG_COMPAT enabled, then userspace programs using
usbdevice_fs.h won't compile anymore.

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 17c6b20f34d9d68918346af2a2eb6433b09af0e3
tree 397763d1e6776163d45d97702a54d352295940c2
parent b3d70298da3a00f29dd82cf16c1f13407ad2ac09
author Harald Welte <laforge@netfilter.org> Mon, 14 Nov 2005 18:34:23 +0100
committer Harald Welte <laforge@netfilter.org> Mon, 14 Nov 2005 18:34:23 +0=
100

 include/linux/usbdevice_fs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
--- a/include/linux/usbdevice_fs.h
+++ b/include/linux/usbdevice_fs.h
@@ -123,6 +123,7 @@ struct usbdevfs_hub_portinfo {
 	char port [127];	/* e.g. port 3 connects to device 27 */
 };
=20
+#ifdef __KERNEL__
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 struct usbdevfs_urb32 {
@@ -147,6 +148,7 @@ struct usbdevfs_ioctl32 {
 	compat_caddr_t data;
 };
 #endif
+#endif
=20
 #define USBDEVFS_CONTROL           _IOWR('U', 0, struct usbdevfs_ctrltrans=
fer)
 #define USBDEVFS_BULK              _IOWR('U', 2, struct usbdevfs_bulktrans=
fer)

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--1R6ZDISWaA1muLP0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDeMtXXaXGVTD0i/8RAt0uAJ9BwJiESKmEme0b7Yw6KR4FR+1jRQCfTHuQ
p5Aqs/KgZfc+bq1nNNy4pvA=
=c/Hg
-----END PGP SIGNATURE-----

--1R6ZDISWaA1muLP0--
