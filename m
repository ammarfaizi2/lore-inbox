Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVH2V0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVH2V0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVH2VYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:24:38 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:1864 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751318AbVH2VYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:24:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=N5Ve1Ztn7sisvUXnSUHAd0QsDxLpSsxjsYPQW9sUnf7a+PaBEQoiqiashDqzUoRIVoABhy+XZBV1OU1YNBV57ngQK6rKeZW+y0Iov8jsjfWAbMCeq72EY6yVQogVNFopZciTijImoUa2vdSFnLBsyUKtaErvyqCVjBO1S/L6TNA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] remove verify_area() - remove or edit references to verify_area in Documentation/
Date: Mon, 29 Aug 2005 23:25:07 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292325.07967.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove (or edit) remaining references to the now dead verify_area() function
from files in Documentation/.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/cdrom/sonycd535              |    3 ++-
 Documentation/exception.txt                |    2 +-
 Documentation/feature-removal-schedule.txt |    8 --------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/Documentation/feature-removal-schedule.txt linux-2.6.13/Documentation/feature-removal-schedule.txt
--- linux-2.6.13-orig/Documentation/feature-removal-schedule.txt	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/Documentation/feature-removal-schedule.txt	2005-08-29 03:37:36.000000000 +0200
@@ -74,14 +74,6 @@ Who:	Paul E. McKenney <paulmck@us.ibm.co
 
 ---------------------------
 
-What:	remove verify_area()
-When:	July 2006
-Files:	Various uaccess.h headers.
-Why:	Deprecated and redundant. access_ok() should be used instead.
-Who:	Jesper Juhl <juhl-lkml@dif.dk>
-
----------------------------
-
 What:	IEEE1394 Audio and Music Data Transmission Protocol driver,
 	Connection Management Procedures driver
 When:	November 2005
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/Documentation/cdrom/sonycd535 linux-2.6.13/Documentation/cdrom/sonycd535
--- linux-2.6.13-orig/Documentation/cdrom/sonycd535	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/Documentation/cdrom/sonycd535	2005-08-29 03:36:21.000000000 +0200
@@ -68,7 +68,8 @@ it a better device citizen.  Further tha
 Porfiri Claudio <C.Porfiri@nisms.tei.ericsson.se> for patches
 to make the driver work with the older CDU-510/515 series, and
 Heiko Eissfeldt <heiko@colossus.escape.de> for pointing out that
-the verify_area() checks were ignoring the results of said checks.
+the verify_area() checks were ignoring the results of said checks
+(note: verify_area() has since been replaced by access_ok()).
 
 (Acknowledgments from Ron Jeppesen in the 0.3 release:)
 Thanks to Corey Minyard who wrote the original CDU-31A driver on which
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/Documentation/exception.txt linux-2.6.13/Documentation/exception.txt
--- linux-2.6.13-orig/Documentation/exception.txt	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/Documentation/exception.txt	2005-08-29 03:37:19.000000000 +0200
@@ -7,7 +7,7 @@ To protect itself the kernel has to veri
 
 In older versions of Linux this was done with the 
 int verify_area(int type, const void * addr, unsigned long size) 
-function.
+function (which has since been replaced by access_ok()).
 
 This function verified that the memory area starting at address 
 addr and of size size was accessible for the operation specified 



