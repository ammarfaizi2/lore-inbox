Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271548AbTGQSEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271565AbTGQSEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:04:48 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:35558 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271548AbTGQSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:01:57 -0400
Date: Thu, 17 Jul 2003 14:16:07 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH] scripts/ver_linux patch - Bug 267
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bwindle-kbt@fint.org
Message-id: <200307171416.07705.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to make scripts/ver_linux work in 2.6.0-test1

http://bugme.osdl.org/show_bug.cgi?id=267

Josef "Jeff" Sipek, aka Jeff.

--- linux-2.6.0-test1-vanilla/scripts/ver_linux	2003-07-13 23:35:16.000000000 -0400
+++ linux-2.6.0-test1-eva/scripts/ver_linux	2003-07-17 03:53:46.000000000 -0400
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-depmod -V  2>&1 | grep version | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'


-- 
Please avoid sending me Word or PowerPoint attachments.
 See http://www.fsf.org/philosophy/no-word-attachments.html 

