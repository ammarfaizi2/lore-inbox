Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288531AbSATNTA>; Sun, 20 Jan 2002 08:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288544AbSATNSu>; Sun, 20 Jan 2002 08:18:50 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:40455 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S288531AbSATNSe>; Sun, 20 Jan 2002 08:18:34 -0500
Message-ID: <3C4AC3A6.5E545E31@delusion.de>
Date: Sun, 20 Jan 2002 14:18:30 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] dnotify compile fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch against 2.5.3-pre2 fixes a compile error in dnotify.h.
I'm not sure if this is the preferred way, but it works for me.

diff -Naur -X dontdiff linux-2.5.3-vanilla/include/linux/dnotify.h linux-2.5.3/include/linux/dnotify.h
--- linux-2.5.3-vanilla/include/linux/dnotify.h Fri Sep 22 23:21:22 2000
+++ linux-2.5.3/include/linux/dnotify.h Sun Jan 20 13:46:23 2002
@@ -4,6 +4,8 @@
  * Copyright 2000 (C) Stephen Rothwell
  */

+#include <linux/fs.h>
+
 struct dnotify_struct {
        struct dnotify_struct * dn_next;
        int                     dn_magic;
