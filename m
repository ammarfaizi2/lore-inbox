Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTEVGSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTEVGRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:17:41 -0400
Received: from dp.samba.org ([66.70.73.150]:13216 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262520AbTEVGRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:17:32 -0400
Date: Thu, 22 May 2003 16:29:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Squash warning in ppc64 xics.c
Message-ID: <20030522062916.GF14009@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton, please apply.  xics.c uses ppc64_boot_msg() without prototype,
this fixes it by inclding <asm/machdep.h>.

diff -urN for-linus-ppc64/arch/ppc64/kernel/xics.c linux-congo/arch/ppc64/kernel/xics.c
--- for-linus-ppc64/arch/ppc64/kernel/xics.c	2003-05-07 15:10:18.000000000 +1000
+++ linux-congo/arch/ppc64/kernel/xics.c	2003-05-22 15:55:45.000000000 +1000
@@ -25,6 +25,7 @@
 #include <asm/xics.h>
 #include <asm/ppcdebug.h>
 #include <asm/hvcall.h>
+#include <asm/machdep.h>
 
 #include "i8259.h"
 
-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
