Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbSLTEyb>; Thu, 19 Dec 2002 23:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267719AbSLTEyb>; Thu, 19 Dec 2002 23:54:31 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:49379 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S267692AbSLTEya>; Thu, 19 Dec 2002 23:54:30 -0500
Subject: [PATCH] 2.4.20 fs/partitions/Config.in
From: Richard Russon <ldm@flatcap.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1040360516.21624.14.camel@whiskey.something.uk.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.90 (Preview Release)
Date: 20 Dec 2002 05:01:56 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

You have already accepted the new LDM Driver into 2.4 (thanks :-)
but a little part of it got lost.

This patch removes the "experimental" tag and dependency.
(The new LDM Driver is not experimental).

Please can you apply this patch to 2.4.20.

Cheers,
  FlatCap (Richard Russon)
  ldm@flatcap.org



diff -urN linux-2.4.20/fs/partitions/Config.in linux-2.4.20-ldm/fs/partitions/Config.in
--- linux-2.4.20/fs/partitions/Config.in	2002-11-29 00:13:16.000000000 +0000
+++ linux-2.4.20-ldm/fs/partitions/Config.in	2002-12-20 04:41:32.000000000 +0000
@@ -25,7 +25,7 @@
       bool '    Solaris (x86) partition table support' CONFIG_SOLARIS_X86_PARTITION
       bool '    Unixware slices support' CONFIG_UNIXWARE_DISKLABEL
    fi
-   dep_bool '  Windows Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)' CONFIG_LDM_PARTITION $CONFIG_EXPERIMENTAL
+   bool '  Windows Logical Disk Manager (Dynamic Disk) support' CONFIG_LDM_PARTITION
    if [ "$CONFIG_LDM_PARTITION" = "y" ]; then
       bool '    Windows LDM extra logging' CONFIG_LDM_DEBUG
    fi




