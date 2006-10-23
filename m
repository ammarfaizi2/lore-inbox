Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWJWB7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWJWB7w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJWB7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:59:52 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:34536 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751137AbWJWB7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:59:52 -0400
Date: Mon, 23 Oct 2006 10:59:33 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh updates
Message-ID: <20061023015933.GA20349@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Paul Mundt (7):
      sh: Proper show_stack/show_trace() implementation.
      sh: Remove board-specific ide.h headers.
      sh: Cleanup board header directories.
      sh: Fix exception_handling_table alignment.
      sh: Add some missing board headers.
      sh: Updates for irq-flow-type naming changes.
      sh: Convert INTC2 to IRQ table registration.

 arch/sh/boards/hp6xx/hp6xx_apm.c           |    2 
 arch/sh/boards/hp6xx/pm.c                  |    2 
 arch/sh/boards/hp6xx/setup.c               |    2 
 arch/sh/boards/renesas/hs7751rvoip/io.c    |    2 
 arch/sh/boards/renesas/hs7751rvoip/irq.c   |    2 
 arch/sh/boards/renesas/hs7751rvoip/setup.c |    7 -
 arch/sh/boards/renesas/r7780rp/io.c        |    2 
 arch/sh/boards/renesas/r7780rp/irq.c       |    9 -
 arch/sh/boards/renesas/r7780rp/setup.c     |    2 
 arch/sh/boards/renesas/rts7751r2d/io.c     |    4 
 arch/sh/boards/renesas/rts7751r2d/irq.c    |    6 
 arch/sh/boards/renesas/rts7751r2d/led.c    |   15 --
 arch/sh/boards/renesas/rts7751r2d/setup.c  |    2 
 arch/sh/boards/shmin/setup.c               |    2 
 arch/sh/cchips/voyagergx/irq.c             |   22 ---
 arch/sh/drivers/pci/ops-r7780rp.c          |    2 
 arch/sh/drivers/pci/ops-rts7751r2d.c       |   24 +--
 arch/sh/kernel/cpu/irq/intc2.c             |  165 ++++-----------------------
 arch/sh/kernel/cpu/irq/ipr.c               |    5 
 arch/sh/kernel/cpu/sh3/ex.S                |    9 +
 arch/sh/kernel/cpu/sh4/ex.S                |    9 +
 arch/sh/kernel/cpu/sh4/setup-sh7760.c      |   63 ++++++++++
 arch/sh/kernel/cpu/sh4/setup-sh7780.c      |   27 ++++
 arch/sh/kernel/irq.c                       |    2 
 arch/sh/kernel/process.c                   |   12 -
 arch/sh/kernel/traps.c                     |  167 +++++++++++++++------------
 drivers/input/touchscreen/hp680_ts_input.c |    2 
 drivers/video/hitfb.c                      |    1 
 include/asm-sh/edosk7705.h                 |   30 ++++
 include/asm-sh/edosk7705/io.h              |   30 ----
 include/asm-sh/hp6xx.h                     |   80 +++++++++++++
 include/asm-sh/hp6xx/hp6xx.h               |   80 -------------
 include/asm-sh/hp6xx/ide.h                 |    8 -
 include/asm-sh/hp6xx/io.h                  |   10 -
 include/asm-sh/hs7751rvoip.h               |   54 ++++++++
 include/asm-sh/hs7751rvoip/hs7751rvoip.h   |   54 --------
 include/asm-sh/hs7751rvoip/ide.h           |    8 -
 include/asm-sh/irq-sh7780.h                |   10 -
 include/asm-sh/irq.h                       |   21 ---
 include/asm-sh/landisk/ide.h               |   14 --
 include/asm-sh/processor.h                 |    2 
 include/asm-sh/r7780rp.h                   |  171 ++++++++++++++++++++++++++++
 include/asm-sh/r7780rp/ide.h               |    8 -
 include/asm-sh/r7780rp/r7780rp.h           |  177 -----------------------------
 include/asm-sh/rts7751r2d.h                |   74 ++++++++++++
 include/asm-sh/rts7751r2d/ide.h            |    8 -
 include/asm-sh/rts7751r2d/rts7751r2d.h     |   74 ------------
 include/asm-sh/sh03/ide.h                  |    7 -
 include/asm-sh/shmin.h                     |    9 +
 include/asm-sh/shmin/shmin.h               |    9 -
 include/asm-sh/system.h                    |    7 +
 sound/oss/sh_dac_audio.c                   |    2 
 52 files changed, 698 insertions(+), 818 deletions(-)
