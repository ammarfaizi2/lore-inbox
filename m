Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbTGIJYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbTGIJYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:24:35 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:60342 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265893AbTGIJYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:24:31 -0400
From: Nathaniel Russell <reddog83@sbcglobal.net>
Reply-To: reddog83@sbcglobal.net
Organization: RedDog GNu/Linux
To: reddoglinux04@aol.com
Subject: [PATCH] ver_linux kernel 2.5-bk1 
Date: Wed, 9 Jul 2003 05:41:25 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FN+C/jA3tY5oiLV"
Message-Id: <200307090541.25483.reddog83@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_FN+C/jA3tY5oiLV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch correctly identifies the current version level of Modutils / 
Mod-Init Utils for Current 2.5 kernels.
It's a cosmetic change which wouldn't allow me to see the version of Mod Init 
with out this patch applied.
Please Apply 

Nathaniel Russell
--Boundary-00=_FN+C/jA3tY5oiLV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ver_linux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ver_linux.patch"

diff -urN scripts/ver_linux.old scripts/ver_linux
--- scripts/ver_linux.old	2003-07-09 05:35:09.000000000 -0400
+++ scripts/ver_linux	2003-07-09 05:35:31.000000000 -0400
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-depmod -V  2>&1 | grep version | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'

--Boundary-00=_FN+C/jA3tY5oiLV--

