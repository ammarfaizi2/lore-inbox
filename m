Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280994AbRKLUr7>; Mon, 12 Nov 2001 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280995AbRKLUro>; Mon, 12 Nov 2001 15:47:44 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:19631 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280994AbRKLUrK>; Mon, 12 Nov 2001 15:47:10 -0500
Subject: [PATCHLET] 2.4.15-pre4: advansys.c: gcc warning fix
To: torvalds@transmeta.com
Date: Mon, 12 Nov 2001 20:47:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E163Nz3-0005L1-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please consider this one liner getting rid of a gcc "possible unitialized
variable" warning in the advansys.c scsi driver. A quick look showed gcc
to be wrong on this occasion but having the warning not nice...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- advansys_patchlet.diff ---

diff -urN linux-2.4.15-pre4-vanilla/drivers/scsi/advansys.c linux-2.4.15-pre4-up/drivers/scsi/advansys.c
--- linux-2.4.15-pre4-vanilla/drivers/scsi/advansys.c	Mon Nov 12 20:21:07 2001
+++ linux-2.4.15-pre4-up/drivers/scsi/advansys.c	Mon Nov 12 20:01:26 2001
@@ -5552,7 +5552,7 @@
                 }
             } else {
                 ADV_CARR_T      *carrp;
-                int             req_cnt;
+                int             req_cnt = 0;
                 adv_req_t       *reqp = NULL;
                 int             sg_cnt = 0;
 

