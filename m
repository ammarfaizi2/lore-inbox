Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWETEGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWETEGX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWETEGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:06:23 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:13454 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964838AbWETEGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:06:22 -0400
Date: Fri, 19 May 2006 21:06:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH (take #2)] EDD isn't EXPERIMENTAL anymore
Message-ID: <20060520040620.GA11109@taniwha.stupidest.org>
References: <20060520025255.GB9486@taniwha.stupidest.org> <20060520035310.GA28977@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520035310.GA28977@humbolt.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops.

Resend with Kconfig comment change too.  It also occured to me that
!IA64 is a lousy check, EDD is really i386 and x86_64 only, it's
clearly not useful for ppc, alpha, etc.

Would anyone object to a chance for that too?

---

Lots of people use this.  Apparently RH has for over 18 months so lets
drop EXPERIMENTAL.


Signed-off-by: Chris Wedgwood <cw@f00f.org>

Index: linux-2.6/drivers/firmware/Kconfig
===================================================================
--- linux-2.6.orig/drivers/firmware/Kconfig	2006-05-19 19:54:23.152351261 -0700
+++ linux-2.6/drivers/firmware/Kconfig	2006-05-19 21:03:56.515687951 -0700
@@ -6,8 +6,7 @@
 menu "Firmware Drivers"
 
 config EDD
-	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	tristate "BIOS Enhanced Disk Drive calls determine boot disk"
 	depends on !IA64
 	help
 	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
