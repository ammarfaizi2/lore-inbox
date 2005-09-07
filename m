Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVIGEzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVIGEzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 00:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVIGEzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 00:55:20 -0400
Received: from havoc.gtf.org ([69.61.125.42]:41396 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751100AbVIGEzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 00:55:19 -0400
Date: Wed, 7 Sep 2005 00:55:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [git patches] net driver update
Message-ID: <20050907045516.GA9227@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just sent this to Andrew/Linus]

Please pull from 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the various updates described below:


 drivers/net/Kconfig                       |    7 
 drivers/net/Makefile                      |    2 
 drivers/net/ac3200.c                      |    2 
 drivers/net/atarilance.c                  |    2 
 drivers/net/dm9000.c                      |    2 
 drivers/net/forcedeth.c                   |    4 
 drivers/net/iseries_veth.c                |    1 
 drivers/net/s2io-regs.h                   |   13 
 drivers/net/s2io.c                        |   98 -
 drivers/net/s2io.h                        |    5 
 drivers/net/spider_net.c                  | 2334 ++++++++++++++++++++++++++++++
 drivers/net/spider_net.h                  |  469 ++++++
 drivers/net/spider_net_ethtool.c          |  126 +
 drivers/net/sun3lance.c                   |    2 
 drivers/net/wireless/airo.c               |   43 
 drivers/net/wireless/atmel.c              |   17 
 drivers/net/wireless/ipw2200.c            | 2264 ++++++++++++++---------------
 drivers/net/wireless/ipw2200.h            |  408 ++---
 drivers/net/wireless/netwave_cs.c         |    7 
 drivers/net/wireless/prism54/isl_ioctl.c  |    3 
 drivers/net/wireless/prism54/islpci_dev.c |    3 
 drivers/net/wireless/ray_cs.c             |  858 +++++------
 drivers/net/wireless/ray_cs.h             |    7 
 drivers/net/wireless/wl3501.h             |    1 
 drivers/net/wireless/wl3501_cs.c          |    7 
 drivers/s390/net/claw.c                   |   20 
 include/linux/pci_ids.h                   |    1 
 include/linux/wireless.h                  |   38 
 include/net/iw_handler.h                  |  123 +
 net/core/wireless.c                       |   58 
 net/ieee80211/ieee80211_crypt.c           |   27 
 net/ieee80211/ieee80211_crypt_ccmp.c      |   47 
 net/ieee80211/ieee80211_crypt_tkip.c      |  131 -
 net/ieee80211/ieee80211_crypt_wep.c       |   30 
 net/ieee80211/ieee80211_module.c          |   40 
 net/ieee80211/ieee80211_rx.c              |  310 ++-
 net/ieee80211/ieee80211_tx.c              |   66 
 net/ieee80211/ieee80211_wx.c              |   73 
 38 files changed, 5350 insertions(+), 2299 deletions(-)



Al Viro:
  lvalues abuse in lance

Frank Pavlic:
  s390: claw driver fixes

Jean Tourrilhes:
  WE-19 for kernel 2.6.13
  ray_cs : WE-17 support
  iw263_netwave_we17.diff
  atmel_cs : WE-17 support
  wl3501_cs : WE-17 support
  prism54 : WE-17 support
  airo : WE-19 support

Jeff Garzik:
  [wireless] build fixes after merging WE-19
  [wireless ieee80211,ipw2200] Lindent source code

>>
>> NOTE: As explained in the full cset description, this Lindent
>> will help us sync up Intel, and as a side effect make the code
>> look better.
>>

Jens Osterkamp:
  net: add driver for the NIC on Cell Blades
  net: update the spider_net driver
  net: fix bonding with spider_net

Michael Ellerman:
  iseries_veth: Update copyright notice

ravinandan.arakali@neterion.com:
  S2io: Hardware and miscellaneous fixes

viro@ftp.linux.org.uk:
  iomem annotations (ac3200.c)
  missed s/u32/pm_message_t/ (dm9000)
  __user annotations (forcedeth.c)



[patch snipped]

