Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319576AbSH3OuC>; Fri, 30 Aug 2002 10:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319577AbSH3OuB>; Fri, 30 Aug 2002 10:50:01 -0400
Received: from adsl-nrp3-sao-C8B6CF1E.brdterra.com.br ([200.182.207.30]:51157
	"EHLO tione.haus") by vger.kernel.org with ESMTP id <S319576AbSH3OuA>;
	Fri, 30 Aug 2002 10:50:00 -0400
Date: Fri, 30 Aug 2002 11:54:21 -0300
From: Christoph Simon <ciccio@kiosknet.com.br>
To: linux-kernel@vger.kernel.org
Subject: Compile error with SiS support
Message-Id: <20020830115421.67aaccc7.ciccio@kiosknet.com.br>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just tried to compile the kernel 2.4.19 with support for a SiS
graphics card. The related options in .config I've set are:

	CONFIG_AGP=y
	CONFIG_AGP_VIA=y
	CONFIG_AGP_SIS=y
	CONFIG_DRM=y
	CONFIG_DRM_NEW=y
	CONFIG_DRM_SIS=y

After compiling, it seems that sis_main.o has not be included with
drm.o:

drivers/char/drm/drm.o: In function `sis_fb_alloc':
drivers/char/drm/drm.o(.text+0x6d26): undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x6d6d): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_fb_free':
drivers/char/drm/drm.o(.text+0x6eb5): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_final_context':
drivers/char/drm/drm.o(.text+0x7386): undefined reference to `sis_free'
make: *** [vmlinux] Error 1

Any easy fix for this?

Thanks,

-- 
Christoph Simon
ciccio@kiosknet.com.br
