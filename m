Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVIBUA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVIBUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVIBUA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:00:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39930 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751088AbVIBUA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:00:57 -0400
Subject: [PATCH] RT: set LPPTEST default to off
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 02 Sep 2005 13:00:49 -0700
Message-Id: <1125691250.2709.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set the default to off for the LPP test. Since it's not usually going
to be used.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/drivers/char/Kconfig
===================================================================
--- linux-2.6.13.orig/drivers/char/Kconfig	2005-09-01 21:25:52.000000000 +0000
+++ linux-2.6.13/drivers/char/Kconfig	2005-09-02 16:06:59.000000000 +0000
@@ -730,7 +730,7 @@ config BLOCKER
 config LPPTEST
 	tristate "Parallel Port Based Latency Measurement Device"
 	depends on !PARPORT
-	default y
+	default n 
 	---help---
 	  If you say Y here then a device will be created that the userspace
 	  testlpp utility uses to measure IRQ latencies of a target system



