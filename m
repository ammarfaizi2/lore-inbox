Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269682AbRHIGGJ>; Thu, 9 Aug 2001 02:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269683AbRHIGF7>; Thu, 9 Aug 2001 02:05:59 -0400
Received: from zok.sgi.com ([204.94.215.101]:29122 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S269682AbRHIGFt>;
	Thu, 9 Aug 2001 02:05:49 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Hartmann <jhartmann@valinux.com>
cc: Gareth Hughes <gareth.hughes@acm.org>,
        DRI-Devel <dri-devel@lists.sourceforge.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Dri-devel] Re: DRM Linux kernel merge (update) needed, soon. 
In-Reply-To: Your message of "Wed, 08 Aug 2001 10:44:55 CST."
             <3B716C87.7010907@valinux.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Aug 2001 16:04:41 +1000
Message-ID: <11232.997337081@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.4.8-pre7 drivers/char/drm/Makefile.

Nothing in drm does EXPORT_SYMBOL().
radeon is missing from list-multi.

Index: 8-pre7.1/drivers/char/drm/Makefile
--- 8-pre7.1/drivers/char/drm/Makefile Thu, 09 Aug 2001 14:33:26 +1000 kaos (linux-2.4/W/b/2_Makefile 1.5 644)
+++ 8-pre7.1(w)/drivers/char/drm/Makefile Thu, 09 Aug 2001 15:43:48 +1000 kaos (linux-2.4/W/b/2_Makefile 1.5 644)
@@ -3,9 +3,7 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
 O_TARGET	:= drm.o
-export-objs	:= gamma_drv.o tdfx_drv.o r128_drv.o mga_drv.o i810_drv.o \
-		   ffb_drv.o
-list-multi	:= gamma.o tdfx.o r128.o mga.o i810.o ffb.o
+list-multi	:= gamma.o tdfx.o r128.o mga.o i810.o radeon.o ffb.o
 
 gamma-objs  := gamma_drv.o gamma_dma.o
 tdfx-objs   := tdfx_drv.o

