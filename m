Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVAPCIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVAPCIK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVAPCGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:06:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25614 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262390AbVAPCBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:01:43 -0500
Date: Sun, 16 Jan 2005 03:01:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 setup.c: make 4 variables static (fwd)
Message-ID: <20050116020137.GJ4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 12 Dec 2004 03:11:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 setup.c: make 4 variables static

The patch below makes four needlessly global variables static.


diffstat output:
 arch/i386/kernel/setup.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/setup.c.old	2004-12-11 23:44:49.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/setup.c	2004-12-11 23:46:04.000000000 +0100
@@ -425,10 +425,10 @@
 	struct e820entry *pbios; /* pointer to original bios entry */
 	unsigned long long addr; /* address for this change point */
 };
-struct change_member change_point_list[2*E820MAX] __initdata;
-struct change_member *change_point[2*E820MAX] __initdata;
-struct e820entry *overlap_list[E820MAX] __initdata;
-struct e820entry new_bios[E820MAX] __initdata;
+static struct change_member change_point_list[2*E820MAX] __initdata;
+static struct change_member *change_point[2*E820MAX] __initdata;
+static struct e820entry *overlap_list[E820MAX] __initdata;
+static struct e820entry new_bios[E820MAX] __initdata;
 
 static int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

