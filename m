Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTEVGRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTEVGRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:17:35 -0400
Received: from dp.samba.org ([66.70.73.150]:12960 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262499AbTEVGRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:17:32 -0400
Date: Thu, 22 May 2003 16:27:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Implicit declaration in ppc64 signal32.c
Message-ID: <20030522062723.GE14009@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton, please apply.  do_signal32() is used before it is defined, this
prototype squashes the warning.

diff -urN for-linus-ppc64/arch/ppc64/kernel/signal32.c linux-congo/arch/ppc64/kernel/signal32.c
--- for-linus-ppc64/arch/ppc64/kernel/signal32.c	2003-05-07 15:10:18.000000000 +1000
+++ linux-congo/arch/ppc64/kernel/signal32.c	2003-05-22 15:54:55.000000000 +1000
@@ -97,7 +97,7 @@
 	struct ucontext32 uc;
 };
 
-
+int do_signal32(sigset_t *oldset, struct pt_regs *regs);
 
 /*
  *  Start of nonRT signal support

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
