Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUA3Bgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266518AbUA3Bgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:36:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:13532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266523AbUA3BcI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:08 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263092718@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:49 -0800
Message-Id: <10754263091239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1516, 2004/01/29 15:34:24-08:00, mort@wildopensource.com

[PATCH] PCI Hotplug: Trivial warning fix

This just gets rid of a stupid compile warning.


 drivers/pci/hotplug/acpiphp_glue.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Thu Jan 29 17:24:18 2004
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Thu Jan 29 17:24:18 2004
@@ -245,7 +245,9 @@
 	acpi_resource_to_address64(resource, &address);
 
 	if (address.producer_consumer == ACPI_PRODUCER && address.address_length > 0) {
-		dbg("resource type: %d: 0x%llx - 0x%llx\n", address.resource_type, address.min_address_range, address.max_address_range);
+		dbg("resource type: %d: 0x%llx - 0x%llx\n", address.resource_type,
+		    (unsigned long long)address.min_address_range,
+		    (unsigned long long)address.max_address_range);
 		res = acpiphp_make_resource(address.min_address_range,
 				    address.address_length);
 		if (!res) {

