Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSHOXSS>; Thu, 15 Aug 2002 19:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317603AbSHOXSS>; Thu, 15 Aug 2002 19:18:18 -0400
Received: from dp.samba.org ([66.70.73.150]:56000 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317602AbSHOXSS>;
	Thu, 15 Aug 2002 19:18:18 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15708.14066.32752.365661@argo.ozlabs.ibm.com>
Date: Fri, 16 Aug 2002 09:19:14 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] broken cfb* support in the 2.5.31-bk
In-Reply-To: <Pine.LNX.4.33.0208142128260.7482-100000@maxwell.earthlink.net>
References: <20020814192327.GD37217@ppc.vc.cvut.cz>
	<Pine.LNX.4.33.0208142128260.7482-100000@maxwell.earthlink.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons writes:

> That was done to push people to port there drivers to the new api.

Well, what _is_ the new API?

Anyway, you could apply this patch, for a start.  I wish you would be
a bit more careful about details.

Paul.

diff -urN linux-2.5/drivers/video/Makefile pmac-2.5/drivers/video/Makefile
--- linux-2.5/drivers/video/Makefile	Wed Aug 14 09:15:02 2002
+++ pmac-2.5/drivers/video/Makefile	Fri Aug 16 09:08:34 2002
@@ -60,7 +60,7 @@
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblit.o cfbcopyarea.o
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_CLGEN)            += clgenfb.o
