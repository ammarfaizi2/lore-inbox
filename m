Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWGLX3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWGLX3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGLX3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:29:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:45028 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932203AbWGLX2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:28:49 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/3] [PATCH] w1: remove drivers/w1/w1.h
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:24:56 -0700
Message-Id: <1152746704578-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11527467003943-git-send-email-greg@kroah.com>
References: <20060712232249.GA22654@kroah.com> <11527466963731-git-send-email-greg@kroah.com> <11527467003943-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

drivers/w1/w1_io.h is both a subset of drivers/w1/w1.h and no longer
#include'd by any file.

This patch therefore removes w1_io.h.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/w1_io.h |   36 ------------------------------------
 1 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
deleted file mode 100644
index 9a76d2a..0000000
--- a/drivers/w1/w1_io.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- *	w1_io.h
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __W1_IO_H
-#define __W1_IO_H
-
-#include "w1.h"
-
-u8 w1_triplet(struct w1_master *dev, int bdir);
-void w1_write_8(struct w1_master *, u8);
-int w1_reset_bus(struct w1_master *);
-u8 w1_calc_crc8(u8 *, int);
-void w1_write_block(struct w1_master *, const u8 *, int);
-u8 w1_read_block(struct w1_master *, u8 *, int);
-void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb);
-int w1_reset_select_slave(struct w1_slave *sl);
-
-#endif /* __W1_IO_H */
-- 
1.4.1

