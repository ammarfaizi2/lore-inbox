Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVFUAbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVFUAbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVFUAa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:30:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:47844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261773AbVFTW75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:57 -0400
Cc: jasonuhl@sgi.com
Subject: [PATCH] Fix typo in scdrv_init()
In-Reply-To: <11193083672817@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <11193083672883@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix typo in scdrv_init()

Fix a typo in scdrv_init() which was breaking the build for SGI sn2.

Signed-off-by: Jason Uhlenkott <jasonuhl@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 12eac738e5889a10da5b391c02eeb61229c796dc
tree f571bf26898e816d91f0a830a45a0dc6f781fc6e
parent 0d3e5a2e39b6ba2974e9e7c2a429018c45de8e76
author Jason Uhlenkott <jasonuhl@sgi.com> Wed, 30 Mar 2005 13:19:54 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:27 -0700

 drivers/char/snsc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/snsc.c b/drivers/char/snsc.c
--- a/drivers/char/snsc.c
+++ b/drivers/char/snsc.c
@@ -437,7 +437,7 @@ scdrv_init(void)
 				continue;
 			}
 
-			class__device_create(snsc_class, dev, NULL,
+			class_device_create(snsc_class, dev, NULL,
 						"%s", devname);
 
 			ia64_sn_irtr_intr_enable(scd->scd_nasid,

