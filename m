Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWAIVkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWAIVkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWAIVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:39:10 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:22800 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750737AbWAIVjG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:39:06 -0500
Subject: [PATCH 10/11] kbuild/xfs: introduce fs/xfs/Kbuild
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:49 +0100
Message-Id: <11368427293981@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In kbuild the file named 'Kbuild' has precedence over the file named
Makefile. Utilise a file named Kbuild to include the 2.6 Makefile for xfs
- since the xfs people likes to keep their arch specific Makefiles separate.

With this patch xfs does no longer rely on the KERNELRELEASE components to be global.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 fs/xfs/Kbuild |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 fs/xfs/Kbuild

a9aa1ffaac7c8d6f093bb8f7cdeea761a5e25f53
diff --git a/fs/xfs/Kbuild b/fs/xfs/Kbuild
new file mode 100644
index 0000000..2566e96
--- /dev/null
+++ b/fs/xfs/Kbuild
@@ -0,0 +1,6 @@
+#
+# The xfs people like to share Makefile with 2.6 and 2.4.
+# Utilise file named Kbuild file which has precedence over Makefile.
+#
+
+include $(srctree)/$(obj)/Makefile-linux-2.6
-- 
1.0.GIT

