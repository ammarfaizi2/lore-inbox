Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbTEXI0a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 04:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbTEXI0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 04:26:30 -0400
Received: from ns.suse.de ([213.95.15.193]:51730 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264222AbTEXI03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 04:26:29 -0400
Date: Sat, 24 May 2003 10:39:36 +0200
From: Andi Kleen <ak@suse.de>
To: andrew.grover@intel.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Make ACPI compile again on 64bit/gcc 3.3
Message-ID: <20030524083936.GA7594@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without this patch ACPI in BK-CVS current does not compile on AMD64/gcc 3.3.

-Andi


Index: linux/include/acpi/acpiosxf.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/acpi/acpiosxf.h,v
retrieving revision 1.7
diff -u -u -r1.7 acpiosxf.h
--- linux/include/acpi/acpiosxf.h	24 May 2003 01:49:28 -0000	1.7
+++ linux/include/acpi/acpiosxf.h	24 May 2003 07:32:37 -0000
@@ -287,15 +287,15 @@
  * Miscellaneous
  */
 
-u8
+BOOLEAN
 acpi_os_readable (
 	void                            *pointer,
-	acpi_size                       length);
+	u32                       	length);
 
-u8
+BOOLEAN
 acpi_os_writable (
 	void                            *pointer,
-	acpi_size                       length);
+	u32                       	length);
 
 u32
 acpi_os_get_timer (
