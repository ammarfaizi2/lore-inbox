Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273505AbRIUNDa>; Fri, 21 Sep 2001 09:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273507AbRIUNDU>; Fri, 21 Sep 2001 09:03:20 -0400
Received: from CPE-61-9-150-236.vic.bigpond.net.au ([61.9.150.236]:50163 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S273505AbRIUNDL>; Fri, 21 Sep 2001 09:03:11 -0400
Message-ID: <3BAB3810.59C6F706@eyal.emu.id.au>
Date: Fri, 21 Sep 2001 22:52:32 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.10-pre13: put_gendisk compile error
Content-Type: multipart/mixed;
 boundary="------------4987CA0C123D81AA453EB0E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4987CA0C123D81AA453EB0E0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It should be removed from the offending programs. Same as pre12.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------4987CA0C123D81AA453EB0E0
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre13-ideraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre13-ideraid.patch"

--- linux/drivers/ide/hptraid.c	Wed Sep 19 22:01:42 2001
+++ linux-2.4-ac/drivers/ide/hptraid.c	Wed Sep 19 08:24:40 2001
@@ -314,7 +314,6 @@
 		if (gd!=NULL) {
 			for (j=1+(minor<<gd->minor_shift);j<((minor+1)<<gd->minor_shift);j++) 
 				gd->part[j].nr_sects=0;					
-			put_gendisk(gd);
 		}
         }
 	raid[device].disk[i].device = MKDEV(major,minor);
--- linux/drivers/ide/pdcraid.c	Wed Sep 19 22:01:42 2001
+++ linux-2.4-ac/drivers/ide/pdcraid.c	Wed Sep 19 08:24:40 2001
@@ -321,7 +321,6 @@
 				if (gd!=NULL) {
 					for (j=1+(minor<<gd->minor_shift);j<((minor+1)<<gd->minor_shift);j++) 
 						gd->part[j].nr_sects=0;					
-					put_gendisk(gd);
 				}
 			}
 			raid[device].disk[i].device = MKDEV(major,minor);

--------------4987CA0C123D81AA453EB0E0--

