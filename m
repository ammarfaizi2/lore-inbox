Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132603AbQLHUt7>; Fri, 8 Dec 2000 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132739AbQLHUtt>; Fri, 8 Dec 2000 15:49:49 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:50029
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132603AbQLHUtk>; Fri, 8 Dec 2000 15:49:40 -0500
Date: Fri, 8 Dec 2000 21:19:08 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warning from drivers/net/hp100.c (240-test12-pre7)
Message-ID: <20001208211908.D599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch removes a 'defined but not used' warning from drivers/
new/hp100.c when compiling without CONFIG_PCI (240t12p3). It should apply
cleanly.


--- linux-240-t12-pre3-clean/drivers/net/hp100.c	Sat Nov  4 23:27:07 2000
+++ linux/drivers/net/hp100.c	Sat Dec  2 16:07:27 2000
@@ -265,12 +265,14 @@
 
 #define HP100_EISA_IDS_SIZE	(sizeof(hp100_eisa_ids)/sizeof(struct hp100_eisa_id))
 
+#ifdef CONFIG_PCI
 static struct hp100_pci_id hp100_pci_ids[] = {
   { PCI_VENDOR_ID_HP, 		PCI_DEVICE_ID_HP_J2585A },
   { PCI_VENDOR_ID_HP,		PCI_DEVICE_ID_HP_J2585B },
   { PCI_VENDOR_ID_COMPEX,	PCI_DEVICE_ID_COMPEX_ENET100VG4 },
   { PCI_VENDOR_ID_COMPEX2,	PCI_DEVICE_ID_COMPEX2_100VG }
 };
+#endif
 
 #define HP100_PCI_IDS_SIZE	(sizeof(hp100_pci_ids)/sizeof(struct hp100_pci_id))
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

We're going to turn this team around 360 degrees.
-Jason Kidd, upon his drafting to the Dallas Mavericks
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
