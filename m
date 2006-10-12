Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422748AbWJLDVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbWJLDVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 23:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161367AbWJLDVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 23:21:44 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:45507 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1161366AbWJLDVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 23:21:43 -0400
Date: Thu, 12 Oct 2006 12:21:25 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh updates
Message-ID: <20061012032125.GA7059@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Jamie Lenehan:
      sh: Fix pr_debug statements for sh4

Paul Mundt:
      sh: First step at generic timeofday support.
      sh: Kill off timer_ops get_frequency().
      sh: Updates for IRQ handler changes.
      sh: Convert r7780rp IRQ handler to IRQ chip.
      sh: Convert INTC2 IRQ handler to irq_chip.
      sh: Convert IPR-IRQ to IRQ chip.
      sh: Zero-out coherent buffer in consistent_alloc().
      sh: Default enable R7780RP IRQs.
      sh: interrupt exception handling rework

Ryusuke Sakato:
      sh: SH-4A UBC support

 arch/sh/Kconfig                        |    4 
 arch/sh/boards/hp6xx/hp6xx_apm.c       |    4 
 arch/sh/boards/landisk/landisk_pwb.c   |    2 
 arch/sh/boards/mpc1211/setup.c         |    5 
 arch/sh/boards/renesas/r7780rp/irq.c   |  105 +-----
 arch/sh/boards/snapgear/setup.c        |    2 
 arch/sh/cchips/hd6446x/hd64461/setup.c |    2 
 arch/sh/cchips/hd6446x/hd64465/gpio.c  |    2 
 arch/sh/cchips/hd6446x/hd64465/setup.c |    2 
 arch/sh/cchips/voyagergx/irq.c         |    3 
 arch/sh/drivers/dma/dma-g2.c           |    2 
 arch/sh/drivers/dma/dma-pvr2.c         |    2 
 arch/sh/drivers/dma/dma-sh.c           |    6 
 arch/sh/drivers/pci/pci-sh7751.c       |    4 
 arch/sh/drivers/pci/pci-st40.c         |    2 
 arch/sh/kernel/cpu/irq/intc2.c         |  138 +--------
 arch/sh/kernel/cpu/irq/ipr.c           |  102 +-----
 arch/sh/kernel/cpu/sh3/ex.S            |  195 ------------
 arch/sh/kernel/cpu/sh4/ex.S            |  500 ---------------------------------
 arch/sh/kernel/entry.S                 |   43 ++
 arch/sh/kernel/irq.c                   |   42 +-
 arch/sh/kernel/process.c               |   30 +
 arch/sh/kernel/time.c                  |    9 
 arch/sh/kernel/timers/timer-tmu.c      |   63 ----
 arch/sh/mm/consistent.c                |    1 
 drivers/rtc/rtc-sh.c                   |    6 
 drivers/serial/sh-sci.c                |    4 
 include/asm-sh/cpu-sh4/ubc.h           |   37 ++
 include/asm-sh/hw_irq.h                |    4 
 include/asm-sh/irq.h                   |   14 
 include/asm-sh/irq_regs.h              |    1 
 include/asm-sh/timer.h                 |   13 
 32 files changed, 249 insertions(+), 1100 deletions(-)
