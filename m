Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129255AbQKXCaW>; Thu, 23 Nov 2000 21:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130373AbQKXCaM>; Thu, 23 Nov 2000 21:30:12 -0500
Received: from [209.249.10.20] ([209.249.10.20]:34780 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129255AbQKXC35>; Thu, 23 Nov 2000 21:29:57 -0500
Date: Thu, 23 Nov 2000 17:59:55 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: More PCI ID's for linux-2.4.0-test11/include/linux/pci_ids.h
Message-ID: <20001123175955.A7314@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch adds some missing PCI_VENDOR_ID's and
PCI_DEVICE_ID's that are scattered throughout a bunch of .c files in
drivers/isdn/hisax/.  The definitions in the .c files are protected
by '#ifndef PCI_VENDOR_ID_...', so it is not necessary to remove
those declarations from the .c files during the code freeze unless
you want to (and I would be happy to provide a patch for that too).

	I would like you to incorporate this patch, because it simplifies
a change that I have already made adding a PCI MODULE_DEVICE_TABLE
declaration to the hisax driver, needs to reference all of these values
in a single .c file (because all of those disparate .c files are currently
linked into a single module).

	Anyhow, it is a harmless patch.  Will you please apply it?
Please let me know if you have any questions.  Thank you.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci.diffs"

--- linux-2.4.0-test11/include/linux/pci_ids.h	Wed Nov  8 17:15:13 2000
+++ linux/include/linux/pci_ids.h	Thu Nov 23 17:49:57 2000
@@ -119,6 +119,9 @@
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
 
+#define PCI_VENDOR_ID_ASUSCOM		0x0675
+#define PCI_DEVICE_ID_ASUSCOM_TA1	0x1702
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_1280	0x3033
@@ -380,6 +383,10 @@
 #define PCI_DEVICE_ID_OPTI_82C861	0xc861
 #define PCI_DEVICE_ID_OPTI_82C825	0xd568
 
+#define PCI_VENDOR_ID_ELSA		0x1048
+#define PCI_DEVICE_ID_ELSA_MIRCOLINK	0x1000
+#define PCI_DEVICE_ID_ELSA_QS3000	0x3000
+
 #define PCI_VENDOR_ID_SGS		0x104a
 #define PCI_DEVICE_ID_SGS_2000		0x0008
 #define PCI_DEVICE_ID_SGS_1764		0x0009
@@ -561,15 +568,20 @@
 #define PCI_DEVICE_ID_WINBOND_83769	0x0001
 #define PCI_DEVICE_ID_WINBOND_82C105	0x0105
 #define PCI_DEVICE_ID_WINBOND_83C553	0x0565
+#define PCI_DEVICE_ID_WINBOND_6692	0x6692
 
 #define PCI_VENDOR_ID_DATABOOK		0x10b3
 #define PCI_DEVICE_ID_DATABOOK_87144	0xb106
 
 #define PCI_VENDOR_ID_PLX		0x10b5
+#define PCI_DEVICE_ID_SATSAGEM_NICCY	0x1016
+#define PCI_DEVICE_ID_PLX_R685		0x1030
 #define PCI_VENDOR_ID_PLX_ROMULUS	0x106a
 #define PCI_DEVICE_ID_PLX_SPCOM800	0x1076
 #define PCI_DEVICE_ID_PLX_1077		0x1077
 #define PCI_DEVICE_ID_PLX_SPCOM200	0x1103
+#define PCI_DEVICE_ID_PLX_DJINN_ITOO	0x1151
+#define PCI_DEVICE_ID_PLX_R753		0x1152
 #define PCI_DEVICE_ID_PLX_9050		0x9050
 #define PCI_DEVICE_ID_PLX_9060		0x9060
 #define PCI_DEVICE_ID_PLX_9060ES	0x906E
@@ -798,6 +810,11 @@
 #define PCI_DEVICE_ID_PHILIPS_SAA7145	0x7145
 #define PCI_DEVICE_ID_PHILIPS_SAA7146	0x7146
 
+#define PCI_VENDOR_ID_EICON		0x1133
+#define PCI_DEVICE_ID_EICON_DIVA20	0xe002
+#define PCI_DEVICE_ID_EICON_DIVA20_U	0xe004
+#define PCI_DEVICE_ID_EICON_DIVA201	0xe005
+
 #define PCI_VENDOR_ID_CYCLONE		0x113c
 #define PCI_DEVICE_ID_CYCLONE_SDK	0x0001
 
@@ -1328,6 +1345,7 @@
 
 #define PCI_VENDOR_ID_TIGERJET		0xe159
 #define PCI_DEVICE_ID_TIGERJET_300	0x0001
+#define PCI_DEVICE_ID_TIGERJET_100	0x0002
 
 #define PCI_VENDOR_ID_ARK		0xedd8
 #define PCI_DEVICE_ID_ARK_STING		0xa091

--DocE+STaALJfprDB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
