Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbSJHTK6>; Tue, 8 Oct 2002 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbSJHTK0>; Tue, 8 Oct 2002 15:10:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22288 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263242AbSJHTFL>; Tue, 8 Oct 2002 15:05:11 -0400
Subject: PATCH: fix aha152x
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:02:21 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzcb-0004tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/aha152x.c linux.2.5.41-ac1/drivers/scsi/aha152x.c
--- linux.2.5.41/drivers/scsi/aha152x.c	2002-10-07 22:12:25.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/aha152x.c	2002-10-08 00:10:55.000000000 +0100
@@ -250,6 +250,7 @@
 
 #include "aha152x.h"
 #include <linux/stat.h>
+#include <linux/workqueue.h>
 
 #include <scsi/scsicam.h>
 
