Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUHJOrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUHJOrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUHJOrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:47:22 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:44418 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S266271AbUHJOrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:47:21 -0400
Date: Tue, 10 Aug 2004 17:00:04 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 2.6.8-rc2-mm2] Include "compiler.h" in videodev.h
Message-Id: <20040810170004.08a0f15d.luca.risolia@studio.unibo.it>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids compiler errors about undefined "__user" macros when
including "videodev.h" in userspace applications:

--- devel-2.6.7/include/linux/videodev.h.orig	2004-08-10 16:40:04.000000000 +0200
+++ devel-2.6.7/include/linux/videodev.h	2004-08-10 16:42:39.094372072 +0200
@@ -1,6 +1,7 @@
 #ifndef __LINUX_VIDEODEV_H
 #define __LINUX_VIDEODEV_H
 
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/version.h>
 
