Return-Path: <linux-kernel-owner+w=401wt.eu-S1754670AbWL2G3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbWL2G3x (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbWL2G3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:29:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbWL2G3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:29:52 -0500
Date: Fri, 29 Dec 2006 01:29:49 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Fix implicit declarations in via-pmu
Message-ID: <20061229062949.GB23251@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/macintosh/via-pmu.c: In function 'pmac_suspend_devices':
drivers/macintosh/via-pmu.c:2014: error: implicit declaration of function 'pm_prepare_console'
drivers/macintosh/via-pmu.c: In function 'pmac_wakeup_devices':
drivers/macintosh/via-pmu.c:2139: error: implicit declaration of function 'pm_restore_console'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.19.noarch/drivers/macintosh/via-pmu.c~	2006-12-12 11:18:03.000000000 -0500
+++ linux-2.6.19.noarch/drivers/macintosh/via-pmu.c	2006-12-12 11:18:33.000000000 -0500
@@ -44,6 +44,7 @@
 #include <linux/sysdev.h>
 #include <linux/freezer.h>
 #include <linux/syscalls.h>
+#include <linux/suspend.h>
 #include <linux/cpu.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>



-- 
http://www.codemonkey.org.uk
