Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264672AbUEKMp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbUEKMp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbUEKMp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:45:26 -0400
Received: from ns.suse.de ([195.135.220.2]:51349 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264671AbUEKMpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:45:10 -0400
Date: Tue, 11 May 2004 14:44:58 +0200
From: Kurt Garloff <garloff@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Format Unit can take many hours
Message-ID: <20040511124458.GO4828@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Jens Axboe <axboe@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040511114936.GI4828@tpkurt.garloff.de> <20040511122037.GG1906@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
In-Reply-To: <20040511122037.GG1906@suse.de>
X-Operating-System: Linux 2.6.5-9-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gMqNd2jlyJQcupG/
Content-Type: multipart/mixed; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline


--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Tue, May 11, 2004 at 02:20:38PM +0200, Jens Axboe wrote:
> block/scsi_ioctl.c should likely receive similar treatment then.

Good point.
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--i/CQJCAqWP/GQJtX
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
--- linux-2.6.5/drivers/block/scsi_ioctl.c.orig	2004-05-11 00:05:57.0000000=
00 +0200
+++ linux-2.6.5/drivers/block/scsi_ioctl.c	2004-05-11 14:42:30.277083312 +0=
200
@@ -209,11 +209,11 @@ static int sg_io(request_queue_t *q, str
 	return 0;
 }
=20
-#define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
+#define FORMAT_UNIT_TIMEOUT		(12 * 60 * 60 * HZ)
 #define START_STOP_TIMEOUT		(60 * HZ)
 #define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
 #define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
-#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )
+#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ)
 #define OMAX_SB_LEN 16          /* For backward compatibility */
=20
 static int sg_scsi_ioctl(request_queue_t *q, struct gendisk *bd_disk,

--i/CQJCAqWP/GQJtX--

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoMrKxmLh6hyYd04RAiN0AJ45GWZLV6VBkNxgh3BdIi9KmmIE1QCfdBbh
7TRd6AfuubPrs3uqPhZshz4=
=kS9P
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--
