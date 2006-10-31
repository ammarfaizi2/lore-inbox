Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161611AbWJaD6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161611AbWJaD6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161610AbWJaD6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:58:43 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:41636 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1161612AbWJaD6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:58:43 -0500
Date: Tue, 31 Oct 2006 12:58:22 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh updates
Message-ID: <20061031035822.GA9851@linux-sh.org>
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

Jamie Lenehan (2):
      sh: Fix IPR-IRQ's for IRQ-chip change breakage.
      sh: Titan defconfig update.

Kristoffer Ericson (1):
      video: Fix include in hp680_bl.

Paul Mundt (2):
      sh: Wire up new syscalls.
      sh: Update r7780rp_defconfig.

 arch/sh/boards/renesas/hs7751rvoip/setup.c  |   12 +
 arch/sh/boards/renesas/sh7710voipgw/setup.c |  105 +++++++---------
 arch/sh/boards/se/7300/irq.c                |   20 +--
 arch/sh/boards/se/73180/irq.c               |   47 ++++---
 arch/sh/boards/se/7343/irq.c                |   90 +++++++-------
 arch/sh/boards/se/770x/irq.c                |   80 ++++++------
 arch/sh/boards/se/7751/irq.c                |   85 ++++++-------
 arch/sh/boards/sh03/setup.c                 |   13 +-
 arch/sh/boards/snapgear/setup.c             |   12 +
 arch/sh/boards/titan/setup.c                |   12 +
 arch/sh/configs/r7780rp_defconfig           |  174 +++++++++++++++-------------
 arch/sh/configs/titan_defconfig             |  101 +++++++++++-----
 arch/sh/drivers/dma/dma-sh.c                |   42 ++++--
 arch/sh/kernel/cpu/irq/ipr.c                |  106 +++++++----------
 arch/sh/kernel/cpu/irq/pint.c               |    8 -
 arch/sh/kernel/syscalls.S                   |    3 
 drivers/video/backlight/hp680_bl.c          |    2 
 include/asm-sh/irq.h                        |   10 +
 include/asm-sh/unistd.h                     |    5 
 19 files changed, 517 insertions(+), 410 deletions(-)
