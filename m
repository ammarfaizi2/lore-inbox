Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVLMB7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVLMB7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 20:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVLMB7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 20:59:15 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:19086 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932351AbVLMB7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 20:59:14 -0500
Date: Tue, 13 Dec 2005 02:58:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [2.6 patch] allow KOBJECT_UEVENT=n only if EMBEDDED
Message-ID: <20051213015806.GV23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KOBJECT_UEVENT=n seems to be a common pitfall for udev users in 2.6.14 .

-mm already contains a bigger patch removing this option that is IMHO 
too big for being applied now to 2.6.15-rc.

This patch simply allows KOBJECT_UEVENT=n only if EMBEDDED.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5/init/Kconfig.old	2005-12-13 02:53:36.000000000 +0100
+++ linux-2.6.15-rc5/init/Kconfig	2005-12-13 02:54:26.000000000 +0100
@@ -206,7 +206,7 @@
 	  outside the kernel tree does. Such modules require Y here.
 
 config KOBJECT_UEVENT
-	bool "Kernel Userspace Events"
+	bool "Kernel Userspace Events" if EMBEDDED
 	depends on NET
 	default y
 	help

