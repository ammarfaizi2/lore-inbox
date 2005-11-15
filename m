Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVKOUYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVKOUYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVKOUYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:24:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:42735 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S965015AbVKOUYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:24:42 -0500
Subject: [RFC] ARM PF_IRQSOFF and PSR_Q_BIT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, tglx@linutronics.de
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 15 Nov 2005 12:24:40 -0800
Message-Id: <1132086280.32066.8.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	In my ARM config PF_IRQSOFF and PSR_Q_BIT are equal. So you end up with
a __RAW_LOCAL_ILLEGAL_MASK that is identical to the PF_IRQSOFF flag. I
get some weird errors in this config, but with PSR_T_BIT everything is
fine .. Any thoughts?

Daniel

Index: linux-2.6.14.2/include/asm-arm/system.h
===================================================================
--- linux-2.6.14.2.orig/include/asm-arm/system.h
+++ linux-2.6.14.2/include/asm-arm/system.h
@@ -308,7 +308,7 @@ do {									\
  * bit when thumb mode is disabled. The PSR_s and PSR_x bits are for
  * future extensions and definitely unreliable.
  */
-#define __RAW_LOCAL_ILLEGAL_MASK      PSR_Q_BIT
+#define __RAW_LOCAL_ILLEGAL_MASK      PSR_T_BIT
 
 #include <linux/rt_irq.h>
 


