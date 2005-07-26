Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVGZUPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVGZUPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVGZUPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:15:21 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:22540 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262038AbVGZUPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:15:09 -0400
Message-Id: <200507262004.j6QK483G010074@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Dominik Hackl <dominik@hackl.dhs.org>
Subject: [PATCH 3/4] UML - Update module interface
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jul 2005 16:04:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Hackl <dominik@hackl.dhs.org>

This patch replaces the deprecated MODULE_PARM function by the new 
module_param function.

Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/drivers/hostaudio_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/hostaudio_kern.c	2005-07-19 12:03:09.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/hostaudio_kern.c	2005-07-19 12:09:04.000000000 -0400
@@ -57,10 +57,10 @@
 
 #else /*MODULE*/
 
-MODULE_PARM(dsp, "s");
+module_param(dsp, charp, 0644);
 MODULE_PARM_DESC(dsp, DSP_HELP);
 
-MODULE_PARM(mixer, "s");
+module_param(mixer, charp, 0644);
 MODULE_PARM_DESC(mixer, MIXER_HELP);
 
 #endif

