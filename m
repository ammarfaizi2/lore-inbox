Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKQVRv>; Fri, 17 Nov 2000 16:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129187AbQKQVRk>; Fri, 17 Nov 2000 16:17:40 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:2716 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129097AbQKQVR1>; Fri, 17 Nov 2000 16:17:27 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Nov 2000 12:47:23 -0800
Message-Id: <200011172047.MAA03712@adam.yggdrasil.com>
To: becker@scyld.com, linux-kernel@vger.kernel.org, shangh@realtek.com.tw
Subject: duplicate entries in rtl8129 driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Both linux-2.4.0-test12-pre6/drivers/net/rtl8129.c and
Don Becker's version at ftp.sycld.com appear to have identical
PCI device ID and vendor ID values for these two cards:

		SMC1211TX EZCard 10/100 (RealTek RTL8139)
		Accton MPX5030 (RealTek RTL8139)

	So, I do not see how the latter entry in pci_tbl is ever
matched.  I think the result would be that users of either card
will be told that they have an SMC1211TX EZCard 10/100.  I suggest
deleting the latter entry and combine its label into the previous
one, so it will be described as:

	SMC1211TX EZCard 10/100 or Accton MPX5030 (RealTek RTL8139)

	Comments?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
