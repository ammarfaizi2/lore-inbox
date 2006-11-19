Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756698AbWKSOdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbWKSOdM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756699AbWKSOdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:33:12 -0500
Received: from 1wt.eu ([62.212.114.60]:19205 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1756698AbWKSOdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:33:11 -0500
Date: Sun, 19 Nov 2006 15:33:01 +0100
From: Willy Tarreau <w@1wt.eu>
To: dbrownell@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix "&& 0x03" obvious typo in net1080
Message-ID: <20061119143301.GA2633@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I found this bug while grepping for "&& 0x" in drivers.
Care to forward upstream ?

Regards,
Willy

>From e9b19b98763726db99237ccfea907cf88d3572ac Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 19 Nov 2006 15:30:11 +0100
Subject: [PATCH] fix "&& 0x03" obvious typo in net1080

Another obvious occurrence of this typo.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/usb/net/net1080.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/net/net1080.c b/drivers/usb/net/net1080.c
index ce00de8..a774105 100644
--- a/drivers/usb/net/net1080.c
+++ b/drivers/usb/net/net1080.c
@@ -237,12 +237,12 @@ #define	STATUS_PORT_A		(1 << 15)
 #define	STATUS_CONN_OTHER	(1 << 14)
 #define	STATUS_SUSPEND_OTHER	(1 << 13)
 #define	STATUS_MAILBOX_OTHER	(1 << 12)
-#define	STATUS_PACKETS_OTHER(n)	(((n) >> 8) && 0x03)
+#define	STATUS_PACKETS_OTHER(n)	(((n) >> 8) & 0x03)
 
 #define	STATUS_CONN_THIS	(1 << 6)
 #define	STATUS_SUSPEND_THIS	(1 << 5)
 #define	STATUS_MAILBOX_THIS	(1 << 4)
-#define	STATUS_PACKETS_THIS(n)	(((n) >> 0) && 0x03)
+#define	STATUS_PACKETS_THIS(n)	(((n) >> 0) & 0x03)
 
 #define	STATUS_UNSPEC_MASK	0x0c8c
 #define	STATUS_NOISE_MASK 	((u16)~(0x0303|STATUS_UNSPEC_MASK))
-- 
1.4.2.4

