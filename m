Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262764AbSJCHBT>; Thu, 3 Oct 2002 03:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262765AbSJCHBT>; Thu, 3 Oct 2002 03:01:19 -0400
Received: from users.linvision.com ([62.58.92.114]:2965 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262764AbSJCHBS>; Thu, 3 Oct 2002 03:01:18 -0400
Date: Thu, 3 Oct 2002 09:06:45 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH_] Should fix __FUNCTION__ glomming issues with some GCCs
Message-ID: <20021003090645.A15874@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Approved by author.... 

		Roger. 

----- Forwarded message from John R R Leavitt <jrrl@tiki.livetide.com> -----

From: John R R Leavitt <jrrl@tiki.livetide.com>
To: R.E.Wolff@BitWizard.nl
Date: Wed, 2 Oct 2002 22:35:30 -0400
Subject: [PATCH_] Should fix __FUNCTION__ glomming issues with some GCCs

Just wandered the driver tree and fixed these where I could.  Here's yours.

-John.

John Leavitt - jrrl@steampunk.com - Linux Consulting


diff -ruN linux-2.5.40-original/drivers/atm/firestream.c linux-2.5.40/drivers/atm/firestream.c
--- linux-2.5.40-original/drivers/atm/firestream.c	Tue Oct  1 03:06:18 2002
+++ linux-2.5.40/drivers/atm/firestream.c	Wed Oct  2 19:20:13 2002
@@ -330,8 +330,8 @@
 #define FS_DEBUG_QSIZE   0x00001000
 
 
-#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter " __FUNCTION__ "\n")
-#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  " __FUNCTION__ "\n")
+#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter %s\n", __FUNCTION__)
+#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  %s\n", __FUNCTION__)
 
 
 struct fs_dev *fs_boards = NULL;

----- End forwarded message -----

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
