Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVA0LRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVA0LRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVA0LQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:16:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57615 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262599AbVA0LEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:04:48 -0500
Date: Thu, 27 Jan 2005 12:04:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] #ifdef ACPI_FUTURE_USAGE acpi_ut_create_pkg_state_and_push
Message-ID: <20050127110443.GF28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype of the unused global function 
acpi_ut_create_pkg_state_and_push was already #ifdef 
ACPI_FUTURE_USAGE'd, but the actual function wasn't.

Most likely this was a bug in my patch that added
ACPI_FUTURE_USAGE.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c.old	2005-01-26 22:31:11.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c	2005-01-26 22:40:40.000000000 +0100
@@ -872,7 +885,7 @@
  * DESCRIPTION: Create a new state and push it
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ut_create_pkg_state_and_push (
 	void                            *internal_object,
@@ -894,7 +907,7 @@
 	acpi_ut_push_generic_state (state_list, state);
 	return (AE_OK);
 }
-
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *

