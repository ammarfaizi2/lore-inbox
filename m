Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTDUKNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 06:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTDUKNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 06:13:20 -0400
Received: from gta.loris.tv ([217.89.68.44]:29327 "EHLO gta.loris.tv")
	by vger.kernel.org with ESMTP id S263806AbTDUKNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 06:13:19 -0400
Date: Mon, 21 Apr 2003 12:25:09 +0200
From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
To: linux-kernel@vger.kernel.org
Subject: I4L-error in 2.5
Message-ID: <20030421102509.GA25113@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is it normal that isdn_common.o has such a problem? Failing command is:

gcc -Wp,-MD,drivers/isdn/i4l/.isdn_common.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=isdn_common -DKBUILD_MODNAME=isdn -c -o drivers/isdn/i4l/.tmp_isdn_common.o drivers/isdn/i4l/isdn_common.c

Compile-error is:

drivers/isdn/i4l/isdn_common.c: In function `drv_register':
drivers/isdn/i4l/isdn_common.c:605: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `drv_stat_run':
drivers/isdn/i4l/isdn_common.c:616: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `drv_stat_stop':
drivers/isdn/i4l/isdn_common.c:623: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `drv_stat_stavail':
drivers/isdn/i4l/isdn_common.c:653: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `isdn_status_read':
drivers/isdn/i4l/isdn_common.c:1341: warning: comparison between signed and unsigned
drivers/isdn/i4l/isdn_common.c: In function `isdn_ctrl_read':
drivers/isdn/i4l/isdn_common.c:1503: warning: comparison between signed and unsigned
drivers/isdn/i4l/isdn_common.c: In function `map_drvname':
drivers/isdn/i4l/isdn_common.c:1984: error: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `map_namedrv':
drivers/isdn/i4l/isdn_common.c:1991: error: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `isdn_register_divert':
drivers/isdn/i4l/isdn_common.c:2007: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:439)
drivers/isdn/i4l/isdn_common.c:2013: error: `isdn_command' undeclared (first use in this function)
drivers/isdn/i4l/isdn_common.c:2013: error: (Each undeclared identifier is reported only once
drivers/isdn/i4l/isdn_common.c:2013: error: for each function it appears in.)
drivers/isdn/i4l/isdn_common.c:2016: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:427)
drivers/isdn/i4l/isdn_common.c: At top level:
drivers/isdn/i4l/isdn_common.c:2223: warning: `isdn_register_devfs' defined but not used
drivers/isdn/i4l/isdn_common.c:2227: warning: `isdn_unregister_devfs' defined but not used

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP: v2-key via keyserver

[X] <-- nail here for new monitor
