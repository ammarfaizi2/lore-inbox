Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTBGWgF>; Fri, 7 Feb 2003 17:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTBGWgF>; Fri, 7 Feb 2003 17:36:05 -0500
Received: from fmr01.intel.com ([192.55.52.18]:4312 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266795AbTBGWgE>;
	Fri, 7 Feb 2003 17:36:04 -0500
Subject: [PATCH][Trvial 2.5.59] rtc.c is requesting more ioports then it
	really uses
From: Rusty Lynch <rusty@linux.co.intel.com>
To: p_gortmaker@yahoo.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Feb 2003 14:40:55 -0800
Message-Id: <1044657656.1132.19.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to enable a device that talks to port 0x79h, but for some
reason the rtc is requesting move bytes then it really uses.  Here
is a patch that makes the rtc only request what it uses.

    --rustyl

--- drivers/char/rtc.c.orig	2003-02-07 14:35:31.000000000 -0800
+++ drivers/char/rtc.c	2003-02-07 13:25:45.000000000 -0800
@@ -47,7 +47,7 @@
 
 #define RTC_VERSION		"1.11"
 
-#define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
+#define RTC_IO_EXTENT	0x2
 
 /*
  *	Note that *all* calls to CMOS_READ and CMOS_WRITE are done with



