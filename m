Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVCOV1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVCOV1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVCOV1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:27:05 -0500
Received: from ns.suse.de ([195.135.220.2]:52932 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261861AbVCOV05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:26:57 -0500
Date: Tue, 15 Mar 2005 22:26:56 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org
Subject: [PATCH] CONFIG_PM for ppc64, to allow sysrq o
Message-ID: <20050315212656.GA24563@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some weird reason, sysrq o is hidden behind CONFIG_PM.
Why? One can power off just fine without that. Can pm_sysrq_init be
moved to a better place? I think it used to be in sysrq.c in 2.4.

Too bad, with this patch radeonfb fails to compile.



Index: linux-2.6.11-olh/arch/ppc64/Kconfig
===================================================================
--- linux-2.6.11-olh.orig/arch/ppc64/Kconfig
+++ linux-2.6.11-olh/arch/ppc64/Kconfig
@@ -350,6 +350,8 @@ config CMDLINE
 
 endmenu
 
+source "kernel/power/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
