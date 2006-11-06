Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753483AbWKFRKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbWKFRKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbWKFRKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:10:15 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:50338 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1753485AbWKFRKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:10:13 -0500
Message-Id: <20061106170510.233488000@mvista.com>
User-Agent: quilt/0.45-1
Date: Mon, 06 Nov 2006 09:05:10 -0800
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
Cc: John Stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: [PATCH] clocksource: small acpi_pm cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corrects two white space errors, and flags acpi_pm_good as __devinitdata.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>
Acked-by: John Stultz <johnstul@us.ibm.com>

---
 drivers/clocksource/acpi_pm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.18/drivers/clocksource/acpi_pm.c
===================================================================
--- linux-2.6.18.orig/drivers/clocksource/acpi_pm.c
+++ linux-2.6.18/drivers/clocksource/acpi_pm.c
@@ -77,11 +77,11 @@ static struct clocksource clocksource_ac
 
 
 #ifdef CONFIG_PCI
-static int acpi_pm_good;
+static int __devinitdata acpi_pm_good;
 static int __init acpi_pm_good_setup(char *__str)
 {
-       acpi_pm_good = 1;
-       return 1;
+	acpi_pm_good = 1;
+	return 1;
 }
 __setup("acpi_pm_good", acpi_pm_good_setup);
 
--

