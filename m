Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423353AbWF1OTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423353AbWF1OTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423357AbWF1OTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:19:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:17821 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423353AbWF1OTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:19:13 -0400
Date: Wed, 28 Jun 2006 16:19:10 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i4l remove unneeded include/linux/isdn/tpam.h
Message-ID: <20060628141910.GA27943@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.13-4-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TPAM isdn driver was removed in 2.6.12, but include/linux/isdn/tpam.h
was missed.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 include/linux/isdn/tpam.h |   55 ---------------------------------------------
 1 files changed, 0 insertions(+), 55 deletions(-)
 delete mode 100644 include/linux/isdn/tpam.h

54a748ce0ae237bd14cafc9e38316df51d55869c
diff --git a/include/linux/isdn/tpam.h b/include/linux/isdn/tpam.h
deleted file mode 100644
index d18dd0d..0000000
--- a/include/linux/isdn/tpam.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* $Id: tpam.h,v 1.1.2.1 2001/06/08 08:23:46 kai Exp $
- *
- * Turbo PAM ISDN driver for Linux. (Kernel Driver)
- *
- * Copyright 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alc?ve
- *
- * For all support questions please contact: <support@auvertech.fr>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef _TPAM_H_
-#define _TPAM_H_
-
-#include <linux/types.h>
-
-/* IOCTL commands */
-#define TPAM_CMD_DSPLOAD	0x0001
-#define TPAM_CMD_DSPSAVE	0x0002
-#define TPAM_CMD_DSPRUN		0x0003
-#define TPAM_CMD_LOOPMODEON	0x0004
-#define TPAM_CMD_LOOPMODEOFF	0x0005
-
-/* addresses of debug information zones on board */
-#define TPAM_TRAPAUDIT_REGISTER		0x005493e4
-#define TPAM_NCOAUDIT_REGISTER		0x00500000
-#define TPAM_MSGAUDIT_REGISTER		0x008E30F0
-
-/* length of debug information zones on board */
-#define TPAM_TRAPAUDIT_LENGTH		10000
-#define TPAM_NCOAUDIT_LENGTH		300000
-#define TPAM_NCOAUDIT_COUNT		30
-#define TPAM_MSGAUDIT_LENGTH		60000
-
-/* IOCTL load/save parameter */
-typedef struct tpam_dsp_ioctl {
-	__u32 address;	/* address to load/save data */
-	__u32 data_len;	/* size of data to be loaded/saved */
-	__u8 data[0];	/* data */
-} tpam_dsp_ioctl;
-
-#endif /* _TPAM_H_ */


-- 
Karsten Keil
SuSE Labs
ISDN development
