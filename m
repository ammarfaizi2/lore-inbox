Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUCITEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUCITEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:04:08 -0500
Received: from palrel13.hp.com ([156.153.255.238]:57734 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262101AbUCITED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:04:03 -0500
Date: Tue, 9 Mar 2004 11:04:01 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (1/14) irda exports proc_irda
Message-ID: <20040309190401.GB14543@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir264_irsyms_01_proc.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(1/14) irda exports proc_irda

Move proc_irda out of irsyms.c into irproc.c



diff -u -p -r linux/net/irda.s0/irproc.c linux/net/irda/irproc.c
--- linux/net/irda.s0/irproc.c	Wed Dec 17 18:57:58 2003
+++ linux/net/irda/irproc.c	Mon Mar  8 18:47:07 2004
@@ -45,6 +45,7 @@ struct irda_entry {
 };
 
 struct proc_dir_entry *proc_irda;
+EXPORT_SYMBOL(proc_irda);
  
 static struct irda_entry irda_dirs[] = {
 	{"discovery",	&discovery_seq_fops},
diff -u -p -r linux/net/irda.s0/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s0/irsyms.c	Wed Mar  3 17:02:55 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 18:47:07 2004
@@ -84,9 +84,6 @@ EXPORT_SYMBOL(irttp_dup);
 EXPORT_SYMBOL(irda_debug);
 #endif
 EXPORT_SYMBOL(irda_notify_init);
-#ifdef CONFIG_PROC_FS
-EXPORT_SYMBOL(proc_irda);
-#endif
 EXPORT_SYMBOL(irda_param_insert);
 EXPORT_SYMBOL(irda_param_extract);
 EXPORT_SYMBOL(irda_param_extract_all);
