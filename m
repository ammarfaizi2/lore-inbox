Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVJ2SWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVJ2SWE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVJ2SWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:22:04 -0400
Received: from havoc.gtf.org ([69.61.125.42]:58755 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751236AbVJ2SWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:22:03 -0400
Date: Sat, 29 Oct 2005 14:21:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver updates
Message-ID: <20051029182159.GA14467@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following random collection of updates and new drivers:

 MAINTAINERS                                |    8 
 drivers/net/Kconfig                        |   77 
 drivers/net/Makefile                       |    3 
 drivers/net/acenic.c                       |    6 
 drivers/net/amd8111e.c                     |    0 
 drivers/net/amd8111e.h                     |    0 
 drivers/net/au1000_eth.c                   |    6 
 drivers/net/b44.c                          |   28 
 drivers/net/bmac.c                         |    6 
 drivers/net/bnx2.c                         |   12 
 drivers/net/e1000/e1000_ethtool.c          |    7 
 drivers/net/e1000/e1000_main.c             |    9 
 drivers/net/eepro.c                        |    7 
 drivers/net/fs_enet/Kconfig                |   20 
 drivers/net/fs_enet/Makefile               |   10 
 drivers/net/fs_enet/fs_enet-main.c         | 1226 ++++++++++
 drivers/net/fs_enet/fs_enet-mii.c          |  507 ++++
 drivers/net/fs_enet/fs_enet.h              |  245 ++
 drivers/net/fs_enet/mac-fcc.c              |  578 ++++
 drivers/net/fs_enet/mac-fec.c              |  653 +++++
 drivers/net/fs_enet/mac-scc.c              |  524 ++++
 drivers/net/fs_enet/mii-bitbang.c          |  405 +++
 drivers/net/fs_enet/mii-fixed.c            |   92 
 drivers/net/hamradio/mkiss.c               |    6 
 drivers/net/ibm_emac/Makefile              |   13 
 drivers/net/ibm_emac/ibm_emac.h            |  418 +--
 drivers/net/ibm_emac/ibm_emac_core.c       | 3414 +++++++++++++++--------------
 drivers/net/ibm_emac/ibm_emac_core.h       |  313 +-
 drivers/net/ibm_emac/ibm_emac_debug.c      |  377 +--
 drivers/net/ibm_emac/ibm_emac_debug.h      |   63 
 drivers/net/ibm_emac/ibm_emac_mal.c        |  674 +++--
 drivers/net/ibm_emac/ibm_emac_mal.h        |  336 ++
 drivers/net/ibm_emac/ibm_emac_phy.c        |  335 +-
 drivers/net/ibm_emac/ibm_emac_phy.h        |  105 
 drivers/net/ibm_emac/ibm_emac_rgmii.c      |  201 +
 drivers/net/ibm_emac/ibm_emac_rgmii.h      |   68 
 drivers/net/ibm_emac/ibm_emac_tah.c        |  111 
 drivers/net/ibm_emac/ibm_emac_tah.h        |   96 
 drivers/net/ibm_emac/ibm_emac_zmii.c       |  255 ++
 drivers/net/ibm_emac/ibm_emac_zmii.h       |  114 
 drivers/net/ibmveth.c                      |  186 -
 drivers/net/ibmveth.h                      |   23 
 drivers/net/irda/donauboe.c                |    6 
 drivers/net/irda/irda-usb.c                |    6 
 drivers/net/irda/irport.c                  |    3 
 drivers/net/irda/sir_dev.c                 |    3 
 drivers/net/irda/vlsi_ir.c                 |    3 
 drivers/net/mace.c                         |    6 
 drivers/net/ne2k-pci.c                     |    1 
 drivers/net/ni65.c                         |    9 
 drivers/net/pcmcia/pcnet_cs.c              |    6 
 drivers/net/rrunner.c                      |    6 
 drivers/net/s2io.c                         |   13 
 drivers/net/saa9730.c                      |    8 
 drivers/net/sis190.c                       |    2 
 drivers/net/sis900.c                       |   16 
 drivers/net/smc91x.c                       |    4 
 drivers/net/starfire.c                     |    4 
 drivers/net/sundance.c                     |   62 
 drivers/net/tg3.c                          |   91 
 drivers/net/tg3.h                          |   12 
 drivers/net/tulip/de2104x.c                |    6 
 drivers/net/tulip/tulip_core.c             |    6 
 drivers/net/via-velocity.c                 |    6 
 drivers/net/wireless/airo.c                |   48 
 drivers/net/wireless/airo_cs.c             |    4 
 drivers/net/wireless/atmel.c               |    6 
 drivers/net/wireless/atmel_cs.c            |    3 
 drivers/net/wireless/hermes.c              |   38 
 drivers/net/wireless/hermes.h              |    2 
 drivers/net/wireless/hostap/hostap_ioctl.c |    9 
 drivers/net/wireless/ipw2200.c             |    4 
 drivers/net/wireless/orinoco.c             |   13 
 drivers/net/wireless/prism54/islpci_dev.c  |    3 
 drivers/net/wireless/prism54/islpci_eth.c  |   13 
 drivers/net/wireless/prism54/oid_mgt.c     |    9 
 drivers/net/wireless/strip.c               |   38 
 include/linux/fs_enet_pd.h                 |  136 +
 include/linux/pci_ids.h                    |    2 
 include/net/ax25.h                         |    3 
 include/net/netrom.h                       |    3 
 81 files changed, 8958 insertions(+), 3192 deletions(-)


Akinobu Mita:
      s2io: kconfig help fix

Al Viro:
      s2io iomem annotations

Alan Cox:
      Better fixup for the orinoco driver

Alexey Dobriyan:
      starfire: free_irq() on error path of netdev_open()

Andrew Morton:
      [netdrvr b44] include linux/dma-mapping.h to eliminate warning
      revert "orinoco: Information leakage due to incorrect padding"

Ashutosh Naik:
      e1000: Fixes e1000_suspend warning when CONFIG_PM is not enabled

Aurelien Jarno:
      sis190.c: fix multicast MAC filter

Deepak Saxena:
      Fix CS89x0 KConfig for IXDP2X01

Eugene Surovegin:
      New PowerPC 4xx on-chip ethernet controller driver
      Add MAINTAINER entry for the new PowerPC 4xx on-chip ethernet controller driver

Florin Malita:
      eepro.c: module_param_array cleanup

Jeff Garzik:
      [git] change permissions on drivers/net/amd8111e.[ch] to 0644,

Jesper Juhl:
      drivers/net: Remove pointless checks for NULL prior to calling kfree()

Komuro:
      pcnet_cs: fix mii init code for older DL10019 based cards
      [netdrvr] ne2k-pci based card does not support bus-mastering.

Martin J. Bligh:
      e1000: remove warning about e1000_suspend

Matthew Wilcox:
      b44 reports wrong advertised flags

Michael Chan:
      tg3: add 5714/5715 support
      tg3: fix ASF heartbeat
      tg3: update version and minor fixes

Nicolas Pitre:
      smc91x: shut down power after probing

Panagiotis Issaris:
      ipw2200: Missing kmalloc check

Pantelis Antoniou:
      Add fs_enet ethernet network driver, for several embedded platforms.

Patrick McHardy:
      prism54: Free skb after disabling interrupts

Pavel Machek:
      b44: fix suspend/resume

Philippe De Muyter:
      sundance: fix DFE-580TX Tx Underrun

Ravikiran G Thirumalai:
      e1000: use vmalloc_node()

Roger While:
      [wireless prism54] Fix frame length

Santiago Leon:
      ibmveth fix bonding
      ibmveth fix buffer pool management
      ibmveth fix buffer replenishing
      ibmveth lockless TX
      ibmveth fix failed addbuf

Tobias Klauser:
      drivers/net/tg3: Use the DMA_{32,64}BIT_MASK constants

Vasily Averin:
      sis900: come alive after temporary memory shortage

