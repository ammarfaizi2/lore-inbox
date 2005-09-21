Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVIUXiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVIUXiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 19:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVIUXiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 19:38:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39667 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751347AbVIUXiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 19:38:15 -0400
Subject: [PATCH] RT: Remove HARDIRQ_BITS dependency
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 21 Sep 2005 16:38:12 -0700
Message-Id: <1127345892.19506.45.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Moves HARDIRQ_BITS so it's doesn't block anything else
from getting defined.

Signed-off-by: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/include/linux/hardirq.h
===================================================================
--- linux-2.6.13.orig/include/linux/hardirq.h
+++ linux-2.6.13/include/linux/hardirq.h
@@ -28,10 +28,10 @@
  */
 #define PREEMPT_BITS		8
 #define SOFTIRQ_BITS		8
-#ifndef HARDIRQ_BITS
-#define HARDIRQ_BITS		12
 #define PREEMPT_ACTIVE_BITS	1
 #define IRQSOFF_BITS		1
+#ifndef HARDIRQ_BITS
+#define HARDIRQ_BITS		12
 
 /*
  * The hardirq mask has to be large enough to have space for potentially


