Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946072AbWGPBXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946072AbWGPBXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946073AbWGPBXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:23:46 -0400
Received: from tim.nimlabs.org ([69.25.196.37]:59797 "EHLO tim.nimlabs.org")
	by vger.kernel.org with ESMTP id S1946072AbWGPBXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:23:45 -0400
Date: Sat, 15 Jul 2006 21:23:44 -0400
From: Nick Martin <nim@nimlabs.org>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] spaceball: increment SPACEBALL_MAX_ID for 4000FLX Lefty
Message-ID: <20060716012344.GO17043@nimlabs.org>
Mail-Followup-To: dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Martin <nim+linux@nimlabs.org>

Although the Spaceball 4000FLX Lefty is already supported by the
spaceball driver, it does not register properly due to SPACEBALL_MAX_ID
being set too low. This patch increments SPACEBALL_MAX_ID such that the
4000FLX Lefty is properly recognized. No changes are needed in the
actual code, this merely allows the existing code to be run for this
device.

This patch has been tested with an actual Spaceball 4000FLX Lefty on
kernel version 2.6.17.6.

Signed-off-by: Nick Martin <nim+linux@nimlabs.org>

---

Thanks,
-- Nick Martin
http://www.nimlabs.org/~nim

--- linux-2.6.17.6/drivers/input/joystick/spaceball.c.orig	2006-07-15 12:00:43.000000000 -0700
+++ linux-2.6.17.6/drivers/input/joystick/spaceball.c	2006-07-15 18:18:14.971790750 -0700
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
  */
 
 #define SPACEBALL_MAX_LENGTH	128
-#define SPACEBALL_MAX_ID	8
+#define SPACEBALL_MAX_ID	9
 
 #define SPACEBALL_1003      1
 #define SPACEBALL_2003B     3
