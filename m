Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWHTNh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWHTNh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 09:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWHTNh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 09:37:27 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:53668 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750784AbWHTNh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 09:37:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=M9yXY7iM0e+VGbq4WUk/kQ4tJErKhlZ87Bsy8gpGu6KjEata02S7MgeyyUl4BBiPCYMNpG3tSiKlgdQ+A55MenzJR6waVOD75gFPN7OX7H3C1XJguB55Al91OMeVmmNTbE0jEQDAIJ+heCfLIh/t3pPp2UCIi0rVlWA2CJBPr0g=
Date: Sun, 20 Aug 2006 22:37:20 +0900
From: Tejun Heo <htejun@gmail.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] file: kill unnecessary includes in fs/file.c
Message-ID: <20060820133720.GO6371@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill unnecessary mm.h, time.h and bitops.h includes in fs/file.c.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/file.c |    3 ---
 1 file changed, 3 deletions(-)

Index: work/fs/file.c
===================================================================
--- work.orig/fs/file.c
+++ work/fs/file.c
@@ -7,12 +7,9 @@
  */
 
 #include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/file.h>
-#include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
