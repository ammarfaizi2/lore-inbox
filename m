Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTEVGSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTEVGRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:17:38 -0400
Received: from dp.samba.org ([66.70.73.150]:12704 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262513AbTEVGRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:17:32 -0400
Date: Thu, 22 May 2003 16:26:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Squash implicit declaration warning in ppc64 align.c
Message-ID: <20030522062603.GD14009@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton, please apply.

diff -urN for-linus-ppc64/arch/ppc64/kernel/align.c linux-congo/arch/ppc64/kernel/align.c
--- for-linus-ppc64/arch/ppc64/kernel/align.c	2003-05-07 15:10:18.000000000 +1000
+++ linux-congo/arch/ppc64/kernel/align.c	2003-05-22 15:50:22.000000000 +1000
@@ -21,6 +21,8 @@
 #include <asm/system.h>
 #include <asm/cache.h>
 
+void disable_kernel_fp(void); /* asm function from head.S */
+
 struct aligninfo {
 	unsigned char len;
 	unsigned char flags;


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
