Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267716AbTGHWVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbTGHWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:21:51 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:34960 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S267716AbTGHWUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:20:24 -0400
Date: Wed, 9 Jul 2003 00:34:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Grover <andrew.grover@intel.com>, torvalds@transmeta.com
Subject: Fix thinko in acpi
Message-ID: <20030708223444.GC183@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It probably is fixed in ACPI patches somewhere, but it surprises me it
is not yet in Linus' kernel. Please apply,
								Pavel

--- /usr/src/tmp/linux/drivers/acpi/sleep/main.c	2003-07-09 00:21:15.000000000 +0200
+++ /usr/src/linux/drivers/acpi/sleep/main.c	2003-07-09 00:13:14.000000000 +0200
@@ -244,7 +245,7 @@
 	/* do we have a wakeup address for S2 and S3? */
 	/* Here, we support only S4BIOS, those we set the wakeup address */
 	/* S4OS is only supported for now via swsusp.. */
-	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || ACPI_STATE_S4) {
+	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || state == ACPI_STATE_S4) {
 		if (!acpi_wakeup_address)
 			return AE_ERROR;
 		acpi_set_firmware_waking_vector((acpi_physical_address) acpi_wakeup_address);
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
