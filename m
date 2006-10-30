Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965368AbWJ3UEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965368AbWJ3UEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWJ3UEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:04:32 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:28687 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S932479AbWJ3UEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:04:31 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] usb 'print_schedule_frame' defined but not used warning fix
Date: Mon, 30 Oct 2006 21:04:08 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302104.09370.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This is a simple fix for this warning:

drivers/usb/host/ehci-sched.c:270: warning: 'print_schedule_frame' defined but 
not used

The print_budget_frame() is not used anywhere in the kernel tree and serves 
debugging purposes only. This patch is against 2.6.19-rc3-mm1.

Regards,

	Mariusz Kozlowski

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
---

--- linux-2.6.19-rc3-orig/drivers/usb/host/ehci-sched.c 2006-10-30 
20:20:30.000000000 +0100
+++ linux-2.6.19-rc3/drivers/usb/host/ehci-sched.c      2006-10-30 
20:39:08.000000000 +0100
@@ -206,6 +206,7 @@ periodic_next_shadow (union ehci_shadow 
 /* the following are merely frame-structure dumpers to aid in
    debugging.  Be careful of their use; they will introduce extreme
    latencies in what is [essentially] realtime code. */
+#if 0
 static void print_budget_frame (struct ehci_hcd *ehci, int frame,
                                struct ehci_shadow_budget *insert,
                                void *owner)
@@ -255,6 +256,7 @@ static void print_budget_frame (struct e
        }
        printk("\n");
 }
+#endif
 
 static void print_budget (struct ehci_hcd *ehci,
                          struct ehci_shadow_budget *insert,
