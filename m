Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315559AbSEJLy7>; Fri, 10 May 2002 07:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315586AbSEJLy6>; Fri, 10 May 2002 07:54:58 -0400
Received: from kim.it.uu.se ([130.238.12.178]:5248 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S315559AbSEJLy6>;
	Fri, 10 May 2002 07:54:58 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.46344.198789.990708@kim.it.uu.se>
Date: Fri, 10 May 2002 13:54:48 +0200
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.15 warnings
In-Reply-To: <26949.1021006885@kao2.melbourne.sgi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
 > drivers/char/drm/mga_dma.c: In function `mga_do_dma_wrap_start':
 > drivers/char/drm/mga_dma.c:244: warning: passing arg 2 of `set_bit' from incompatible pointer type
 > drivers/char/drm/mga_dma.c: In function `mga_do_dma_wrap_end':
 > drivers/char/drm/mga_dma.c:261: warning: passing arg 2 of `clear_bit' from incompatible pointer type
 > drivers/char/drm/mga_dma.c: In function `mga_dma_flush':
 > drivers/char/drm/mga_dma.c:710: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
[and lots more]

This patch silences the drm/mga warnings. Tested; I've been using it for weeks.

/Mikael

--- linux-2.5.15/drivers/char/drm/mga_drv.h.~1~	Wed Feb 20 03:11:05 2002
+++ linux-2.5.15/drivers/char/drm/mga_drv.h	Fri May 10 01:54:40 2002
@@ -38,7 +38,7 @@
 
 	u32 tail;
 	int space;
-	volatile int wrapped;
+	volatile long wrapped;
 
 	volatile u32 *status;
 
