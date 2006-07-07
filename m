Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWGGRT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWGGRT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWGGRT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:19:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:33474 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932204AbWGGRTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:19:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NqfdBtMzxr8vxMM6K7i4qHEKeu4q9cGFnHulxl+yy+tOJb9fArKWsPxhA3X+Y0VICjxy8UkNWFVJbZAjIhhqZIgbpdEIbD2z/bYqoiusdNOkQn1Y48ilCMcOG4Ckx43xpswFzRqhklt5teprais1ozC95nkFQxR7KZrHf3+jcQU=
Message-ID: <c6e8b8d90607071019o22433ffch9ccc986c27c11ffa@mail.gmail.com>
Date: Fri, 7 Jul 2006 19:19:23 +0200
From: "Adam Helms" <helms.adam@gmail.com>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] SATA: Add PCI-ID
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makes the AHCI driver detect the PCI ID 8086:27c0 (IDE interface:
Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage
Controller IDE (rev 01)) as an AHCI chipset.

8086:27c0 also works with ata_piix but it's much slower. 8086:27c0 is
shipped with  - among others - new HP Proliant servers.

Signed-off-by: Adam Helms <helms.adam@gmail.com>
---------

--- /usr/src/linux-source-2.6.15/drivers/scsi/ahci.c.orig
2006-07-07 19:07:14.000000000 +0200
+++ /usr/src/linux-source-2.6.15/drivers/scsi/ahci.c    2006-07-07
19:07:31.000000000 +0200
@@ -261,6 +261,8 @@ static const struct pci_device_id ahci_p
          board_ahci }, /* ICH6 */
        { PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_ahci }, /* ICH6M */
+       { PCI_VENDOR_ID_INTEL, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_ahci }, /* ICH7 */
        { PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_ahci }, /* ICH7 */
        { PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
