Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbTD3Tab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTD3Taa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:30:30 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:1712 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262365AbTD3Ta3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:30:29 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: kraxel@bytesex.org
Subject: [PATCH] Linux-2.5.68 - Fix DBG after return statement in drives/media/video/cpia_pp.c
Date: Thu, 1 May 2003 15:42:37 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011542.46089.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68. It fixes a bug listed on kbugs.org, a DBG statement is after a return statement, so it never executes.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

- ---FILE----

- --- linux-2.5.68/drivers/media/video/cpia_pp.c	2003-04-19 22:48:49.000000000 -0400
+++ linux-2.5.68-changed/drivers/media/video/cpia_pp.c	2003-05-01 15:00:36.000000000 -0400
@@ -605,8 +605,8 @@
 			return -EINVAL;
 		}
 		if((err = ReadPacket(cam, buffer, 8)) < 0) {
- -			return err;
 			DBG("Error reading command result\n");
+			return err;
 		}
 		memcpy(data, buffer, databytes);
 	} else if(command[0] == DATA_OUT) {

- ---ENDFILE----
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sXiy7I5UBdiZaF4RAvMXAJ9xRpCUS7vw9Rq9hmSfFgh6XQeqEQCeM5Dg
BXxyNJdXBytaGa/XtjyY1is=
=15rS
-----END PGP SIGNATURE-----

