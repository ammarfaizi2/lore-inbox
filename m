Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965319AbWJCGhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965319AbWJCGhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 02:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWJCGhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 02:37:13 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:64701 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S964828AbWJCGhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 02:37:01 -0400
Date: Tue, 3 Oct 2006 14:25:25 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh updates
Message-ID: <20061003052525.GA7933@localhost.hsdv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Paul Mundt:
      sh: defconfig updates.
      sh: Set pclk default for SH7705.
      sh: Kill off more dead headers.
      sh: build fixes for defconfigs.
      sh: Initial gitignore list
      sh: Kill off remaining config.h references.
      sh: Fixup __raw_read_trylock().

 arch/sh/Kconfig                        |    2 
 arch/sh/boards/hp6xx/hp6xx_apm.c       |    1 
 arch/sh/boards/hp6xx/pm.c              |    1 
 arch/sh/boards/landisk/irq.c           |    4 
 arch/sh/boards/landisk/landisk_pwb.c   |    2 
 arch/sh/boards/landisk/rtc.c           |    2 
 arch/sh/boards/landisk/setup.c         |    1 
 arch/sh/boards/renesas/r7780rp/irq.c   |    4 
 arch/sh/boards/renesas/r7780rp/led.c   |    2 
 arch/sh/boards/renesas/systemh/setup.c |    2 
 arch/sh/boards/se/7343/io.c            |    2 
 arch/sh/boards/se/7343/irq.c           |    4 
 arch/sh/boards/se/7343/led.c           |    2 
 arch/sh/boards/se/7343/setup.c         |    1 
 arch/sh/boards/se/770x/setup.c         |    7 
 arch/sh/boards/se/7751/setup.c         |    6 
 arch/sh/boards/sh03/setup.c            |    1 
 arch/sh/boot/.gitignore                |    1 
 arch/sh/configs/adx_defconfig          |  539 -------------------
 arch/sh/configs/cqreek_defconfig       |  533 -------------------
 arch/sh/configs/dreamcast_defconfig    |  572 ++++++++++++++------
 arch/sh/configs/hp6xx_defconfig        |  201 +++++--
 arch/sh/configs/hs7751rvoip_defconfig  |  908 +++++++++++++++++++++++++++++++++
 arch/sh/configs/landisk_defconfig      |  417 ++++++++-------
 arch/sh/configs/microdev_defconfig     |  167 ++++--
 arch/sh/configs/r7780rp_defconfig      |  232 ++++++--
 arch/sh/configs/rts7751r2d_defconfig   |  568 ++++++++++++++------
 arch/sh/configs/se7300_defconfig       |  357 +++++++++---
 arch/sh/configs/se73180_defconfig      |  347 +++++++++---
 arch/sh/configs/se7343_defconfig       |  101 ++-
 arch/sh/configs/se7705_defconfig       |  531 +++++++++++++------
 arch/sh/configs/se7750_defconfig       |  532 +++++++++++++------
 arch/sh/configs/se7751_defconfig       |  626 +++++++++++++---------
 arch/sh/configs/sh03_defconfig         |  568 ++++++++++++++------
 arch/sh/configs/sh7710voipgw_defconfig |   78 ++
 arch/sh/configs/shmin_defconfig        |   93 ++-
 arch/sh/configs/snapgear_defconfig     |  527 +++++++++++++------
 arch/sh/configs/systemh_defconfig      |  370 +++++++++----
 arch/sh/configs/titan_defconfig        |  619 ++++++++++++++++------
 arch/sh/drivers/dma/dma-sysfs.c        |    8 
 arch/sh/drivers/pci/ops-landisk.c      |    1 
 arch/sh/drivers/pci/ops-r7780rp.c      |    2 
 arch/sh/drivers/pci/ops-sh03.c         |    4 
 arch/sh/drivers/pci/ops-titan.c        |    2 
 arch/sh/drivers/pci/pci-sh7780.c       |    2 
 arch/sh/kernel/apm.c                   |    1 
 arch/sh/kernel/entry.S                 |    6 
 arch/sh/kernel/setup.c                 |    4 
 arch/sh/kernel/sh_ksyms.c              |    1 
 arch/sh/kernel/vsyscall/.gitignore     |    1 
 arch/sh/math-emu/math.c                |    1 
 arch/sh/mm/cache-debugfs.c             |    2 
 arch/sh/tools/gen-mach-types           |    2 
 include/asm-sh/.gitignore              |    3 
 include/asm-sh/cpu-sh3/rtc.h           |   25 
 include/asm-sh/cpu-sh4/rtc.h           |   25 
 include/asm-sh/elf.h                   |    1 
 include/asm-sh/hs7751rvoip/io.h        |   39 -
 include/asm-sh/rts7751r2d/io.h         |   37 -
 include/asm-sh/rts7751r2d/rts7751r2d.h |    3 
 include/asm-sh/sfp-machine.h           |    2 
 include/asm-sh/spinlock.h              |    9 
 include/asm-sh/string.h                |   15 
 63 files changed, 5706 insertions(+), 3421 deletions(-)
