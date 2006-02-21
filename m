Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWBUQJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWBUQJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbWBUQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:09:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50878 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932301AbWBUQJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:09:48 -0500
Date: Tue, 21 Feb 2006 11:09:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Export new notifier chain routines as GPL
Message-ID: <Pine.LNX.4.44L0.0602211107370.5374-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan asked to have the notifier-chain API routines exported with 
EXPORT_SYMBOL_GPL, as they are new parts of the Linux infrastructure.
This patch (as642) carries out his wish.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

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

