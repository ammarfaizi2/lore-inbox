Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129310AbRCBQzL>; Fri, 2 Mar 2001 11:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129311AbRCBQzB>; Fri, 2 Mar 2001 11:55:01 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:55813
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S129310AbRCBQyn>; Fri, 2 Mar 2001 11:54:43 -0500
Date: Fri, 02 Mar 2001 11:53:46 -0500
From: Chris Mason <mason@suse.com>
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/filesystems/Locking
Message-ID: <272230000.983552026@tiny>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


filesystems need to grab the bkl on their own for fsync now:

-chris

--- linux/Documentation/filesystems/Locking.1	Fri Mar  2 11:20:18 2001
+++ linux/Documentation/filesystems/Locking	Fri Mar  2 11:21:10 2001
@@ -229,7 +229,7 @@
 open:		maybe	(see below)
 flush:		yes
 release:	no
-fsync:		yes	(see below)
+fsync:		no	(see below)
 fasync:		yes	(see below)
 lock:		yes
 readv:		no

