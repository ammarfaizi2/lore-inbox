Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUHaIPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUHaIPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUHaIPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:15:12 -0400
Received: from holomorphy.com ([207.189.100.168]:9147 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267375AbUHaIPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:15:03 -0400
Date: Tue, 31 Aug 2004 01:14:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eric Valette <eric.valette@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm2 : compilation error in kernel/wait.c
Message-ID: <20040831081456.GL5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Eric Valette <eric.valette@free.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41343136.6080208@free.fr> <20040831080916.GK5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831080916.GK5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 01:09:16AM -0700, William Lee Irwin III wrote:
> I very distinctly recall compiling and booting these...

Index: mm2-2.6.9-rc1/kernel/wait.c
===================================================================
--- mm2-2.6.9-rc1.orig/kernel/wait.c	2004-08-31 01:06:56.826462592 -0700
+++ mm2-2.6.9-rc1/kernel/wait.c	2004-08-31 01:10:49.805044464 -0700
@@ -150,8 +150,8 @@
  * waiting, the actions of __wait_on_bit() and __wait_on_bit_lock() are
  * permitted return codes. Nonzero return codes halt waiting and return.
  */
-int __sched __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			void *word,
+int __sched fastcall __wait_on_bit(wait_queue_head_t *wq,
+			struct wait_bit_queue *q, void *word,
 			int bit, int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
@@ -164,8 +164,8 @@
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
-int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			void *word, int bit,
+int __sched fastcall __wait_on_bit_lock(wait_queue_head_t *wq,
+			struct wait_bit_queue *q, void *word, int bit,
 			int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
