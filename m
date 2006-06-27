Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWF0Lwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWF0Lwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWF0Lwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:52:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:21214 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932231AbWF0Lwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:52:54 -0400
Subject: [RFC][PATCH 1/3] Process events biarch bug: Name process event
	data union type and annotate for compatibility.
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060627112644.804066367@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 04:47:47 -0700
Message-Id: <1151408867.21787.1809.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an explicit type to the process events union structure so the
type may be reused. 

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 include/linux/cn_proc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-mm3-biarch/include/linux/cn_proc.h
===================================================================
--- linux-2.6.17-mm3-biarch.orig/include/linux/cn_proc.h
+++ linux-2.6.17-mm3-biarch/include/linux/cn_proc.h
@@ -56,11 +56,11 @@ struct proc_event {
 		/* "last" is the last process event: exit */
 		PROC_EVENT_EXIT = 0x80000000
 	} what;
 	__u32 cpu;
 	struct timespec timestamp;
-	union { /* must be last field of proc_event struct */
+	union process_event_data { /* must be last field of proc_event struct */
 		struct {
 			__u32 err;
 		} ack;
 
 		struct fork_proc_event {

--

