Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVHLSaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVHLSaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVHLSaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:30:25 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:23365 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbVHLSaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:30:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=qveqcBSiZyTpJBC1Rv7GqRreeYSPD/ie9wAU2XMVvB1sokZql6F/U8mnb5tZC1psPLjP/HROq89vfYNXoxBPfovexBPmtrHjUc4Yz65OiCIasCSrU3wqCVdxCqnH2vYMocfeD4Gw+9FJc3Q+c4/5wZbwUul7svff3Z2I0DLnRvM=
Date: Fri, 12 Aug 2005 22:38:54 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sparc, ppc64 build failures (allmodconfig, -latest)
Message-ID: <20050812183854.GA3204@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	ppc64

drivers/isdn/hisax/avm_pci.c: In function `hdlc_empty_fifo':
drivers/isdn/hisax/avm_pci.c:271: error: `_IO_BASE' undeclared (first use in this function)

drivers/macintosh/via-pmu.c:63:27: asm/backlight.h: No such file or directory

Same thing for:

drivers/video/aty/atyfb_base.c:94:11: error: unable to open 'asm/backlight.h'
drivers/video/aty/radeon_base.c:83:11: error: unable to open 'asm/backlight.h'
drivers/video/aty/aty128fb.c:77:11: error: unable to open 'asm/backlight.h'
drivers/video/nvidia/nvidia.c:32:11: error: unable to open 'asm/backlight.h'
drivers/video/riva/fbdev.c:52:11: error: unable to open 'asm/backlight.h'
drivers/video/radeonfb.c:62:11: error: unable to open 'asm/backlight.h'
----------------------------------------------------------------------------
	sparc

drivers/char/ip2main.c:123:24: asm/serial.h: No such file or directory
drivers/char/synclinkmp.c:58:24: asm/serial.h: No such file or directory

  CC [M]  drivers/char/genrtc.o
In file included from drivers/char/genrtc.c:59:
include/asm/rtc.h:14: error: redefinition of `struct rtc_time'
drivers/char/genrtc.c: In function `genrtc_troutine':
drivers/char/genrtc.c:108: warning: implicit declaration of function `get_rtc_ss'
drivers/char/genrtc.c: In function `gen_rtc_interrupt':
drivers/char/genrtc.c:159: error: `RTC_UIE' undeclared (first use in this function)
----------------------------------------------------------------------------
i386, ppc, sparc64, x86_64 are OK wrt allmodconfig.

