Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWAWPOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWAWPOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWAWPOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:14:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:60893 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751465AbWAWPOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:14:07 -0500
Date: Mon, 23 Jan 2006 10:14:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Export new notifier chain routines as GPL
In-Reply-To: <1137833163.2978.5.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.44L0.0601231010090.5418-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan asked to have the notifier-chain API routines exported with 
EXPORT_SYMBOL_GPL, as they are new parts of the Linux infrastructure.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Obviously this patch is meant to apply on top of the 8-part patch set 
adding the new notifier-chain API.

Alan Stern


Index: l2616/kernel/sys.c
===================================================================
--- l2616.orig/kernel/sys.c
+++ l2616/kernel/sys.c
@@ -171,7 +171,7 @@ int atomic_notifier_chain_register(struc
 	return ret;
 }
 
-EXPORT_SYMBOL(atomic_notifier_chain_register);
+EXPORT_SYMBOL_GPL(atomic_notifier_chain_register);
 
 /**
  *	atomic_notifier_chain_unregister - Remove notifier from an atomic notifier chain
@@ -195,7 +195,7 @@ int atomic_notifier_chain_unregister(str
 	return ret;
 }
 
-EXPORT_SYMBOL(atomic_notifier_chain_unregister);
+EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
 /**
  *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
@@ -226,7 +226,7 @@ int atomic_notifier_call_chain(struct at
 	return ret;
 }
 
-EXPORT_SYMBOL(atomic_notifier_call_chain);
+EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
 
 /*
  *	Blocking notifier chain routines.  All access to the chain is
@@ -255,7 +255,7 @@ int blocking_notifier_chain_register(str
 	return ret;
 }
 
-EXPORT_SYMBOL(blocking_notifier_chain_register);
+EXPORT_SYMBOL_GPL(blocking_notifier_chain_register);
 
 /**
  *	blocking_notifier_chain_unregister - Remove notifier from a blocking notifier chain
@@ -278,7 +278,7 @@ int blocking_notifier_chain_unregister(s
 	return ret;
 }
 
-EXPORT_SYMBOL(blocking_notifier_chain_unregister);
+EXPORT_SYMBOL_GPL(blocking_notifier_chain_unregister);
 
 /**
  *	blocking_notifier_call_chain - Call functions in a blocking notifier chain
@@ -308,7 +308,7 @@ int blocking_notifier_call_chain(struct 
 	return ret;
 }
 
-EXPORT_SYMBOL(blocking_notifier_call_chain);
+EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
 
 /*
  *	Raw notifier chain routines.  There is no protection;
@@ -332,7 +332,7 @@ int raw_notifier_chain_register(struct r
 	return notifier_chain_register(&nh->head, n);
 }
 
-EXPORT_SYMBOL(raw_notifier_chain_register);
+EXPORT_SYMBOL_GPL(raw_notifier_chain_register);
 
 /**
  *	raw_notifier_chain_unregister - Remove notifier from a raw notifier chain
@@ -350,7 +350,7 @@ int raw_notifier_chain_unregister(struct
 	return notifier_chain_unregister(&nh->head, n);
 }
 
-EXPORT_SYMBOL(raw_notifier_chain_unregister);
+EXPORT_SYMBOL_GPL(raw_notifier_chain_unregister);
 
 /**
  *	raw_notifier_call_chain - Call functions in a raw notifier chain
@@ -376,7 +376,7 @@ int raw_notifier_call_chain(struct raw_n
 	return notifier_call_chain(&nh->head, val, v);
 }
 
-EXPORT_SYMBOL(raw_notifier_call_chain);
+EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
 
 /**
  *	register_reboot_notifier - Register function to be called at reboot time


