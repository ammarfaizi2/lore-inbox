Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTEVGSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbTEVGRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:17:44 -0400
Received: from dp.samba.org ([66.70.73.150]:13472 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262524AbTEVGRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:17:32 -0400
Date: Thu, 22 May 2003 16:30:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Unused variables in ppc64 prom.c
Message-ID: <20030522063041.GG14009@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton, please apply.  This removes a bunch of unused variables in
prom_init(), squashing the associated warnings.

diff -urN for-linus-ppc64/arch/ppc64/kernel/prom.c linux-congo/arch/ppc64/kernel/prom.c
--- for-linus-ppc64/arch/ppc64/kernel/prom.c	2003-05-07 15:10:18.000000000 +1000
+++ linux-congo/arch/ppc64/kernel/prom.c	2003-05-22 15:56:45.000000000 +1000
@@ -1060,12 +1060,11 @@
 prom_init(unsigned long r3, unsigned long r4, unsigned long pp,
 	  unsigned long r6, unsigned long r7)
 {
-	int chrp = 0;
 	unsigned long mem;
-	ihandle prom_mmu, prom_op, prom_root, prom_cpu;
+	ihandle prom_root, prom_cpu;
 	phandle cpu_pkg;
 	unsigned long offset = reloc_offset();
-	long l, sz;
+	long l;
 	char *p, *d;
  	unsigned long phys;
         u32 getprop_rval;


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
