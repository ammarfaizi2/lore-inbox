Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWAEA45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWAEA45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWAEAu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:64185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750971AbWAEAty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:54 -0500
Cc: rusty@rustcorp.com.au
Subject: [PATCH] Input: fix add modalias support build error
In-Reply-To: <1136422171546@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:31 -0800
Message-Id: <11364221713236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: fix add modalias support build error

Fix build when scripts/mod/file2alias.c includes linux/input.h, which
tries to include /usr/include/linux/mod_devicetable.h:

 In file included from scripts/mod/file2alias.c:40:
 include/linux/input.h:21:35: linux/mod_devicetable.h: No such file or directory
 make[2]: *** [scripts/mod/file2alias.o] Error 1

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e39b84337b8aed3044683a57741a19e5002225b9
tree b0e6fdd68b9b7d24b984401795f4660cc9cf7d0b
parent 1d8f430c15b3a345db990e285742c67c2f52f9a6
author Rusty Russell <rusty@rustcorp.com.au> Sat, 10 Dec 2005 22:48:20 +1100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 include/linux/input.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index bef0855..6d4cc3c 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -13,12 +13,12 @@
 #include <linux/time.h>
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
 #include <asm/types.h>
 #endif
-#include <linux/mod_devicetable.h>
 
 /*
  * The event structure itself

