Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWDRJVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWDRJVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWDRJVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:21:07 -0400
Received: from mail.axxeo.de ([82.100.226.146]:38806 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S932166AbWDRJVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:21:05 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Greg Kroah-Hartmann <gregkh@suse.de>
Subject: [PATCH] Documentation: no more device ids
Date: Tue, 18 Apr 2006 11:20:55 +0200
User-Agent: KMail/1.7.2
References: <200604080348.47501.wolfgang@rohdewald.de> <20060411102821.715be424@localhost.localdomain> <443BEB92.6040104@pobox.com>
In-Reply-To: <443BEB92.6040104@pobox.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604181120.55783.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <netdev@axxeo.de>

Document that we don't like to add more PCI device ids
but are happy to accept PCI vendor ids for linux/include/pci_ids.h

Original text from Jeff Garzik.

Signed-off-by: Ingo Oeser <netdev@axxeo.de>

--- old/Documentation/pci.txt	2006-03-28 08:49:02.000000000 +0200
+++ new/Documentation/pci.txt	2006-04-18 11:13:52.000000000 +0200
@@ -259,7 +259,17 @@
 to be handled by platform and generic code, not individual drivers.
 
 
-8. Obsolete functions
+8. Vendor and device identifications
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+For the future, let's avoid adding device ids to include/linux/pci_ids.h.
+
+PCI_VENDOR_ID_xxx for vendors, and a hex constant for device ids.
+ 
+Rationale:  PCI_VENDOR_ID_xxx constants are re-used, but device ids are not.
+    Further, device ids are arbitrary hex numbers, normally used only in a 
+    single location, the pci_device_id table.
+
+9. Obsolete functions
 ~~~~~~~~~~~~~~~~~~~~~
 There are several functions which you might come across when trying to
 port an old driver to the new PCI interface.  They are no longer present
