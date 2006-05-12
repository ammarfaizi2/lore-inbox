Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWELKAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWELKAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWELKAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:00:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46244 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751104AbWELKAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:00:41 -0400
Date: Fri, 12 May 2006 12:00:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix hotplug kconfig help
Message-ID: <20060512100002.GA28636@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HOTPLUG_CPU entry says "Say Y..." then "Say N.". Slightly ugly, so I
fixed it up, and added remark about suspend on SMP as a bonus.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index c6fe99e..45b4589 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -758,10 +758,10 @@ config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
 	---help---
-	  Say Y here to experiment with turning CPUs off and on.  CPUs
-	  can be controlled through /sys/devices/system/cpu.
+	  Say Y here to experiment with turning CPUs off and on, and to 
+	  enable suspend on SMP systems. CPUs can be controlled through
+	  /sys/devices/system/cpu.
 
-	  Say N.
 
 endmenu
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
