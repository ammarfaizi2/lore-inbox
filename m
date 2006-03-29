Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWC2WIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWC2WIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWC2WIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:08:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44702 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751023AbWC2WIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:08:43 -0500
Date: Thu, 30 Mar 2006 00:08:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060329220808.GA1716@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HOTPLUG_CPU is needed on normal PCs, too -- it is neccessary for
software suspend.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 2206dab43d50723d6b15caa8821e8d97c6b5ef28
tree cbfc324e15d216aa91ce6a51927668076de5b7db
parent dd76aabd03933b80c61fa5b0c0c995950246c603
author <pavel@amd.ucw.cz> Thu, 30 Mar 2006 00:06:31 +0200
committer <pavel@amd.ucw.cz> Thu, 30 Mar 2006 00:06:31 +0200

 arch/i386/Kconfig      |    8 ++++----
 kernel/power/process.c |    3 +--
 kernel/signal.c        |    1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index f7db71d..955dc08 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -741,12 +741,12 @@ config PHYSICAL_START
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
 	---help---
-	  Say Y here to experiment with turning CPUs off and on.  CPUs
-	  can be controlled through /sys/devices/system/cpu.
+	  Say Y here to experiment with turning CPUs off and on, and to 
+	  enable suspend on SMP systems. CPUs can be controlled through
+	  /sys/devices/system/cpu.
 
-	  Say N.
 
 config DOUBLEFAULT
 	default y

-- 
Picture of sleeping (Linux) penguin wanted...
