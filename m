Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131566AbRAGNCK>; Sun, 7 Jan 2001 08:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131592AbRAGNCA>; Sun, 7 Jan 2001 08:02:00 -0500
Received: from mail.epost.de ([64.39.38.70]:8875 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S131566AbRAGNBu>;
	Sun, 7 Jan 2001 08:01:50 -0500
From: Sebastian Brückner 
	<sebastian.brueckner@epost.de>
Reply-To: sebastian.brueckner@epost.de
Date: Sun, 7 Jan 2001 14:08:24 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_06NSIW8ZE7K1J198TX2X"
MIME-Version: 1.0
Message-Id: <01010714040102.15584@flottekiste>
To: linux-kernel@vger.kernel.org
Subject: typo in patch-2.4.0-ac3.bz2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_06NSIW8ZE7K1J198TX2X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi!

There's a typo in patch-2.4.0-ac3.bz2 
file drivers/video/vesafb.c

there is a variable "temp_sze" - it has to be "temp_size"


--------------Boundary-00=_06NSIW8ZE7K1J198TX2X
Content-Type: text/plain;
  name="patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch"

--- linux/drivers/video/vesafb.c.old	Sun Jan  7 13:29:40 2001
+++ linux/drivers/video/vesafb.c	Sun Jan  7 13:29:03 2001
@@ -637,7 +637,7 @@
 		int temp_size = video_size;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
-                	temp_sze &= (temp_size - 1);
+                	temp_size &= (temp_size - 1);
                         
                 /* Try and find a power of two to add */
 		while (temp_size && mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {

--------------Boundary-00=_06NSIW8ZE7K1J198TX2X--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
