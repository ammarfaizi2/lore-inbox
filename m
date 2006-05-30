Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWE3PZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWE3PZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWE3PZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:25:37 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:54283 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932313AbWE3PZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:25:36 -0400
Date: Tue, 30 May 2006 17:25:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: small documentation update
Message-Id: <20060530172536.d1d44245.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rtc driver documentation update

* Mention the max-user-freq control file.
* Add missing header in example code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/rtc.txt |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc5.orig/Documentation/rtc.txt	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.17-rc5/Documentation/rtc.txt	2006-05-30 17:09:52.000000000 +0200
@@ -44,8 +44,10 @@
 Programming and/or enabling interrupt frequencies greater than 64Hz is
 only allowed by root. This is perhaps a bit conservative, but we don't want
 an evil user generating lots of IRQs on a slow 386sx-16, where it might have
-a negative impact on performance.  Note that the interrupt handler is only
-a few lines of code to minimize any possibility of this effect.
+a negative impact on performance. This 64Hz limit can be changed by writing
+a different value to /proc/sys/dev/rtc/max-user-freq. Note that the
+interrupt handler is only a few lines of code to minimize any possibility
+of this effect.
 
 Also, if the kernel time is synchronized with an external source, the 
 kernel will write the time back to the CMOS clock every 11 minutes. In 
@@ -81,6 +83,7 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <linux/rtc.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>


-- 
Jean Delvare
