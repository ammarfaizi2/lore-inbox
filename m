Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUEKLt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUEKLt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEKLt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:49:57 -0400
Received: from ns.suse.de ([195.135.220.2]:59856 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263100AbUEKLtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:49:40 -0400
Date: Tue, 11 May 2004 13:49:36 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Format Unit can take many hours
Message-ID: <20040511114936.GI4828@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-9-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NqNl6FRZtoRUn5bW
Content-Type: multipart/mixed; boundary="dwWFXG4JqVa0wfCP"
Content-Disposition: inline


--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the timeout for FORMAT_UNIT should be much longer; I've seen 8hrs
already (75Gig). I've increased the timeout from 2hrs to 12hrs.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-format-unit-timeout.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.5.orig/drivers/scsi/scsi_ioctl.c	2004-04-04 05:38:20.00000000=
0 +0200
+++ linux-2.6.5/drivers/scsi/scsi_ioctl.c	2004-05-11 08:59:12.837421215 +02=
00
@@ -26,12 +26,12 @@
 #include "scsi_logging.h"
=20
 #define NORMAL_RETRIES			5
-#define IOCTL_NORMAL_TIMEOUT			(10 * HZ)
-#define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
+#define IOCTL_NORMAL_TIMEOUT		(10 * HZ)
+#define FORMAT_UNIT_TIMEOUT		(12 * 60 * 60 * HZ)
 #define START_STOP_TIMEOUT		(60 * HZ)
 #define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
 #define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
-#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )  /* ZIP-250 on parallel port t=
akes as long! */
+#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ)  /* ZIP-250 on parallel port ta=
kes as long! */
=20
 #define MAX_BUF PAGE_SIZE
=20

--dwWFXG4JqVa0wfCP--

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoL3QxmLh6hyYd04RAvzSAJ9YleDalzGxaK+gTw8ybXPBXbUZUwCgkncs
LHGtlBtB28PKS5WBcFDIQo0=
=AgjH
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--
