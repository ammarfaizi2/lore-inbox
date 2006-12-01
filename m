Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936509AbWLAUC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936509AbWLAUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936538AbWLAUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:02:27 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:18072 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S936509AbWLAUC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:02:26 -0500
Message-ID: <45708A56.3040508@drzeus.cx>
Date: Fri, 01 Dec 2006 21:02:30 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MMC update
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

        git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git for-linus

to receive the following updates:

 drivers/mmc/Kconfig          |    2
 drivers/mmc/at91_mci.c       |    2
 drivers/mmc/au1xmmc.c        |    2
 drivers/mmc/imxmmc.c         |    2
 drivers/mmc/mmc.c            |  294 +++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/mmc_block.c      |   15 +-
 drivers/mmc/mmc_queue.c      |   63 +++++----
 drivers/mmc/mmc_queue.h      |    3
 drivers/mmc/mmci.c           |    2
 drivers/mmc/omap.c           |  272 ++++++++++++++++++++++++---------------
 drivers/mmc/omap.h           |   55 --------
 drivers/mmc/pxamci.c         |    2
 drivers/mmc/sdhci.c          |   17 ++
 drivers/mmc/sdhci.h          |    2
 drivers/mmc/wbsd.c           |    2
 include/linux/mmc/card.h     |   13 ++
 include/linux/mmc/protocol.h |   74 ++++++++++-
 17 files changed, 593 insertions(+), 229 deletions(-)

Christoph Hellwig:
      mmc: remove kernel_thread()

David Brownell:
      mmc: constify mmc_host_ops vectors

Juha Yrjola juha.yrjola:
      Replace base with virt_base and phys_base
      Change OMAP_MMC_{READ,WRITE} macros to use the host pointer
      Move register definitions away from the header file
      Platform device error handling cleanup
      Make general code cleanups

Marcin Juszkiewicz:
      trivial change for mmc/Kconfig: MMC_PXA does not mean only PXA255

Philip Langdale:
      mmc: Add support for mmc v4 high speed mode
      mmc: Add support for mmc v4 wide-bus modes

Pierre Ossman:
      mmc: Fix mmc_delay() function
      mmc: Support for high speed SD cards
      mmc: sdhci high speed support
      mmc: Flush block queue when removing card
      mmc: correct request error handling

Tony Lindgren tony:
      Add MMC_CAP_{MULTIWRITE,BYTEBLOCK} flags


-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
