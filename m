Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWGFIXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWGFIXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWGFIXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:23:20 -0400
Received: from bernhard.xss.co.at ([193.80.108.69]:13264 "EHLO
	bernhard.xss.co.at") by vger.kernel.org with ESMTP id S964993AbWGFIXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:23:18 -0400
Message-ID: <44ACC870.2000609@xss.co.at>
Date: Thu, 06 Jul 2006 10:23:12 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo@kvack.org, w@1wt.eu
Subject: [PATCH-2.4] Typo in cdrom.c also in linux-2.4
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------010908090803020000060609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010908090803020000060609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcelo,
hi Willy,

are you aware of the discussion at
<http://bugzilla.kernel.org/show_bug.cgi?id=2966> ?

The typo seems to exist in linux-2.4 too, at least in
2.4.32, 2.4.32-hf32.6 and 2.4.33pre3 (which is what
I checked today)

The fix for linux-2.4 would be just like the proposed
patch for linux-2.6 (see attachment)

Comments?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErMhbxJmyeGcXPhERAgw6AKCwDRtEyE1EK+oT/nU5v2ysQxmWqACcDh1y
eZq4acxsutVuP68nDDcEeAE=
=puYc
-----END PGP SIGNATURE-----

--------------010908090803020000060609
Content-Type: text/x-patch;
 name="cdrom.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdrom.c.patch"

Index: cdrom.c
===================================================================
RCS file: /home/cvs/repository/distribution/Base/linux/drivers/cdrom/cdrom.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 cdrom.c
--- cdrom.c	19 Jan 2005 14:09:43 -0000	1.1.1.10
+++ cdrom.c	6 Jul 2006 08:22:06 -0000
@@ -1259,7 +1259,7 @@
 	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
 	cgc.cmd[7] = s->type;
-	cgc.cmd[9] = cgc.buflen = 0xff;
+	cgc.cmd[9] = cgc.buflen & 0xff;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
 		return ret;

--------------010908090803020000060609--
