Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTFJX5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTFJX4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:56:03 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:33424 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262262AbTFJXz4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:55:56 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055290315109@kroah.com>
Subject: [PATCH] And yet more PCI fixes for 2.5.70
In-Reply-To: <20030611001127.GA21057@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 17:11:55 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1395, 2003/06/10 14:16:41-07:00, greg@kroah.com

[PATCH] PCI: fix up usage of pci_present in drivers/ide/ide.c


 drivers/ide/ide.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Tue Jun 10 17:04:13 2003
+++ b/drivers/ide/ide.c	Tue Jun 10 17:04:13 2003
@@ -332,7 +332,7 @@
 		if (idebus_parameter) {
 			/* user supplied value */
 			system_bus_speed = idebus_parameter;
-		} else if (pci_present()) {
+		} else if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) != NULL) {
 			/* safe default value for PCI */
 			system_bus_speed = 33;
 		} else {

