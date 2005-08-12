Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVHLSqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVHLSqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVHLSqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:46:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:35210 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750928AbVHLSql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:46:41 -0400
Date: Fri, 12 Aug 2005 11:46:22 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru
Subject: w1: more debug level decrease.
Message-ID: <20050812184622.GA19999@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch for 2.6.13-rc6 to keep people's syslogs a bit nicer.

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

Do not spam syslog each 10 seconds when there is nothing on the wire.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/w1/w1.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/w1/w1.c	2005-08-02 13:41:30.000000000 -0700
+++ gregkh-2.6/drivers/w1/w1.c	2005-08-12 11:42:04.000000000 -0700
@@ -593,7 +593,7 @@
 		 * Return 0 - device(s) present, 1 - no devices present.
 		 */
 		if (w1_reset_bus(dev)) {
-			dev_info(&dev->dev, "No devices present on the wire.\n");
+			dev_dbg(&dev->dev, "No devices present on the wire.\n");
 			break;
 		}
 
