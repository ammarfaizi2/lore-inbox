Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424870AbWKQBUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424870AbWKQBUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424867AbWKQBTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:19:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57096 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424865AbWKQBTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:19:34 -0500
Date: Fri, 17 Nov 2006 02:19:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [-mm patch] make drivers/acpi/bay.c:drive_bays static
Message-ID: <20061117011933.GQ31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-acpi.patch
>...
>  git trees
>...

This patch makes the needlessly global "drive_bays" static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/acpi/bay.c.old	2006-11-16 23:03:28.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/acpi/bay.c	2006-11-16 23:03:38.000000000 +0100
@@ -70,7 +70,7 @@
 	struct proc_dir_entry *proc;
 };
 
-LIST_HEAD(drive_bays);
+static LIST_HEAD(drive_bays);
 
 static struct proc_dir_entry *acpi_bay_dir;
 

