Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbULGToI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbULGToI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbULGTnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:43:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48139 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261912AbULGTfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:45 -0500
Date: Tue, 7 Dec 2004 20:35:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] mark QNX4FS_RW as BROKEN (fwd)
Message-ID: <20041207193538.GI7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below (already ACK'ed by Anders Larsen) still 
applies against 2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 23:22:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Anders Larsen <al@alarsen.net>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] mark QNX4FS_RW as BROKEN

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
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

