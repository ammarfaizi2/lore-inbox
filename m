Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSHRXZR>; Sun, 18 Aug 2002 19:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHRXZR>; Sun, 18 Aug 2002 19:25:17 -0400
Received: from ip68-4-77-172.oc.oc.cox.net ([68.4.77.172]:6650 "HELO
	ip68-4-77-172.oc.oc.cox.net") by vger.kernel.org with SMTP
	id <S316530AbSHRXZR>; Sun, 18 Aug 2002 19:25:17 -0400
Date: Sun, 18 Aug 2002 16:29:18 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4(/2.5?) clarify devfs documentation
Message-ID: <20020818232918.GC5154@ip68-4-77-172.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The section of the devfs documentation which discusses the ability to
run a devfs-enabled kernel without devfs mounted is possibly confusing.
Hopefully this patch will make it easier to understand. It's against
2.4.20-pre3 but it applies to 2.4.19 and 2.5.31 as well.

For 2.4, please apply or explain any objections. If it's applied for
2.4, it would be good to apply it for 2.5 as well, although it might be
moot if devfs is killed during 2.5.

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.20-pre3/Documentation/filesystems/devfs/README linux-2.4.20-pre3-bkn1/Documentation/filesystems/devfs/README
--- linux-2.4.20-pre3/Documentation/filesystems/devfs/README	Thu May 16 01:58:33 2002
+++ linux-2.4.20-pre3-bkn1/Documentation/filesystems/devfs/README	Sun Aug 18 16:16:01 2002
@@ -727,7 +727,11 @@
 mount(8) programme uses /proc/partitions as part of
 the volume label search process, and the device names it finds are not
 available, because setting CONFIG_DEVFS_FS=y changes the names in
-/proc/partitions, irrespective of whether devfs is mounted.
+/proc/partitions, irrespective of whether devfs is mounted. Another
+exception is if the device nodes in the underlying /dev have been
+deleted. Even if devfs is enabled, it cannot be used if it is not
+mounted (the on-disk /dev will be used instead, unless/until devfs
+is mounted).
 
 Now you've finished all the steps required. You're now ready to boot
 your shiny new kernel. Enjoy.
