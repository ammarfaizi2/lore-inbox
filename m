Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVCCVAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVCCVAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVCCU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:56:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262577AbVCCUyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:54:18 -0500
Date: Thu, 3 Mar 2005 21:54:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/awe_wave.c: fix a compile warning
Message-ID: <20050303205415.GJ4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile warning:

<--  snip  -->

...
  CC      sound/oss/awe_wave.o
In file included from sound/oss/os.h:31,
                 from sound/oss/sound_config.h:21,
                 from sound/oss/awe_wave.c:37:
include/linux/soundcard.h:195:1: warning: "_PATCHKEY" redefined
In file included from sound/oss/awe_wave.c:30:
include/linux/awe_voice.h:33:1: warning: this is the location of the previous definition
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/include/linux/awe_voice.h.old	2005-03-03 16:14:35.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/include/linux/awe_voice.h	2005-03-03 16:15:12.000000000 +0100
@@ -29,10 +29,6 @@
 #define SAMPLE_TYPE_AWE32	0x20
 #endif
 
-#ifndef _PATCHKEY
-#define _PATCHKEY(id) ((id<<8)|0xfd)
-#endif
-
 /*----------------------------------------------------------------
  * patch information record
  *----------------------------------------------------------------*/

