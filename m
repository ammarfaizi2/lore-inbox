Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTFJMpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 08:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTFJMpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 08:45:19 -0400
Received: from 13.telemaxx.net ([213.144.13.149]:28821 "EHLO
	gatekeeper.syskonnect.de") by vger.kernel.org with ESMTP
	id S262577AbTFJMpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 08:45:16 -0400
From: "Ralph Roesler" <rroesler@syskonnect.de>
Organization: syskonnect.de
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Jul 2003 14:53:14 +0200
MIME-Version: 1.0
Subject: [PATCH] 2.5 kernel_stat access in KLM
Message-ID: <3F0ECF5A.1101.1C6D477A@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *,

I need to access system, nice and idle-time of the system from a 
KLM. But due to the 
fact, that this structure is not exported any longer towards any KLM, 
those values are 
unusable.

Was there a particular reason not to offer the kernel_stat-structure 
any longer to 
KLM's? I've made a small patch and the KLM can access the 
information needed:
Is it possible to add this patch to the kernel? Thanks!

Kind regards,
-Ralph.


--- linux-2.5.70/kernel/ksyms.c	2003-05-27 03:00:20.000000000 
+0200
+++ kstat-linux-2.5.70/kernel/ksyms.c	2003-06-10 
14:04:10.000000000 +0200
@@ -491,6 +491,7 @@
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);  
 #endif
 +EXPORT_SYMBOL(kstat__per_cpu);


 /* misc */
