Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162779AbWLBEkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162779AbWLBEkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162786AbWLBEkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:40:05 -0500
Received: from mta16.mail.adelphia.net ([68.168.78.211]:7414 "EHLO
	mta16.adelphia.net") by vger.kernel.org with ESMTP id S1162779AbWLBEkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:40:03 -0500
Date: Fri, 1 Dec 2006 22:40:01 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Patrick Schoeller <Patrick.Schoeller@hp.com>
Subject: [PATCH 12/12] IPMI: increase KCS message size
Message-ID: <20061202044001.GH30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Increase the maximum message size a KCS interface supports to the
maximum message size the rest of the driver supports.  Some systems
really support messages this big.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Patrick Schoeller <Patrick.Schoeller@hp.com>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_kcs_sm.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_kcs_sm.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -93,8 +93,8 @@ enum kcs_states {
 				   state machine. */
 };
 
-#define MAX_KCS_READ_SIZE 80
-#define MAX_KCS_WRITE_SIZE 80
+#define MAX_KCS_READ_SIZE IPMI_MAX_MSG_LENGTH
+#define MAX_KCS_WRITE_SIZE IPMI_MAX_MSG_LENGTH
 
 /* Timeouts in microseconds. */
 #define IBF_RETRY_TIMEOUT 1000000
