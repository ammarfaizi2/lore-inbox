Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTEJJrl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTEJJrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:47:41 -0400
Received: from palrel11.hp.com ([156.153.255.246]:28568 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263737AbTEJJrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:47:37 -0400
Date: Sat, 10 May 2003 03:00:16 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200305101000.h4AA0Gg4012209@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: TRIVIAL: Add ia64 relocation types to elf.h
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Subject says it all.

Thanks,

	--david

diff -Nru a/include/linux/elf.h b/include/linux/elf.h
--- a/include/linux/elf.h	Sat May 10 01:47:42 2003
+++ b/include/linux/elf.h	Sat May 10 01:47:42 2003
@@ -229,6 +229,90 @@
 #define R_386_GOTPC	10
 #define R_386_NUM	11
 
+#define R_IA64_NONE		0x00	/* none */
+#define R_IA64_IMM14		0x21	/* symbol + addend, add imm14 */
+#define R_IA64_IMM22		0x22	/* symbol + addend, add imm22 */
+#define R_IA64_IMM64		0x23	/* symbol + addend, mov imm64 */
+#define R_IA64_DIR32MSB		0x24	/* symbol + addend, data4 MSB */
+#define R_IA64_DIR32LSB		0x25	/* symbol + addend, data4 LSB */
+#define R_IA64_DIR64MSB		0x26	/* symbol + addend, data8 MSB */
+#define R_IA64_DIR64LSB		0x27	/* symbol + addend, data8 LSB */
+#define R_IA64_GPREL22		0x2a	/* @gprel(sym+add), add imm22 */
+#define R_IA64_GPREL64I		0x2b	/* @gprel(sym+add), mov imm64 */
+#define R_IA64_GPREL32MSB	0x2c	/* @gprel(sym+add), data4 MSB */
+#define R_IA64_GPREL32LSB	0x2d	/* @gprel(sym+add), data4 LSB */
+#define R_IA64_GPREL64MSB	0x2e	/* @gprel(sym+add), data8 MSB */
+#define R_IA64_GPREL64LSB	0x2f	/* @gprel(sym+add), data8 LSB */
+#define R_IA64_LTOFF22		0x32	/* @ltoff(sym+add), add imm22 */
+#define R_IA64_LTOFF64I		0x33	/* @ltoff(sym+add), mov imm64 */
+#define R_IA64_PLTOFF22		0x3a	/* @pltoff(sym+add), add imm22 */
+#define R_IA64_PLTOFF64I	0x3b	/* @pltoff(sym+add), mov imm64 */
+#define R_IA64_PLTOFF64MSB	0x3e	/* @pltoff(sym+add), data8 MSB */
+#define R_IA64_PLTOFF64LSB	0x3f	/* @pltoff(sym+add), data8 LSB */
+#define R_IA64_FPTR64I		0x43	/* @fptr(sym+add), mov imm64 */
+#define R_IA64_FPTR32MSB	0x44	/* @fptr(sym+add), data4 MSB */
+#define R_IA64_FPTR32LSB	0x45	/* @fptr(sym+add), data4 LSB */
+#define R_IA64_FPTR64MSB	0x46	/* @fptr(sym+add), data8 MSB */
+#define R_IA64_FPTR64LSB	0x47	/* @fptr(sym+add), data8 LSB */
+#define R_IA64_PCREL60B		0x48	/* @pcrel(sym+add), brl */
+#define R_IA64_PCREL21B		0x49	/* @pcrel(sym+add), ptb, call */
+#define R_IA64_PCREL21M		0x4a	/* @pcrel(sym+add), chk.s */
+#define R_IA64_PCREL21F		0x4b	/* @pcrel(sym+add), fchkf */
+#define R_IA64_PCREL32MSB	0x4c	/* @pcrel(sym+add), data4 MSB */
+#define R_IA64_PCREL32LSB	0x4d	/* @pcrel(sym+add), data4 LSB */
+#define R_IA64_PCREL64MSB	0x4e	/* @pcrel(sym+add), data8 MSB */
+#define R_IA64_PCREL64LSB	0x4f	/* @pcrel(sym+add), data8 LSB */
+#define R_IA64_LTOFF_FPTR22	0x52	/* @ltoff(@fptr(s+a)), imm22 */
+#define R_IA64_LTOFF_FPTR64I	0x53	/* @ltoff(@fptr(s+a)), imm64 */
+#define R_IA64_LTOFF_FPTR32MSB	0x54	/* @ltoff(@fptr(s+a)), 4 MSB */
+#define R_IA64_LTOFF_FPTR32LSB	0x55	/* @ltoff(@fptr(s+a)), 4 LSB */
+#define R_IA64_LTOFF_FPTR64MSB	0x56	/* @ltoff(@fptr(s+a)), 8 MSB */
+#define R_IA64_LTOFF_FPTR64LSB	0x57	/* @ltoff(@fptr(s+a)), 8 LSB */
+#define R_IA64_SEGREL32MSB	0x5c	/* @segrel(sym+add), data4 MSB */
+#define R_IA64_SEGREL32LSB	0x5d	/* @segrel(sym+add), data4 LSB */
+#define R_IA64_SEGREL64MSB	0x5e	/* @segrel(sym+add), data8 MSB */
+#define R_IA64_SEGREL64LSB	0x5f	/* @segrel(sym+add), data8 LSB */
+#define R_IA64_SECREL32MSB	0x64	/* @secrel(sym+add), data4 MSB */
+#define R_IA64_SECREL32LSB	0x65	/* @secrel(sym+add), data4 LSB */
+#define R_IA64_SECREL64MSB	0x66	/* @secrel(sym+add), data8 MSB */
+#define R_IA64_SECREL64LSB	0x67	/* @secrel(sym+add), data8 LSB */
+#define R_IA64_REL32MSB		0x6c	/* data 4 + REL */
+#define R_IA64_REL32LSB		0x6d	/* data 4 + REL */
+#define R_IA64_REL64MSB		0x6e	/* data 8 + REL */
+#define R_IA64_REL64LSB		0x6f	/* data 8 + REL */
+#define R_IA64_LTV32MSB		0x74	/* symbol + addend, data4 MSB */
+#define R_IA64_LTV32LSB		0x75	/* symbol + addend, data4 LSB */
+#define R_IA64_LTV64MSB		0x76	/* symbol + addend, data8 MSB */
+#define R_IA64_LTV64LSB		0x77	/* symbol + addend, data8 LSB */
+#define R_IA64_PCREL21BI	0x79	/* @pcrel(sym+add), ptb, call */
+#define R_IA64_PCREL22		0x7a	/* @pcrel(sym+add), imm22 */
+#define R_IA64_PCREL64I		0x7b	/* @pcrel(sym+add), imm64 */
+#define R_IA64_IPLTMSB		0x80	/* dynamic reloc, imported PLT, MSB */
+#define R_IA64_IPLTLSB		0x81	/* dynamic reloc, imported PLT, LSB */
+#define R_IA64_COPY		0x84	/* dynamic reloc, data copy */
+#define R_IA64_SUB		0x85	/* -symbol + addend, add imm22 */
+#define R_IA64_LTOFF22X		0x86	/* LTOFF22, relaxable.  */
+#define R_IA64_LDXMOV		0x87	/* Use of LTOFF22X.  */
+#define R_IA64_TPREL14		0x91	/* @tprel(sym+add), add imm14 */
+#define R_IA64_TPREL22		0x92	/* @tprel(sym+add), add imm22 */
+#define R_IA64_TPREL64I		0x93	/* @tprel(sym+add), add imm64 */
+#define R_IA64_TPREL64MSB	0x96	/* @tprel(sym+add), data8 MSB */
+#define R_IA64_TPREL64LSB	0x97	/* @tprel(sym+add), data8 LSB */
+#define R_IA64_LTOFF_TPREL22	0x9a	/* @ltoff(@tprel(s+a)), add imm22 */
+#define R_IA64_DTPMOD64MSB	0xa6	/* @dtpmod(sym+add), data8 MSB */
+#define R_IA64_DTPMOD64LSB	0xa7	/* @dtpmod(sym+add), data8 LSB */
+#define R_IA64_LTOFF_DTPMOD22	0xaa	/* @ltoff(@dtpmod(s+a)), imm22 */
+#define R_IA64_DTPREL14		0xb1	/* @dtprel(sym+add), imm14 */
+#define R_IA64_DTPREL22		0xb2	/* @dtprel(sym+add), imm22 */
+#define R_IA64_DTPREL64I	0xb3	/* @dtprel(sym+add), imm64 */
+#define R_IA64_DTPREL32MSB	0xb4	/* @dtprel(sym+add), data4 MSB */
+#define R_IA64_DTPREL32LSB	0xb5	/* @dtprel(sym+add), data4 LSB */
+#define R_IA64_DTPREL64MSB	0xb6	/* @dtprel(sym+add), data8 MSB */
+#define R_IA64_DTPREL64LSB	0xb7	/* @dtprel(sym+add), data8 LSB */
+#define R_IA64_LTOFF_DTPREL22	0xba	/* @ltoff(@dtprel(s+a)), imm22 */
+
+#define SHF_IA_64_SHORT		0x10000000	/* section near gp */
+
 #define R_MIPS_NONE		0
 #define R_MIPS_16		1
 #define R_MIPS_32		2
