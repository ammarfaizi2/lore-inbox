Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbTIXD32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTIXD32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:29:28 -0400
Received: from dp.samba.org ([66.70.73.150]:64203 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261470AbTIXD3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:29:23 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] irq_affinity_write_proc no longer writes garbage into irq_affinity[]
Date: Wed, 24 Sep 2003 12:51:21 +1000
Message-Id: <20030924032923.104502C267@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  <adobriyan@mail.ru>


--- trivial-2.6.0-test5-bk10/arch/i386/kernel/irq.c.orig	2003-09-24 12:27:14.000000000 +1000
+++ trivial-2.6.0-test5-bk10/arch/i386/kernel/irq.c	2003-09-24 12:27:14.000000000 +1000
@@ -965,6 +965,8 @@
 		return -EIO;
 
 	err = parse_hex_value(buffer, count, &new_value);
+	if(err)
+		return err;
 
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= <adobriyan@mail.ru>: [PATCH] irq_affinity_write_proc no longer writes garbage into irq_affinity[]
