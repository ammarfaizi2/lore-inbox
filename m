Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422626AbWJ3URP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422626AbWJ3URP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422630AbWJ3URP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:17:15 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:51212 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1422626AbWJ3URO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:17:14 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb 'print_schedule_frame' defined but not used warning fix
Date: Mon, 30 Oct 2006 21:16:49 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>
References: <200610302104.09370.m.kozlowski@tuxland.pl>
In-Reply-To: <200610302104.09370.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302116.51714.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> 	This is a simple fix for this warning:
>
> drivers/usb/host/ehci-sched.c:270: warning: 'print_schedule_frame' defined
> but not used
>
> The print_budget_frame() is not used anywhere in the kernel tree and serves
> debugging purposes only. This patch is against 2.6.19-rc3-mm1.

Ofcourse I ment print_schedule_frame(). Please ignore previous patch. Sorry.

Regards,

	Mariusz Kozlowski

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
---

--- linux-2.6.19-rc3-orig/drivers/usb/host/ehci-sched.c 2006-10-30 
21:13:42.000000000 +0100
+++ linux-2.6.19-rc3/drivers/usb/host/ehci-sched.c      2006-10-30 
21:14:49.000000000 +0100
@@ -265,6 +265,7 @@ static void print_budget (struct ehci_hc
                print_budget_frame(ehci,i,insert,owner);
 }
 
+#if 0
 static void print_schedule_frame (char *pre,struct ehci_hcd *ehci, int frame,
                                  void *insert)
 {
@@ -333,6 +334,7 @@ static void print_schedule_frame (char *
        }
        printk("\n");
 }
+#endif
 
 /* find position of a specific entry in the periodic schedule (ie,
  * returns pointers such that we can update the predecessor's
