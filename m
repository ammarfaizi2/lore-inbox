Return-Path: <linux-kernel-owner+w=401wt.eu-S1751912AbXAVE16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbXAVE16 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 23:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbXAVE16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 23:27:58 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:47128 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbXAVE15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 23:27:57 -0500
Date: Sun, 21 Jan 2007 20:22:18 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rpjday@mindspring.com, akpm <akpm@osdl.org>
Subject: [PATCH] fix various kernel-doc in header files
Message-Id: <20070121202218.6d1f414d.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert P. J. Day <rpjday@mindspring.com>

  Fix a number of kernel-doc entries for header files in
include/linux by making sure they begin with the appropriate '/**'
notation and use @var notation.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---

 include/linux/bitops.h  |    6 ++----
 include/linux/list.h    |   10 +++++-----
 include/linux/mutex.h   |    2 +-
 include/linux/rtmutex.h |    4 ++--
 include/linux/timer.h   |    4 ++--
 5 files changed, 12 insertions(+), 14 deletions(-)

--- linux-2620-rc4.orig/include/linux/bitops.h
+++ linux-2620-rc4/include/linux/bitops.h
@@ -31,9 +31,8 @@ static inline unsigned long hweight_long
 	return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
 }
 
-/*
+/**
  * rol32 - rotate a 32-bit value left
- *
  * @word: value to rotate
  * @shift: bits to roll
  */
@@ -42,9 +41,8 @@ static inline __u32 rol32(__u32 word, un
 	return (word << shift) | (word >> (32 - shift));
 }
 
-/*
+/**
  * ror32 - rotate a 32-bit value right
- *
  * @word: value to rotate
  * @shift: bits to roll
  */
--- linux-2620-rc4.orig/include/linux/list.h
+++ linux-2620-rc4/include/linux/list.h
@@ -227,13 +227,13 @@ static inline void list_replace_init(str
 	INIT_LIST_HEAD(old);
 }
 
-/*
+/**
  * list_replace_rcu - replace old entry by new one
  * @old : the element to be replaced
  * @new : the new element to insert
  *
- * The old entry will be replaced with the new entry atomically.
- * Note: 'old' should not be empty.
+ * The @old entry will be replaced with the @new entry atomically.
+ * Note: @old should not be empty.
  */
 static inline void list_replace_rcu(struct list_head *old,
 				struct list_head *new)
@@ -680,12 +680,12 @@ static inline void hlist_del_init(struct
 	}
 }
 
-/*
+/**
  * hlist_replace_rcu - replace old entry by new one
  * @old : the element to be replaced
  * @new : the new element to insert
  *
- * The old entry will be replaced with the new entry atomically.
+ * The @old entry will be replaced with the @new entry atomically.
  */
 static inline void hlist_replace_rcu(struct hlist_node *old,
 					struct hlist_node *new)
--- linux-2620-rc4.orig/include/linux/mutex.h
+++ linux-2620-rc4/include/linux/mutex.h
@@ -105,7 +105,7 @@ do {							\
 extern void __mutex_init(struct mutex *lock, const char *name,
 			 struct lock_class_key *key);
 
-/***
+/**
  * mutex_is_locked - is the mutex locked
  * @lock: the mutex to be queried
  *
--- linux-2620-rc4.orig/include/linux/rtmutex.h
+++ linux-2620-rc4/include/linux/rtmutex.h
@@ -16,7 +16,7 @@
 #include <linux/plist.h>
 #include <linux/spinlock_types.h>
 
-/*
+/**
  * The rt_mutex structure
  *
  * @wait_lock:	spinlock to protect the structure
@@ -71,7 +71,7 @@ struct hrtimer_sleeper;
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
 
-/***
+/**
  * rt_mutex_is_locked - is the mutex locked
  * @lock: the mutex to be queried
  *
--- linux-2620-rc4.orig/include/linux/timer.h
+++ linux-2620-rc4/include/linux/timer.h
@@ -41,7 +41,7 @@ static inline void setup_timer(struct ti
 	init_timer(timer);
 }
 
-/***
+/**
  * timer_pending - is a timer pending?
  * @timer: the timer in question
  *
@@ -63,7 +63,7 @@ extern int mod_timer(struct timer_list *
 
 extern unsigned long next_timer_interrupt(void);
 
-/***
+/**


---
