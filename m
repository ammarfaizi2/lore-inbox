Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTEZOlc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTEZOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:41:32 -0400
Received: from pointblue.com.pl ([62.89.73.6]:12553 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262115AbTEZOlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:41:31 -0400
Subject: Re: [PATCH] 2.5.69-bk19 drm_memory.h compilation error
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus <torvalds@transmeta.com>
In-Reply-To: <20030526153107.A23896@infradead.org>
References: <1053956681.1852.7.camel@nalesnik.localhost>
	 <20030526153107.A23896@infradead.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053960179.17302.21.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 15:43:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that's better :]

On Mon, 2003-05-26 at 15:31, Christoph Hellwig wrote:

> Just include linux/highmem.h (never the asm version!) uncodintionally amd remove
> the noisy comment.
> 
diff -ur 1/drivers/char/drm/drm_memory.h 2/drivers/char/drm/drm_memory.h
--- 1/drivers/char/drm/drm_memory.h     2003-05-26 14:40:31.000000000
+0100
+++ 2/drivers/char/drm/drm_memory.h     2003-05-26 15:41:47.000000000
+0100
@@ -32,6 +32,8 @@
 #include <linux/config.h>
 #include "drmP.h"

+#include <linux/highmem.h>
+
 /* Cut down version of drm_memory_debug.h, which used to be called
  * drm_memory.h.  If you want the debug functionality, change 0 to 1
  * below.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

