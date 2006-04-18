Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWDROZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWDROZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWDROZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:25:37 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:30477 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932179AbWDROZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:25:36 -0400
Date: Tue, 18 Apr 2006 07:25:29 -0700
Message-Id: <200604181425.k3IEPTAC027793@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] Remove double history 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Assuming you don't want it in there twice .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/kernel/rt.c
===================================================================
--- linux-2.6.16.orig/kernel/rt.c
+++ linux-2.6.16/kernel/rt.c
@@ -19,17 +19,6 @@
  * This code is a from-scratch implementation and is not based on pmutexes,
  * but the idea of converting spinlocks to mutexes is used here too.
  *
- * historic credit for proving that Linux spinlocks can be implemented via
- * RT-aware mutexes goes to many people: The Pmutex project (Dirk Grambow
- * and others) who prototyped it on 2.4 and did lots of comparative
- * research and analysis; TimeSys, for proving that you can implement a
- * fully preemptible kernel via the use of IRQ threading and mutexes;
- * Bill Huey for persuasively arguing on lkml that the mutex model is the
- * right one; and to MontaVista, who ported pmutexes to 2.6.
- *
- * This code is a from-scratch implementation and is not based on pmutexes,
- * but the idea of converting spinlocks to mutexes is used here too.
- *
  * lock debugging, locking tree, deadlock detection:
  *
  *  Copyright (C) 2004, LynuxWorks, Inc., Igor Manyilov, Bill Huey
