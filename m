Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273015AbTHPObG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273018AbTHPObF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:31:05 -0400
Received: from AMarseille-201-1-3-2.w193-253.abo.wanadoo.fr ([193.253.250.2]:1832
	"EHLO gaston") by vger.kernel.org with ESMTP id S273015AbTHPOay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:30:54 -0400
Subject: [PATCH] Fix incorrect pci_ids.h for Radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061044180.575.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 16:29:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

A recent patch from James had incorrect PCI IDs for a few Radeon
chips (the Radeon M9 chips Ld,Le,Lf and Lg, he used the IDs of the
Id,Ie,If and Ig instead). This patch fixes this and group the
properly by family (those got a bit shuffled around lately).

Please apply,
Ben.

diff -urN linux-2.5/include/linux/pci_ids.h linuxppc-2.5-benh/include/linux/pci_ids.h
--- linux-2.5/include/linux/pci_ids.h	2003-08-16 11:52:00.000000000 +0200
+++ linuxppc-2.5-benh/include/linux/pci_ids.h	2003-08-16 16:19:05.000000000 +0200
@@ -209,9 +209,29 @@
 #define PCI_DEVICE_ID_ATI_215_LR	0x4c52
 #define PCI_DEVICE_ID_ATI_215_LS	0x4c53
 #define PCI_DEVICE_ID_ATI_264_LT	0x4c54
-/* Radeon M4 */
-#define PCI_DEVICE_ID_ATI_RADEON_LE	0x4d45
-#define PCI_DEVICE_ID_ATI_RADEON_LF	0x4d46
+/* Mach64 VT */
+#define PCI_DEVICE_ID_ATI_264VT		0x5654
+#define PCI_DEVICE_ID_ATI_264VU		0x5655
+#define PCI_DEVICE_ID_ATI_264VV		0x5656
+/* Rage128 GL */
+#define PCI_DEVICE_ID_ATI_RAGE128_RE	0x5245
+#define PCI_DEVICE_ID_ATI_RAGE128_RF	0x5246
+#define PCI_DEVICE_ID_ATI_RAGE128_RG	0x534b
+#define PCI_DEVICE_ID_ATI_RAGE128_RH	0x534c
+#define PCI_DEVICE_ID_ATI_RAGE128_RI	0x534d
+/* Rage128 VR */
+#define PCI_DEVICE_ID_ATI_RAGE128_RK	0x524b
+#define PCI_DEVICE_ID_ATI_RAGE128_RL	0x524c
+#define PCI_DEVICE_ID_ATI_RAGE128_RM	0x5345
+#define PCI_DEVICE_ID_ATI_RAGE128_RN	0x5346
+#define PCI_DEVICE_ID_ATI_RAGE128_RO	0x5347
+/* Rage128 M3 */
+#define PCI_DEVICE_ID_ATI_RAGE128_LE	0x4c45
+#define PCI_DEVICE_ID_ATI_RAGE128_LF	0x4c46
+/* Rage128 Pro Ultra */
+#define PCI_DEVICE_ID_ATI_RAGE128_U1	0x5446
+#define PCI_DEVICE_ID_ATI_RAGE128_U2	0x544C
+#define PCI_DEVICE_ID_ATI_RAGE128_U3	0x5452
 /* Rage128 Pro GL */
 #define PCI_DEVICE_ID_ATI_Rage128_PA	0x5041
 #define PCI_DEVICE_ID_ATI_Rage128_PB	0x5042
@@ -239,75 +259,69 @@
 #define PCI_DEVICE_ID_ATI_RAGE128_PV	0x5056
 #define PCI_DEVICE_ID_ATI_RAGE128_PW	0x5057
 #define PCI_DEVICE_ID_ATI_RAGE128_PX	0x5058
+/* Rage128 M4 */
+#define PCI_DEVICE_ID_ATI_RADEON_LE	0x4d45
+#define PCI_DEVICE_ID_ATI_RADEON_LF	0x4d46
 /* Radeon R100 */
 #define PCI_DEVICE_ID_ATI_RADEON_QD	0x5144
 #define PCI_DEVICE_ID_ATI_RADEON_QE	0x5145
 #define PCI_DEVICE_ID_ATI_RADEON_QF	0x5146
 #define PCI_DEVICE_ID_ATI_RADEON_QG	0x5147
+/* Radeon RV100 (VE) */
+#define PCI_DEVICE_ID_ATI_RADEON_QY	0x5159
+#define PCI_DEVICE_ID_ATI_RADEON_QZ	0x515a
 /* Radeon R200 (8500) */
 #define PCI_DEVICE_ID_ATI_RADEON_QL	0x514c
 #define PCI_DEVICE_ID_ATI_RADEON_QN	0x514e
 #define PCI_DEVICE_ID_ATI_RADEON_QO	0x514f
 #define PCI_DEVICE_ID_ATI_RADEON_Ql	0x516c
 #define PCI_DEVICE_ID_ATI_RADEON_BB	0x4242
+/* Radeon R200 (9100) */
+#define PCI_DEVICE_ID_ATI_RADEON_QM	0x514d
 /* Radeon RV200 (7500) */
 #define PCI_DEVICE_ID_ATI_RADEON_QW	0x5157
 #define PCI_DEVICE_ID_ATI_RADEON_QX	0x5158
 /* Radeon NV-100 */
 #define PCI_DEVICE_ID_ATI_RADEON_N1	0x5159
 #define PCI_DEVICE_ID_ATI_RADEON_N2	0x515a
-/* Radeon RV100 (VE) */
-#define PCI_DEVICE_ID_ATI_RADEON_QY	0x5159
-#define PCI_DEVICE_ID_ATI_RADEON_QZ	0x515a
 /* Radeon RV250 (9000) */
 #define PCI_DEVICE_ID_ATI_RADEON_Id	0x4964
 #define PCI_DEVICE_ID_ATI_RADEON_Ie	0x4965
 #define PCI_DEVICE_ID_ATI_RADEON_If	0x4966
 #define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
-#define PCI_DEVICE_ID_ATI_RADEON_QM	0x514d
+/* Radeon RV280 (9200) */
+#define PCI_DEVICE_ID_ATI_RADEON_Y_	0x5960
+/* Radeon R300 (9500) */
+#define PCI_DEVICE_ID_ATI_RADEON_AD	0x4144
 /* Radeon R300 (9700) */
 #define PCI_DEVICE_ID_ATI_RADEON_ND	0x4e44
 #define PCI_DEVICE_ID_ATI_RADEON_NE	0x4e45
 #define PCI_DEVICE_ID_ATI_RADEON_NF	0x4e46
 #define PCI_DEVICE_ID_ATI_RADEON_NG	0x4e47
+#define PCI_DEVICE_ID_ATI_RADEON_AE	0x4145
+#define PCI_DEVICE_ID_ATI_RADEON_AF	0x4146
+/* Radeon R350 (9800) */
+#define PCI_DEVICE_ID_ATI_RADEON_NH	0x4e48
+#define PCI_DEVICE_ID_ATI_RADEON_NI	0x4e49
+/* Radeon RV350 (9600) */
+#define PCI_DEVICE_ID_ATI_RADEON_AP	0x4150
+#define PCI_DEVICE_ID_ATI_RADEON_AR	0x4152
 /* Radeon M6 */
 #define PCI_DEVICE_ID_ATI_RADEON_LY	0x4c59
 #define PCI_DEVICE_ID_ATI_RADEON_LZ	0x4c5a
 /* Radeon M7 */
 #define PCI_DEVICE_ID_ATI_RADEON_LW	0x4c57
 #define PCI_DEVICE_ID_ATI_RADEON_LX	0x4c58
-#define PCI_DEVICE_ID_ATI_RADEON_Ld	0x4964
-#define PCI_DEVICE_ID_ATI_RADEON_Le	0x4965
-#define PCI_DEVICE_ID_ATI_RADEON_Lf	0x4966
-#define PCI_DEVICE_ID_ATI_RADEON_Lg	0x4967
+/* Radeon M9 */
+#define PCI_DEVICE_ID_ATI_RADEON_Ld	0x4c64
+#define PCI_DEVICE_ID_ATI_RADEON_Le	0x4c65
+#define PCI_DEVICE_ID_ATI_RADEON_Lf	0x4c66
+#define PCI_DEVICE_ID_ATI_RADEON_Lg	0x4c67
 /* Radeon */
 #define PCI_DEVICE_ID_ATI_RADEON_RA	0x5144
 #define PCI_DEVICE_ID_ATI_RADEON_RB	0x5145
 #define PCI_DEVICE_ID_ATI_RADEON_RC	0x5146
 #define PCI_DEVICE_ID_ATI_RADEON_RD	0x5147
-/* Rage128 GL */
-#define PCI_DEVICE_ID_ATI_RAGE128_RE	0x5245
-#define PCI_DEVICE_ID_ATI_RAGE128_RF	0x5246
-#define PCI_DEVICE_ID_ATI_RAGE128_RG	0x534b
-#define PCI_DEVICE_ID_ATI_RAGE128_RH	0x534c
-#define PCI_DEVICE_ID_ATI_RAGE128_RI	0x534d
-/* Rage128 VR */
-#define PCI_DEVICE_ID_ATI_RAGE128_RK	0x524b
-#define PCI_DEVICE_ID_ATI_RAGE128_RL	0x524c
-#define PCI_DEVICE_ID_ATI_RAGE128_RM	0x5345
-#define PCI_DEVICE_ID_ATI_RAGE128_RN	0x5346
-#define PCI_DEVICE_ID_ATI_RAGE128_RO	0x5347
-/* Rage128 M3 */
-#define PCI_DEVICE_ID_ATI_RAGE128_LE	0x4c45
-#define PCI_DEVICE_ID_ATI_RAGE128_LF	0x4c46
-/* Rage128 Pro Ultra */
-#define PCI_DEVICE_ID_ATI_RAGE128_U1	0x5446
-#define PCI_DEVICE_ID_ATI_RAGE128_U2	0x544C
-#define PCI_DEVICE_ID_ATI_RAGE128_U3	0x5452
-/* Mach64 VT */
-#define PCI_DEVICE_ID_ATI_264VT		0x5654
-#define PCI_DEVICE_ID_ATI_264VU		0x5655
-#define PCI_DEVICE_ID_ATI_264VV		0x5656
 /* RadeonIGP */
 #define PCI_DEVICE_ID_ATI_RS100		0xcab0
 #define PCI_DEVICE_ID_ATI_RS200		0xcab2

