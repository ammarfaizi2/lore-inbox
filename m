Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUJ3VX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUJ3VX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUJ3VX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:23:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59154 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261328AbUJ3VXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:23:22 -0400
Date: Sat, 30 Oct 2004 23:22:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Anders Larsen <al@alarsen.net>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] mark QNX4FS_RW as BROKEN
Message-ID: <20041030212249.GY4374@stusta.de>
References: <20041030180702.GT4374@stusta.de> <20041030183422.GY24336@parcelfarce.linux.theplanet.co.uk> <1099162888l.2673l.0l@errol.alarsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099162888l.2673l.0l@errol.alarsen.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:01:28PM +0000, Anders Larsen wrote:
> On Sat, Oct 30, 2004 at 08:07:02PM +0200, Adrian Bunk wrote:
> >The patch below does the following cleanups in the QNX4 fs:
> >- remove two unused global functions
> 
> If you remove any code inside the #ifdef CONFIG_QNX4FS_RW we might
> as well remove the option "config QNX4FS_RW" altogether.
> It's horribly broken, and I don't intend to fix it; while I was
> thinking about how to properly implement write-support, somebody else
> went away and did it. As that alternative seems to work well and is
> being actively maintained, I won't try to reinvent it.


OK, I understand why my patch wasn't good.

What about the following to mark it as BROKEN in the Kconfig file?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/Kconfig.old	2004-10-30 23:15:17.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/Kconfig	2004-10-30 23:15:34.000000000 +0200
@@ -1353,7 +1353,7 @@
 
 config QNX4FS_RW
 	bool "QNX4FS write support (DANGEROUS)"
-	depends on QNX4FS_FS && EXPERIMENTAL
+	depends on QNX4FS_FS && EXPERIMENTAL && BROKEN
 	help
 	  Say Y if you want to test write support for QNX4 file systems.
 

