Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130620AbRCFMbz>; Tue, 6 Mar 2001 07:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbRCFMbp>; Tue, 6 Mar 2001 07:31:45 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:45840 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130620AbRCFMbk>;
	Tue, 6 Mar 2001 07:31:40 -0500
Date: Tue, 06 Mar 2001 13:31:15 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: make checkconfig results on linux 2.4.3-pre2
To: linux-kernel@vger.kernel.org
Message-id: <3AA4D893.DB8A09B@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI :

[root@localhost linux]# make checkconfig
find * -name '*.[hcS]' -type f -print | sort | xargs perl -w scripts/checkconfig.pl
arch/cris/kernel/head.S: 34: need CONFIG_CRIS_LOW_MAP.
drivers/char/ip2.c: 9: <linux/config.h> not needed.
drivers/pcmcia/hd64465_ss.c: 33: <linux/config.h> not needed.
drivers/scsi/aic7xxx/aic7xxx_linux.c: 160: need CONFIG_AIC7XXX_RESET_DELAY.
drivers/scsi/aic7xxx/aic7xxx_linux.c: 172: need CONFIG_AIC7XXX_PROC_STATS.
drivers/scsi/aic7xxx/aic7xxx_linux.c: 234: need CONFIG_AIC7XXX_CMDS_PER_DEVICE.
drivers/scsi/aic7xxx/aic7xxx_linux.c: 1043: need CONFIG_PCI.
include/asm-ppc/tqm8xx.h: 69: need CONFIG_TQM8xxL.
include/asm-ppc/tqm8xx.h: 72: need CONFIG_TQM860.
net/lapb/lapb_iface.c: 18: <linux/config.h> not needed.
[root@localhost linux]# head Makefile
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 3
EXTRAVERSION =-pre2


someone should also  run 'make checkhelp' ...
reports a LOT of missing help text

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
