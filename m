Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWHQN0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWHQN0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWHQN0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:10 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:27041 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932487AbWHQN0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:05 -0400
Date: Thu, 17 Aug 2006 13:26:38 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC][PATCH 0/75] pci_module_init to pci_register_driver conversion
Message-ID: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

pci_module_init is obsolete.

This patch series converts pci_module_init to pci_register_driver.

 ata/ata_generic.c                     |    2 +-
 ata/pata_pdc2027x.c                   |    2 +-
 char/ipmi/ipmi_si_intf.c              |    2 +-
 crypto/geode-aes.c                    |    2 +-
 edac/k8_edac.c                        |    2 +-
 net/3c59x.c                           |    2 +-
 net/8139cp.c                          |    2 +-
 net/8139too.c                         |    2 +-
 net/acenic.c                          |    2 +-
 net/amd8111e.c                        |    2 +-
 net/arcnet/com20020-pci.c             |    2 +-
 net/b44.c                             |    2 +-
 net/bnx2.c                            |    2 +-
 net/cassini.c                         |    2 +-
 net/chelsio/cxgb2.c                   |    2 +-
 net/defxx.c                           |    2 +-
 net/dl2k.c                            |    2 +-
 net/e100.c                            |    2 +-
 net/e1000/e1000_main.c                |    2 +-
 net/eepro100.c                        |    2 +-
 net/epic100.c                         |    2 +-
 net/fealnx.c                          |    2 +-
 net/forcedeth.c                       |    2 +-
 net/hp100.c                           |    2 +-
 net/ixgb/ixgb_main.c                  |    2 +-
 net/natsemi.c                         |    2 +-
 net/ne2k-pci.c                        |    2 +-
 net/ns83820.c                         |    2 +-
 net/pci-skeleton.c                    |    2 +-
 net/pcnet32.c                         |    2 +-
 net/r8169.c                           |    2 +-
 net/rrunner.c                         |    2 +-
 net/s2io.c                            |    2 +-
 net/saa9730.c                         |    2 +-
 net/sis190.c                          |    2 +-
 net/sis900.c                          |    2 +-
 net/sk98lin/skge.c                    |    2 +-
 net/skfp/skfddi.c                     |    2 +-
 net/skge.c                            |    2 +-
 net/starfire.c                        |    2 +-
 net/sundance.c                        |    2 +-
 net/sungem.c                          |    2 +-
 net/tc35815.c                         |    2 +-
 net/tg3.c                             |    2 +-
 net/tokenring/3c359.c                 |    2 +-
 net/tokenring/lanstreamer.c           |    2 +-
 net/tokenring/olympic.c               |    2 +-
 net/tulip/de2104x.c                   |    2 +-
 net/tulip/de4x5.c                     |    2 +-
 net/tulip/dmfe.c                      |    2 +-
 net/tulip/tulip_core.c                |    2 +-
 net/tulip/winbond-840.c               |    2 +-
 net/tulip/xircom_tulip_cb.c           |    2 +-
 net/typhoon.c                         |    2 +-
 net/via-rhine.c                       |    2 +-
 net/via-velocity.c                    |    2 +-
 net/wan/dscc4.c                       |    2 +-
 net/wan/farsync.c                     |    2 +-
 net/wan/lmc/lmc_main.c                |    2 +-
 net/wan/pc300_drv.c                   |    2 +-
 net/wan/pci200syn.c                   |    2 +-
 net/wan/wanxl.c                       |    2 +-
 net/wireless/atmel_pci.c              |    2 +-
 net/wireless/ipw2100.c                |    2 +-
 net/wireless/ipw2200.c                |    2 +-
 net/wireless/orinoco_nortel.c         |    2 +-
 net/wireless/orinoco_pci.c            |    2 +-
 net/wireless/orinoco_plx.c            |    2 +-
 net/wireless/orinoco_tmd.c            |    2 +-
 net/wireless/prism54/islpci_hotplug.c |    2 +-
 net/yellowfin.c                       |    2 +-
 scsi/ips.c                            |    2 +-
 scsi/megaraid.c                       |    2 +-
 scsi/megaraid/megaraid_sas.c          |    2 +-
 scsi/tmscsim.c                        |    2 +-
 75 files changed, 75 insertions(+), 75 deletions(-)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
