Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUBPVbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUBPVbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:31:53 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:45507 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265872AbUBPVbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:31:51 -0500
Date: Mon, 16 Feb 2004 16:31:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: lhcs-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6-mm] CPU hotplug needs a menu option
Message-ID: <Pine.LNX.4.58.0402161629150.11793@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for weenies such as myself who can't write out their own .configs
manually ;)

Index: linux-2.6.3-rc3-mm1/arch/i386/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/arch/i386/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.3-rc3-mm1/arch/i386/Kconfig	16 Feb 2004 20:42:34 -0000	1.1.1.1
+++ linux-2.6.3-rc3-mm1/arch/i386/Kconfig	16 Feb 2004 21:27:46 -0000
@@ -1237,6 +1237,15 @@ config HOTPLUG
 	  agent" (/sbin/hotplug) to load modules and set up software needed
 	  to use devices as you hotplug them.

+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	depends on SMP && HOTPLUG && EXPERIMENTAL
+	---help---
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
+	  Say N.
+
 source "drivers/pcmcia/Kconfig"

 source "drivers/pci/hotplug/Kconfig"
