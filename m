Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319037AbSIJAQe>; Mon, 9 Sep 2002 20:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319038AbSIJAQe>; Mon, 9 Sep 2002 20:16:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:13524 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319037AbSIJAQd>;
	Mon, 9 Sep 2002 20:16:33 -0400
Date: Mon, 9 Sep 2002 17:21:11 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: 2.5.34 - EXPORT_SYMBOL(reparent_to_init) for module build
Message-ID: <20020909172111.A19949@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.34, in order to build a module that calls daemonize(), I had to 
export reparent_to_init:

--- 1.45/kernel/ksyms.c	Mon Sep  9 03:35:51 2002
+++ edited/kernel/ksyms.c	Mon Sep  9 16:52:29 2002
@@ -521,6 +521,7 @@
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
 EXPORT_SYMBOL(daemonize);
+EXPORT_SYMBOL(reparent_to_init);
 EXPORT_SYMBOL(csum_partial); /* for networking and md */
 EXPORT_SYMBOL(seq_escape);
 EXPORT_SYMBOL(seq_printf);

-- Patrick Mansfield
