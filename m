Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVBNK0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVBNK0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVBNK0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:26:06 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:58082 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261382AbVBNK0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:26:03 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] make ACPI_BLACKLIST_YEAR depend on ACPI
Date: Mon, 14 Feb 2005 11:30:51 +0100
User-Agent: KMail/1.7.2
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502141130.51901@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this oneliner fixes the situation that I can enter a year to blacklist
ACPI devices if ACPI is completely disabled.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.11-rc3/drivers/acpi/Kconfig	2005-02-07 21:12:45.000000000 +0100
+++ linux-2.6.11-rc3/drivers/acpi/Kconfig.fixed	2005-02-12 19:58:24.000000000 +0100
@@ -259,6 +259,7 @@
 
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year"
+	depends on ACPI
 	default 0
 	help
 	  enter a 4-digit year, eg. 2001 to disable ACPI by default
