Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSLQT4K>; Tue, 17 Dec 2002 14:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSLQT4K>; Tue, 17 Dec 2002 14:56:10 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8466 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265523AbSLQT4J>;
	Tue, 17 Dec 2002 14:56:09 -0500
Date: Tue, 17 Dec 2002 21:04:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: drivers/base/fs/fs.h - needed?
Message-ID: <20021217200405.GA1191@mars.ravnborg.org>
Mail-Followup-To: mochel@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/partitions/check.c the following ugly include exists:
#include <../drivers/base/fs/fs.h>	/* Eeeeewwwww */

It can be killed with no problem, the prototypes contained therein are
not used by check.c.

Is this preparations for furter device model changes?
If thats the case, the fs.h file, or at least the content, shall be placed
in include/linux for general access.

Here is a patch to remove the said include statement.

	Sam

===== fs/partitions/check.c 1.90 vs edited =====
--- 1.90/fs/partitions/check.c	Thu Dec  5 20:01:25 2002
+++ edited/fs/partitions/check.c	Tue Dec 17 20:57:02 2002
@@ -19,7 +19,6 @@
 #include <linux/blk.h>
 #include <linux/kmod.h>
 #include <linux/ctype.h>
-#include <../drivers/base/fs/fs.h>	/* Eeeeewwwww */
 
 #include "check.h"
 
