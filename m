Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUINVgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUINVgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269232AbUINVfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:35:17 -0400
Received: from mail.broadpark.no ([217.13.4.2]:139 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267209AbUINVdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:33:14 -0400
Message-ID: <41476413.1060100@linux-user.net>
Date: Tue, 14 Sep 2004 23:35:15 +0200
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] README (resend) - Explain new 2.6.xx.x version number
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one ended up in the void last time without any comments.

Daniel Andersen

--

diff -urN linux/README.orig linux/README
--- linux/README.orig    2004-08-14 07:37:40.000000000 +0200
+++ linux/README    2004-08-27 17:16:55.107413637 +0200
@@ -76,6 +76,23 @@
     the backup files (xxx~ or xxx.orig), and make sure that there are no
     failed patches (xxx# or xxx.rej). If there are, either you or me has
     made a mistake.
+
+   As of kernel 2.6.8 there was a bug-fix release numbering scheme
+   introduced. In such cases a fourth number is added to the release
+   version, eg. 2.6.8.1. When patching from a 2.6.xx(.x) release to a
+   newer version, patches are to be applied against the original
+   release, eg. 2.6.8 and not the bug-fix release 2.6.8.1. In case of a
+   bug-fix release such as if eg. 2.6.8.2 is released after 2.6.9 has
+   been released, 2.6.9 is still to be considered the newest kernel
+   release of all current kernels. Old patches can be reversed by
+   adding the "-R" option to the patch tool.
+
+                Example to apply a bugfix release patch:
+                bzip2 -dc ../patch-2.6.8.1.bz2 | patch -p1
+
+                Example to apply a new release on a bugfix tree:
+                bzip2 -dc ../patch-2.6.8.1.bz2 | patch -p1 -R
+                bzip2 -dc ../patch-2.6.9.bz2 | patch -p1

     Alternatively, the script patch-kernel can be used to automate this
     process.  It determines the current kernel version and applies any
