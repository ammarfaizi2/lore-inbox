Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWFSUUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWFSUUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWFSUUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:20:04 -0400
Received: from xenotime.net ([66.160.160.81]:38851 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750763AbWFSUUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:20:02 -0400
Date: Mon, 19 Jun 2006 13:00:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tglx@linutronix.de
Subject: [PATCH] reed-solomon: fix kernel-doc comments
Message-Id: <20060619130020.05561cb4.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc formatting in Reed-Solomon code.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 lib/reed_solomon/reed_solomon.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

--- linux-2617-pv.orig/lib/reed_solomon/reed_solomon.c
+++ linux-2617-pv/lib/reed_solomon/reed_solomon.c
@@ -54,7 +54,6 @@ static DEFINE_MUTEX(rslistlock);
 
 /**
  * rs_init - Initialize a Reed-Solomon codec
- *
  * @symsize:	symbol size, bits (1-8)
  * @gfpoly:	Field generator polynomial coefficients
  * @fcr:	first root of RS code generator polynomial, index form
@@ -62,7 +61,7 @@ static DEFINE_MUTEX(rslistlock);
  * @nroots:	RS code generator polynomial degree (number of roots)
  *
  * Allocate a control structure and the polynom arrays for faster
- * en/decoding. Fill the arrays according to the given parameters
+ * en/decoding. Fill the arrays according to the given parameters.
  */
 static struct rs_control *rs_init(int symsize, int gfpoly, int fcr,
 				   int prim, int nroots)
@@ -155,8 +154,7 @@ errrs:
 
 
 /**
- *  free_rs - Free the rs control structure, if its not longer used
- *
+ *  free_rs - Free the rs control structure, if it is no longer used
  *  @rs:	the control structure which is not longer used by the
  *		caller
  */
@@ -176,7 +174,6 @@ void free_rs(struct rs_control *rs)
 
 /**
  * init_rs - Find a matching or allocate a new rs control structure
- *
  *  @symsize:	the symbol size (number of bits)
  *  @gfpoly:	the extended Galois field generator polynomial coefficients,
  *		with the 0th coefficient in the low order bit. The polynomial
@@ -236,7 +233,6 @@ out:
 #ifdef CONFIG_REED_SOLOMON_ENC8
 /**
  *  encode_rs8 - Calculate the parity for data values (8bit data width)
- *
  *  @rs:	the rs control structure
  *  @data:	data field of a given type
  *  @len:	data length
@@ -258,7 +254,6 @@ EXPORT_SYMBOL_GPL(encode_rs8);
 #ifdef CONFIG_REED_SOLOMON_DEC8
 /**
  *  decode_rs8 - Decode codeword (8bit data width)
- *
  *  @rs:	the rs control structure
  *  @data:	data field of a given type
  *  @par:	received parity data field
@@ -285,7 +280,6 @@ EXPORT_SYMBOL_GPL(decode_rs8);
 #ifdef CONFIG_REED_SOLOMON_ENC16
 /**
  *  encode_rs16 - Calculate the parity for data values (16bit data width)
- *
  *  @rs:	the rs control structure
  *  @data:	data field of a given type
  *  @len:	data length
@@ -305,7 +299,6 @@ EXPORT_SYMBOL_GPL(encode_rs16);
 #ifdef CONFIG_REED_SOLOMON_DEC16
 /**
  *  decode_rs16 - Decode codeword (16bit data width)
- *
  *  @rs:	the rs control structure
  *  @data:	data field of a given type
  *  @par:	received parity data field


---
