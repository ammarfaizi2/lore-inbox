Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUBBMGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUBBMGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:06:41 -0500
Received: from relay1.camcontacts.net ([195.149.126.45]:5281 "EHLO
	relay1.camcontacts.net") by vger.kernel.org with ESMTP
	id S265398AbUBBMGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:06:40 -0500
Message-ID: <01db01c3e985$df52e5e0$33e613c2@nod.ro>
From: "Dan Podeanu" <kernel@ccnetwork.com>
To: <linux-kernel@vger.kernel.org>
Subject: megaraid and 2.6.1
Date: Mon, 2 Feb 2004 14:12:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Chris Meador's patch regarding megaraid PCI IDs fixup in 2.6.1-rcX didn't
make it
in 2.6.1 so certain megaraid devices (320-1, 320-2, presumably others
aswell) aren't
recognized by 2.6.1.

>From drivers/scsi/megaraid.c:

        {PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},


While, according to Chris' patch:

--- linux-2.6.1-rc3.orig/drivers/scsi/megaraid.c 2004-01-08
12:14:51.000000000 -0500
+++ linux-2.6.1-rc3/drivers/scsi/megaraid.c 2004-01-08
12:01:24.000000000 -0500
@@ -5093,7 +5093,7 @@
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_AMI_MEGARAID3,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
- {PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID,
+ {PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
{0,}
};


Anyone knows whats the status of this problem ? Does the patch fixes it ?

Regards,
Dan.

