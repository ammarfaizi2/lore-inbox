Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVCZKvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVCZKvA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVCZKvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:51:00 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6920 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262030AbVCZKuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:50:54 -0500
Date: Sat, 26 Mar 2005 11:50:51 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326105051.GL30052@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326004631.GC17637@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

just in case you release an -rc3, would you please include this typo fix
from Jurgen Quade. I have it in my tree since 2.4.23, it's a pure copy-paste
typo which causes the driver either to print an incomplete message or a
seconde unexpected one. BTW, it's fixed in 2.6.

Thanks,
Willy

--- ./drivers/block/floppy.old.c	2003-12-22 11:42:42.000000000 +0100
+++ ./drivers/block/floppy.c	2003-12-22 11:44:00.000000000 +0100
@@ -2563,7 +2563,7 @@
 			       current_count_sectors);
 			if (CT(COMMAND) == FD_READ)
 				printk("read\n");
-			if (CT(COMMAND) == FD_READ)
+			if (CT(COMMAND) == FD_WRITE)
 				printk("write\n");
 			break;
 		}
@@ -2894,7 +2894,7 @@
 			       current_count_sectors);
 			if (CT(COMMAND) == FD_READ)
 				printk("read\n");
-			if (CT(COMMAND) == FD_READ)
+			if (CT(COMMAND) == FD_WRITE)
 				printk("write\n");
 			return 0;
 		}

