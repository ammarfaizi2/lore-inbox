Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVJQU2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVJQU2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVJQU2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:28:43 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:25794 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751326AbVJQU2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:28:42 -0400
Subject: [PATCH] mm trivial ia64/acpi breakage
From: Alex Williamson <alex.williamson@hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Mon, 17 Oct 2005 14:28:39 -0600
Message-Id: <1129580919.9621.33.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The git-acpi.patch changed the name of the "id" member of the
acpi_resource structure, but missed the below user.  Updating to the new
name.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>

diff -r 6bf6e9fcc962 arch/ia64/kernel/acpi-ext.c
--- a/arch/ia64/kernel/acpi-ext.c	Sun Oct 16 22:44:53 2005
+++ b/arch/ia64/kernel/acpi-ext.c	Mon Oct 17 14:27:14 2005
@@ -35,7 +35,7 @@
 	struct acpi_vendor_descriptor *descriptor;
 	u32 length;
 
-	if (resource->id != ACPI_RSTYPE_VENDOR)
+	if (resource->type != ACPI_RSTYPE_VENDOR)
 		return AE_OK;
 
 	vendor = (struct acpi_resource_vendor *)&resource->data;


