Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVCCKuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVCCKuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVCCKrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:47:18 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:12212 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261553AbVCCKnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:43:11 -0500
Date: Thu, 3 Mar 2005 11:43:00 +0100
Message-Id: <200503031043.j23Ah0U4020772@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 13/16] [DocBook] kernel-docify comments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DocBook] kernel-docify comments
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2037  -> 1.2038 
#	      kernel/kfifo.c	1.2     -> 1.3    
#	include/linux/kfifo.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/03/02	tali@admingilde.org	1.2038
# [DocBook] kernel-docify comments
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/include/linux/kfifo.h b/include/linux/kfifo.h
--- a/include/linux/kfifo.h	Thu Mar  3 11:43:04 2005
+++ b/include/linux/kfifo.h	Thu Mar  3 11:43:04 2005
@@ -44,7 +44,7 @@
 extern unsigned int __kfifo_get(struct kfifo *fifo,
 				unsigned char *buffer, unsigned int len);
 
-/*
+/**
  * __kfifo_reset - removes the entire FIFO contents, no locking version
  * @fifo: the fifo to be emptied.
  */
@@ -53,7 +53,7 @@
 	fifo->in = fifo->out = 0;
 }
 
-/*
+/**
  * kfifo_reset - removes the entire FIFO contents
  * @fifo: the fifo to be emptied.
  */
@@ -68,7 +68,7 @@
 	spin_unlock_irqrestore(fifo->lock, flags);
 }
 
-/*
+/**
  * kfifo_put - puts some data into the FIFO
  * @fifo: the fifo to be used.
  * @buffer: the data to be added.
@@ -93,7 +93,7 @@
 	return ret;
 }
 
-/*
+/**
  * kfifo_get - gets some data from the FIFO
  * @fifo: the fifo to be used.
  * @buffer: where the data must be copied.
@@ -124,7 +124,7 @@
 	return ret;
 }
 
-/*
+/**
  * __kfifo_len - returns the number of bytes available in the FIFO, no locking version
  * @fifo: the fifo to be used.
  */
@@ -133,7 +133,7 @@
 	return fifo->in - fifo->out;
 }
 
-/*
+/**
  * kfifo_len - returns the number of bytes available in the FIFO
  * @fifo: the fifo to be used.
  */
diff -Nru a/kernel/kfifo.c b/kernel/kfifo.c
--- a/kernel/kfifo.c	Thu Mar  3 11:43:04 2005
+++ b/kernel/kfifo.c	Thu Mar  3 11:43:04 2005
@@ -25,7 +25,7 @@
 #include <linux/err.h>
 #include <linux/kfifo.h>
 
-/*
+/**
  * kfifo_init - allocates a new FIFO using a preallocated buffer
  * @buffer: the preallocated buffer to be used.
  * @size: the size of the internal buffer, this have to be a power of 2.
@@ -56,7 +56,7 @@
 }
 EXPORT_SYMBOL(kfifo_init);
 
-/*
+/**
  * kfifo_alloc - allocates a new FIFO and its internal buffer
  * @size: the size of the internal buffer to be allocated.
  * @gfp_mask: get_free_pages mask, passed to kmalloc()
@@ -91,7 +91,7 @@
 }
 EXPORT_SYMBOL(kfifo_alloc);
 
-/*
+/**
  * kfifo_free - frees the FIFO
  * @fifo: the fifo to be freed.
  */
@@ -102,7 +102,7 @@
 }
 EXPORT_SYMBOL(kfifo_free);
 
-/*
+/**
  * __kfifo_put - puts some data into the FIFO, no locking version
  * @fifo: the fifo to be used.
  * @buffer: the data to be added.
@@ -135,7 +135,7 @@
 }
 EXPORT_SYMBOL(__kfifo_put);
 
-/*
+/**
  * __kfifo_get - gets some data from the FIFO, no locking version
  * @fifo: the fifo to be used.
  * @buffer: where the data must be copied.
