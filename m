Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTABM4p>; Thu, 2 Jan 2003 07:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTABM4p>; Thu, 2 Jan 2003 07:56:45 -0500
Received: from boden.synopsys.com ([204.176.20.19]:50399 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S261640AbTABM4o>; Thu, 2 Jan 2003 07:56:44 -0500
Date: Thu, 2 Jan 2003 14:04:53 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Cc: Will Dyson <will_dyson@pobox.com>, torvalds@transmeta.com
Subject: Patch: linux-2.5.54/fs/befs/linuxvfs.c compilation fix
Message-ID: <20030102130453.GA12098@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter, Thu, Jan 02, 2003 06:53:43 +0100:
> 	linux-2.5.54/fs/romfs/inode.c needs to include <asm/statfs.h>
> (which is new to 2.5.54) to compile again.  Here is the one line
> patch.

Also BeFS was touched.


--- 2.5.54/fs/befs/linuxvfs.c	2003-01-02 06:03:26.000000000 +0100
+++ 2.5.54a/fs/befs/linuxvfs.c	2003-01-02 13:57:27.000000000 +0100
@@ -12,7 +12,7 @@
 #include <linux/stat.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
-#include <linux/statfs.h>
+#include <asm/statfs.h>
 
 #include "befs.h"
 #include "btree.h"
