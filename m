Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264086AbTEWPte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTEWPte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:49:34 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:43753
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264086AbTEWPtd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:49:33 -0400
Date: Fri, 23 May 2003 12:02:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [bug] only serial console -> build failure
Message-ID: <20030523160239.GA8575@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,drivers/char/.vt.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=pentium4
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=vt -DKBUILD_MODNAME=vt -c -o
drivers/char/vt.o drivers/char/vt.c
drivers/char/vt.c: In function `vty_init':
drivers/char/vt.c:2518: `console_driver' undeclared (first use in this
function)
drivers/char/vt.c:2518: (Each undeclared identifier is reported only
once
drivers/char/vt.c:2518: for each function it appears in.)
make[2]: *** [drivers/char/vt.o] Error 1
make[1]: *** [drivers/char] Error 2

[jgarzik@fokker2 atascsi-2.5]$ grep CONS .config
CONFIG_SCSI_CONSTANTS=y
# CONFIG_VT_CONSOLE is not set
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_VGA_CONSOLE is not set
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

