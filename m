Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUDBQzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUDBQzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:55:13 -0500
Received: from gprs213-192.eurotel.cz ([160.218.213.192]:128 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264106AbUDBQzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:55:08 -0500
Date: Fri, 2 Apr 2004 14:46:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: suspend_s4bios needs asmlinkage, too
Message-ID: <20040402124642.GA1005@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Subject says it pretty much all, otherwise it will crash during S4bios
suspend with regparm=3. Please apply,

								Pavel
--- tmp/linux/drivers/acpi/hardware/hwsleep.c	2004-03-11 18:10:48.000000000 +0100
+++ linux/drivers/acpi/hardware/hwsleep.c	2004-03-11 18:16:06.000000000 +0100
@@ -394,7 +394,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status asmlinkage
 acpi_enter_sleep_state_s4bios (
 	void)
 {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
