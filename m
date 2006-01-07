Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752335AbWAGOet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbWAGOet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbWAGOet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:34:49 -0500
Received: from lust.fud.no ([213.145.167.25]:26117 "EHLO lust.fud.no")
	by vger.kernel.org with ESMTP id S1752335AbWAGOes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:34:48 -0500
Date: Sat, 7 Jan 2006 15:34:40 +0100
From: Tore Anderson <tore@fud.no>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Makefile: ensure mrproper removes .old_version
Message-ID: <20060107143440.GB3378@fud.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the final linking of vmlinux fails, the file .old_version are left
behind.  This patch ensures the mrproper target will remove it if
present.

Signed-off-by: Tore Anderson <tore@fud.no>

diff --git a/Makefile b/Makefile
index 599e744..50b07fa 100644
--- a/Makefile
+++ b/Makefile
@@ -984,7 +984,7 @@ CLEAN_FILES +=	vmlinux System.map \
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2
-MRPROPER_FILES += .config .config.old include/asm .version \
+MRPROPER_FILES += .config .config.old include/asm .version .old_version \
                   include/linux/autoconf.h include/linux/version.h \
                   Module.symvers tags TAGS cscope*
 
-- 
Tore Anderson
