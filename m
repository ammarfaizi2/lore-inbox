Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbUKMALZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUKMALZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUKMAH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:07:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54540 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262779AbUKMAGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:06:00 -0500
Date: Sat, 13 Nov 2004 01:05:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let ACPI_BLACKLIST_YEAR depend on ACPI_INTERPRETER
Message-ID: <20041113000526.GP2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_BLACKLIST_YEAR has no effect without ACPI_INTERPRETER, so there's 
no point asking it if ACPI_INTERPRETER=n.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/acpi/Kconfig.old	2004-11-13 01:01:43.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/acpi/Kconfig	2004-11-13 01:02:22.000000000 +0100
@@ -270,6 +270,7 @@
 
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year"
+	depends on ACPI_INTERPRETER
 	default 0
 	help
 	  enter a 4-digit year, eg. 2001 to disable ACPI by default

