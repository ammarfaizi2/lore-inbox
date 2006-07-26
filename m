Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWGZLAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWGZLAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGZLAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:00:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43792 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751281AbWGZLAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:00:37 -0400
Date: Wed, 26 Jul 2006 13:00:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/ttpci/: remove unneeded #include <linux/byteorder/swabb.h>'s
Message-ID: <20060726110036.GG25367@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since av7110.c is the only file actually using something from this 
header, there's no reson for other files to
#include <linux/byteorder/swabb.h>.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/ttpci/av7110_av.c  |    1 -
 drivers/media/dvb/ttpci/av7110_ca.c  |    1 -
 drivers/media/dvb/ttpci/av7110_hw.c  |    1 -
 drivers/media/dvb/ttpci/av7110_v4l.c |    1 -
 4 files changed, 4 deletions(-)

--- linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_av.c.old	2006-07-25 06:01:44.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_av.c	2006-07-25 06:01:50.000000000 +0200
@@ -33,7 +33,6 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/byteorder/swabb.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 
--- linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_ca.c.old	2006-07-25 06:01:58.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_ca.c	2006-07-25 06:02:00.000000000 +0200
@@ -35,7 +35,6 @@
 #include <linux/fs.h>
 #include <linux/timer.h>
 #include <linux/poll.h>
-#include <linux/byteorder/swabb.h>
 #include <linux/smp_lock.h>
 
 #include "av7110.h"
--- linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_hw.c.old	2006-07-25 06:02:09.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_hw.c	2006-07-25 06:02:12.000000000 +0200
@@ -34,7 +34,6 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/byteorder/swabb.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 
--- linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_v4l.c.old	2006-07-25 06:02:21.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/media/dvb/ttpci/av7110_v4l.c	2006-07-25 06:02:24.000000000 +0200
@@ -32,7 +32,6 @@
 #include <linux/fs.h>
 #include <linux/timer.h>
 #include <linux/poll.h>
-#include <linux/byteorder/swabb.h>
 #include <linux/smp_lock.h>
 
 #include "av7110.h"

