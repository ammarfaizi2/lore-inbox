Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbUKYGjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUKYGjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 01:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbUKYGjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 01:39:48 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:61540 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262990AbUKYGia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:38:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] v4l: fix permissions on module parameters exported via sysfs
Date: Thu, 25 Nov 2004 01:38:27 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411250138.27831.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another case of 0 missing from octal encoding.

-- 
Dmitry


===================================================================


ChangeSet@1.1969, 2004-11-25 00:40:44-05:00, dtor_core@ameritech.net
  v4l: Fix permissions on module parameters exported via sysfs.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 tuner.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


===================================================================



diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	2004-11-25 01:27:47 -05:00
+++ b/drivers/media/video/tuner.c	2004-11-25 01:27:47 -05:00
@@ -30,24 +30,24 @@
 /* insmod options used at init time => read/only */
 static unsigned int type  =  UNSET;
 static unsigned int addr  =  0;
-module_param(type, int, 444);
-module_param(addr, int, 444);
+module_param(type, int, 0444);
+module_param(addr, int, 0444);
 
 /* insmod options used at runtime => read/write */
 static unsigned int debug         = 0;
 static unsigned int tv_antenna    = 1;
 static unsigned int radio_antenna = 0;
 static unsigned int optimize_vco  = 1;
-module_param(debug,             int, 644);
-module_param(tv_antenna,        int, 644);
-module_param(radio_antenna,     int, 644);
-module_param(optimize_vco,      int, 644);
+module_param(debug,             int, 0644);
+module_param(tv_antenna,        int, 0644);
+module_param(radio_antenna,     int, 0644);
+module_param(optimize_vco,      int, 0644);
 
 static unsigned int tv_range[2]    = { 44, 958 };
 static unsigned int radio_range[2] = { 65, 108 };
 
-module_param_array(tv_range,    int, NULL, 644);
-module_param_array(radio_range, int, NULL, 644);
+module_param_array(tv_range,    int, NULL, 0644);
+module_param_array(radio_range, int, NULL, 0644);
 
 MODULE_DESCRIPTION("device driver for various TV and TV+FM radio tuners");
 MODULE_AUTHOR("Ralph Metzler, Gerd Knorr, Gunther Mayer");
