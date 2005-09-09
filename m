Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVIIXiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVIIXiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVIIXiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:38:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932624AbVIIXiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:38:54 -0400
Date: Fri, 9 Sep 2005 19:38:32 -0400
From: Dave Jones <davej@redhat.com>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: processor_idle.c indentation fixes.
Message-ID: <20050909233832.GA2202@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, len.brown@intel.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

processor_idle.c vs Lindent resulted in something of a trainwreck
with inconsistent whitespace.  This diff rearranges the
processor_power_dmi_table to look like it did before that accident,
and adds two additional BIOS's to the list as encountered by
Fedora users.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=165590

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.13/drivers/acpi/processor_idle.c~	2005-09-09 19:24:25.000000000 -0400
+++ linux-2.6.13/drivers/acpi/processor_idle.c	2005-09-09 19:33:18.000000000 -0400
@@ -94,22 +94,27 @@ static int set_max_cstate(struct dmi_sys
 }
 
 static struct dmi_system_id __initdata processor_power_dmi_table[] = {
-	{set_max_cstate, "IBM ThinkPad R40e", {
-					       DMI_MATCH(DMI_BIOS_VENDOR,
-							 "IBM"),
-					       DMI_MATCH(DMI_BIOS_VERSION,
-							 "1SET60WW")},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	 DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+	 DMI_MATCH(DMI_BIOS_VERSION, "1SET60WW")},
 	 (void *)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	 DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	 DMI_MATCH(DMI_BIOS_VERSION,"1SET61WW")},
+	 (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	 DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	 DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") },
+	 (void*)1},
+
 	{set_max_cstate, "Medion 41700", {
-					  DMI_MATCH(DMI_BIOS_VENDOR,
-						    "Phoenix Technologies LTD"),
-					  DMI_MATCH(DMI_BIOS_VERSION,
-						    "R01-A1J")}, (void *)1},
+	 DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+	 DMI_MATCH(DMI_BIOS_VERSION, "R01-A1J")},
+	 (void *)1},
+
 	{set_max_cstate, "Clevo 5600D", {
-					 DMI_MATCH(DMI_BIOS_VENDOR,
-						   "Phoenix Technologies LTD"),
-					 DMI_MATCH(DMI_BIOS_VERSION,
-						   "SHE845M0.86C.0013.D.0302131307")},
+	 DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+	 DMI_MATCH(DMI_BIOS_VERSION, "SHE845M0.86C.0013.D.0302131307")},
 	 (void *)2},
 	{},
 };
