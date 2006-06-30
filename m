Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWF3LYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWF3LYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWF3LYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:24:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18836 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750860AbWF3LYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:24:01 -0400
Date: Fri, 30 Jun 2006 13:23:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] remove obsolete swsusp_encrypt
Message-ID: <20060630112354.GB669@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SWSUSP_ENCRYPT config option; it is no longer implemented.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 123d26a90b044be080ac096f25dd5bca629a72c4
tree 3e47b18b2cf69111d2d9aaca669d9548e2406a90
parent ee84a7fdcd1b872198532639da1fabecc522576d
author <pavel@amd.ucw.cz> Fri, 30 Jun 2006 13:22:02 +0200
committer <pavel@amd.ucw.cz> Fri, 30 Jun 2006 13:22:02 +0200

 kernel/power/Kconfig |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 857b4fa..ae44a70 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -100,18 +100,6 @@ config PM_STD_PARTITION
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
-config SWSUSP_ENCRYPT
-	bool "Encrypt suspend image"
-	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y || CRYPTO_AES_X86_64=y)
-	default ""
-	---help---
-	  To prevent data gathering from swap after resume you can encrypt
-	  the suspend image with a temporary key that is deleted on
-	  resume.
-
-	  Note that the temporary key is stored unencrypted on disk while the
-	  system is suspended.
-
 config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
