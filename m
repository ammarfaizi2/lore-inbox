Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWAIVix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWAIVix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWAIVin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:38:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51727 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750737AbWAIVik convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:40 -0500
Subject: [PATCH 05/11] kbuild: ensure mrproper removes .old_version
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:24 +0100
Message-Id: <11368427044089@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tore Anderson <tore@fud.no>
Date: 1136644480 +0100

If the final linking of vmlinux fails, the file .old_version are left
behind.  This patch ensures the mrproper target will remove it if
present.

Signed-off-by: Tore Anderson <tore@fud.no>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

50aa88e2877f1375ba79d1be7a0ff4aa563741c7
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
1.0.GIT

