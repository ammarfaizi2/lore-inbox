Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbSKZHmV>; Tue, 26 Nov 2002 02:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbSKZHmV>; Tue, 26 Nov 2002 02:42:21 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:44445 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266278AbSKZHmU>; Tue, 26 Nov 2002 02:42:20 -0500
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]  v850 additions to include/linux/elf.h
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 26 Nov 2002 16:49:31 +0900
In-Reply-To: <20021015181609.A31647@infradead.org>
Message-ID: <buoel987otw.fsf_-_@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

This patch adds more stuff to include/linux/elf.h for the v850 (used by
the new module loader).


Patch:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=v850-elfdefs-20021126.patch
Content-Description: v850-elfdefs-20021126.patch

diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/include/linux/elf.h include/linux/elf.h
--- ../orig/linux-2.5.49-uc0/include/linux/elf.h	2002-11-25 10:34:44.000000000 +0900
+++ include/linux/elf.h	2002-11-26 11:10:41.000000000 +0900
@@ -92,6 +92,9 @@
  */
 #define EM_ALPHA	0x9026
 
+/* Bogus old v850 magic number, used by old tools.  */
+#define EM_CYGNUS_V850	0x9080
+
 /*
  * This is the old interim value for S/390 architecture
  */
@@ -450,6 +453,31 @@
 /* Keep this the last entry.  */
 #define R_390_NUM	27
 
+
+/* v850 relocations.  */
+#define R_V850_NONE		0
+#define R_V850_9_PCREL		1
+#define R_V850_22_PCREL		2
+#define R_V850_HI16_S		3
+#define R_V850_HI16		4
+#define R_V850_LO16		5
+#define R_V850_32		6
+#define R_V850_16		7
+#define R_V850_8		8
+#define R_V850_SDA_16_16_OFFSET	9	/* For ld.b, st.b, set1, clr1,
+					   not1, tst1, movea, movhi */
+#define R_V850_SDA_15_16_OFFSET	10	/* For ld.w, ld.h, ld.hu, st.w, st.h */
+#define R_V850_ZDA_16_16_OFFSET	11	/* For ld.b, st.b, set1, clr1,
+					   not1, tst1, movea, movhi */
+#define R_V850_ZDA_15_16_OFFSET	12	/* For ld.w, ld.h, ld.hu, st.w, st.h */
+#define R_V850_TDA_6_8_OFFSET	13	/* For sst.w, sld.w */
+#define R_V850_TDA_7_8_OFFSET	14	/* For sst.h, sld.h */
+#define R_V850_TDA_7_7_OFFSET	15	/* For sst.b, sld.b */
+#define R_V850_TDA_16_16_OFFSET	16	/* For set1, clr1, not1, tst1,
+					   movea, movhi */
+#define R_V850_NUM		17
+
+
 /* Legal values for e_flags field of Elf64_Ehdr.  */
 
 #define EF_ALPHA_32BIT		1	/* All addresses are below 2GB */

--=-=-=



Thanks,

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that 
            will  make every christian in the world foamm at the mouth? 
[iddt]      nurg, that's the goal 

--=-=-=--
