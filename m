Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSLaXFS>; Tue, 31 Dec 2002 18:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbSLaXFS>; Tue, 31 Dec 2002 18:05:18 -0500
Received: from host194.steeleye.com ([66.206.164.34]:58898 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264863AbSLaXFR>; Tue, 31 Dec 2002 18:05:17 -0500
Message-Id: <200212312313.gBVNDdM04070@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Robert Love <rml@tech9.net>
cc: torvalds@transmeta.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __deprecated requires gcc 3.1 
In-Reply-To: Message from Robert Love <rml@tech9.net> 
   of "31 Dec 2002 17:32:39 EST." <1041373958.1013.9.camel@icbm> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-5856960360"
Date: Tue, 31 Dec 2002 17:13:38 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-5856960360
Content-Type: text/plain; charset=us-ascii

Oops, mea culpa on that one.  It's missing a trailing `__' on the end of 
__GNUC_MINOR

James


--==_Exmh_-5856960360
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== include/linux/compiler.h 1.8 vs edited =====
--- 1.8/include/linux/compiler.h	Sun Dec 29 12:52:54 2002
+++ edited/include/linux/compiler.h	Tue Dec 31 17:12:32 2002
@@ -20,7 +20,7 @@
  * 		int deprecated foo(void)
  * and then gcc will emit a warning for each usage of the function.
  */
-#if __GNUC__ >= 3
+#if ( __GNUC__ == 3 && __GNUC_MINOR__ > 0 ) || __GNUC__ > 3
 #define __deprecated	__attribute__((deprecated))
 #else
 #define __deprecated

--==_Exmh_-5856960360--


