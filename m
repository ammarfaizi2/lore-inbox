Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTDJQVs (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbTDJQVs (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:21:48 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39934 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264090AbTDJQVr (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:21:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 10 Apr 2003 18:33:26 +0200 (MEST)
Message-Id: <UTC200304101633.h3AGXQ125592.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] kill two scsi ioctls
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The definition for SCSI_IOCTL_BENCHMARK_COMMAND was added in 1.1.2.
The definition for SCSI_IOCTL_SYNC was added in 1.1.38.
Neither of them has ever been used.

diff -u --recursive --new-file -X /linux/dontdiff a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
--- a/include/scsi/scsi_ioctl.h	Fri Nov 22 22:40:13 2002
+++ b/include/scsi/scsi_ioctl.h	Thu Apr 10 18:23:31 2003
@@ -3,8 +3,6 @@
 
 #define SCSI_IOCTL_SEND_COMMAND 1
 #define SCSI_IOCTL_TEST_UNIT_READY 2
-#define SCSI_IOCTL_BENCHMARK_COMMAND 3
-#define SCSI_IOCTL_SYNC 4			/* Request synchronous parameters */
 #define SCSI_IOCTL_START_UNIT 5
 #define SCSI_IOCTL_STOP_UNIT 6
 /* The door lock/unlock constants are compatible with Sun constants for
