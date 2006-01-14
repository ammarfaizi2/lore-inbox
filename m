Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWANTzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWANTzL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWANTzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:55:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:521 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750843AbWANTzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:55:10 -0500
Date: Sat, 14 Jan 2006 20:55:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mark.fasheh@oracle.com, kurt.hackel@oracle.com
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/ocfs2/dlm/dlmrecovery.c must #include <linux/delay.h>
Message-ID: <20060114195510.GQ29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/ocfs2/dlm/dlmrecovery.c does now use msleep(), and does therefore 
need to #include <linux/delay.h> for getting the prototype of this 
function.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm4-full/fs/ocfs2/dlm/dlmrecovery.c.old	2006-01-14 16:44:15.000000000 +0100
+++ linux-2.6.15-mm4-full/fs/ocfs2/dlm/dlmrecovery.c	2006-01-14 16:45:06.000000000 +0100
@@ -39,6 +39,7 @@
 #include <linux/inet.h>
 #include <linux/timer.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 
 #include "cluster/heartbeat.h"

