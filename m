Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTIIF0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 01:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbTIIF0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 01:26:36 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:51963 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S263968AbTIIF0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 01:26:34 -0400
Date: Tue, 9 Sep 2003 00:28:28 -0500
From: "Nathan T. Lynch" <ntl@pobox.com>
To: mec@shout.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove cscope.out during make mrproper
Message-ID: <20030909052828.GB1802@biclops.private.network>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi-

The attached patch fixes the toplevel Makefile to remove cscope.out
during make mrproper.  The default name for the database that cscope
creates is cscope.out, and this is what the cscope rule in the
makefile uses.  Currently, mrproper will leave cscope.out behind,
which can make for interesting diffs...

Please cc me on replies.

Nathan


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cscope.patch"

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Sep  8 23:56:59 2003
+++ b/Makefile	Mon Sep  8 23:56:59 2003
@@ -672,7 +672,7 @@
 	.menuconfig.log \
 	include/asm \
 	.hdepend include/linux/modversions.h \
-	tags TAGS cscope kernel.spec \
+	tags TAGS cscope.out kernel.spec \
 	.tmp*
 
 # Directories removed with 'make mrproper'

--XWOWbaMNXpFDWE00--
