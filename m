Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290547AbSBKWId>; Mon, 11 Feb 2002 17:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290570AbSBKWIX>; Mon, 11 Feb 2002 17:08:23 -0500
Received: from maile.telia.com ([194.22.190.16]:44482 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S290547AbSBKWIJ>;
	Mon, 11 Feb 2002 17:08:09 -0500
Message-Id: <200202112208.g1BM7xQ29643@maile.telia.com>
From: Roger Larsson <roger.larsson@norran.net>
To: Sebastien Rougeaux <sebastien.rougeaux@anu.edu.au>,
        Peter Schlaile <udbz@rz.uni-karlsruhe.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.4] video1394.c compilation error
Date: Mon, 11 Feb 2002 23:04:49 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1O2EIUIRV8MXEYUEF8OX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1O2EIUIRV8MXEYUEF8OX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

do_iso_mmap takes pointer to vma as first argument...
This code compiles - but it might be wrong...

/RogerL
-- 
Roger Larsson
Skellefteå
Sweden

--------------Boundary-00=_1O2EIUIRV8MXEYUEF8OX
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.5.4-do_iso_mmap"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch-2.5.4-do_iso_mmap"

--- linux-2.5.4/drivers/ieee1394/video1394.c.orig	Mon Feb 11 22:51:44 2002
+++ linux-2.5.4/drivers/ieee1394/video1394.c	Mon Feb 11 22:51:58 2002
@@ -1406,7 +1406,7 @@
 	if (video->current_ctx == NULL) {
 		PRINT(KERN_ERR, ohci->id, "Current iso context not set");
 	} else
-		res = do_iso_mmap(ohci, video->current_ctx, 
+		res = do_iso_mmap(vma, ohci, video->current_ctx, 
 			   (char *)vma->vm_start, 
 			   (unsigned long)(vma->vm_end-vma->vm_start));
 	unlock_kernel();

--------------Boundary-00=_1O2EIUIRV8MXEYUEF8OX--
