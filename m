Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWCWW1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWCWW1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWCWW1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:27:52 -0500
Received: from havoc.gtf.org ([69.61.125.42]:28318 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932499AbWCWW1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:27:50 -0500
Date: Thu, 23 Mar 2006 17:27:45 -0500
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [git patches] net driver build fix + update
Message-ID: <20060323222745.GA30296@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[just sent to andrew/linus; patch omitted due to size]

Notables:
* merges wireless "softmac" layer, enabling support for newer wireless
  hardware which requires software management of low-level details.
  Not quite winmodem level, in terms of hardware simplicity, but close.
* 'make allmodconfig' build fix, in the sky2 update.

The 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

contains the following updates:

 drivers/net/skge.c                              |  105 +-
 drivers/net/skge.h                              |    1 
 drivers/net/sky2.c                              |    8 
 drivers/net/wireless/Kconfig                    |    9 
 drivers/net/wireless/airo.c                     |  455 +++++++----
 drivers/net/wireless/hostap/hostap_ap.c         |    2 
 drivers/net/wireless/hostap/hostap_cs.c         |    2 
 drivers/net/wireless/hostap/hostap_hw.c         |    8 
 drivers/net/wireless/hostap/hostap_ioctl.c      |    4 
 drivers/net/wireless/hostap/hostap_pci.c        |    4 
 drivers/net/wireless/hostap/hostap_plx.c        |   13 
 include/linux/wireless.h                        |   10 
 include/net/ieee80211softmac.h                  |  292 +++++++
 include/net/ieee80211softmac_wx.h               |   94 ++
 include/net/iw_handler.h                        |   12 
 net/core/rtnetlink.c                            |   98 ++
 net/core/wireless.c                             |  911 +++++++++++++++++++++---
 net/ieee80211/Kconfig                           |    1 
 net/ieee80211/Makefile                          |    1 
 net/ieee80211/ieee80211_rx.c                    |   74 +
 net/ieee80211/softmac/Kconfig                   |   10 
 net/ieee80211/softmac/Makefile                  |    9 
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |  396 ++++++++++
 net/ieee80211/softmac/ieee80211softmac_auth.c   |  364 +++++++++
 net/ieee80211/softmac/ieee80211softmac_event.c  |  159 ++++
 net/ieee80211/softmac/ieee80211softmac_io.c     |  474 ++++++++++++
 net/ieee80211/softmac/ieee80211softmac_module.c |  457 ++++++++++++
 net/ieee80211/softmac/ieee80211softmac_priv.h   |  230 ++++++
 net/ieee80211/softmac/ieee80211softmac_scan.c   |  244 ++++++
 net/ieee80211/softmac/ieee80211softmac_wx.c     |  412 ++++++++++
 30 files changed, 4531 insertions(+), 328 deletions(-)

Adrian Bunk:
      hostap: Fix hw reset after CMDCODE_ACCESS_WRITE timeout
      hostap: Fix ap_add_sta() return value verification

Dan Williams:
      wireless/airo: clean up printk usage to print device name
      wireless/airo: define default MTU
      wireless/airo: cache wireless scans

David Woodhouse:
      Restore channel setting after scan.

Denis Vlasenko:
      ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt

Eugene Teo:
      hostap: Fix double free in prism2_config() error path

Jean Tourrilhes:
      WE-20 for kernel 2.6.16

Johannes Berg:
      wireless: Add softmac layer to the kernel
      make softmac depend on IEEE80211 and EXPERIMENTAL
      softmac: fix some sparse warnings
      softmac: fix Makefiles
      softmac: convert to use global workqueue
      softmac: correctly use netif_carrier_{on,off}
      softmac: try to reassociate when being disassociated from the AP
      softmac: add fixme for disassoc
      softmac: select "best" network based on rssi
      softmac: check if disassociation is for us before processing it
      softmac: scan at least once before selecting a network by essid
      softmac: properly check return value of ieee80211softmac_alloc_mgt
      softmac: some comment stuff
      softmac: add copyright and license headers
      softmac: add MODULE_DESCRIPTION and MODULE_AUTHORs
      softmac: move EXPORT_SYMBOL_GPL right after functions
      update copyright in softmac
      trivial fixes to softmac
      softmac: update deauth handler to quiet warning
      softmac: add reassociation code
      softmac: remove dead code

John W. Linville:
      softmac: remove function_enter()

Jouni Malinen:
      hostap: Fix unlikely read overrun in CIS parsing
      hostap: Remove dead code (duplicated idx != 0)
      hostap: Fix memory leak on PCI probe error path

Larry Finger:
      Fix softmac scan

Stephen Hemminger:
      sky2: typo in last stats patch
      sky2: Fix RX stats
      sky2: dont need to use dev_kfree_skb_any
      skge: align receive buffers
      skge: dont use dev_alloc_skb for rx buffs
      skge: rx_reuse called twice
      skge: multicast statistics fix
      skge: dont free skb until multi-part transmit complete
      skge: compute available ring buffers
      skge: version 1.5

