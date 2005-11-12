Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVKLOod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVKLOod (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVKLOod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:44:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:61678 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932388AbVKLOod
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:44:33 -0500
Date: Sat, 12 Nov 2005 06:44:16 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
cc: tglx@linutronix.de, trini@kernel.crashing.org, sdietrich@mvista.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] rt11 Fill out default_simple_type
Message-ID: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Needed to boot some ARM boards.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.14/kernel/irq/handle.c
===================================================================
--- linux-2.6.14.orig/kernel/irq/handle.c
+++ linux-2.6.14/kernel/irq/handle.c
@@ -196,8 +196,9 @@ struct irq_type default_level_type = {
   */
  struct irq_type default_simple_type = {
  	.typename	= "default_simple",
-	.enable		= noop,
-	.disable	= noop,
+	.enable		= default_enable,
+	.disable	= default_disable,
+	.set_type       = default_set_type,
  	.handle_irq	= handle_simple_irq,
  };

