Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVDDCP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVDDCP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVDDCPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:15:36 -0400
Received: from fmr18.intel.com ([134.134.136.17]:26270 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261976AbVDDCJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:09:12 -0400
Subject: [RFC 4/6]Add kconfig for S3 SMP
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1112580364.4194.342.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:06:57 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kconfig for IA32 S3 SMP.

Thanks,
Shaohua

---

 linux-2.6.11-root/kernel/power/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN kernel/power/Kconfig~smp_s3_kconfig kernel/power/Kconfig
--- linux-2.6.11/kernel/power/Kconfig~smp_s3_kconfig	2005-03-31 10:49:57.156487160 +0800
+++ linux-2.6.11-root/kernel/power/Kconfig	2005-03-31 10:49:57.158486856 +0800
@@ -72,3 +72,10 @@ config PM_STD_PARTITION
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+config STR_SMP
+	bool "Suspend to RAM SMP support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && ACPI_SLEEP && !X86_64
+	depends on HOTPLUG_CPU
+	default y
+	---help---
+	 enable Suspend to RAM SMP support. Some HT systems require this.
_


