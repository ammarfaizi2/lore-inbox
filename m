Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFDWBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFDWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVFDWBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 18:01:09 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:52376 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261277AbVFDWAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 18:00:55 -0400
Date: Sat, 4 Jun 2005 18:00:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: netdev queue updated
Message-ID: <20050604220038.GA19421@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have just updated the netdev queue, merging several branches into the
upstream-2.6.13 branch.  Here are the branches that remain:

chelsio    ieee80211-wifi  master      register-netdev  smc91x-eeprom
ieee80211  janitor         misc-fixes  upstream-2.6.13

Notes for Andrew:
* we18 is now included in upstream-2.6.13.  so, iee80211* got renamed.
* master is always vanilla upstream, and can be ignored.
* misc-fixes was just sent to Linus


For all:

This is the contents of the 'upstream-2.6.13' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git


 drivers/net/fmv18x.c                      |  689 ------
 drivers/net/sk_g16.c                      | 2045 ------------------
 drivers/net/sk_g16.h                      |  164 -
 Documentation/networking/generic-hdlc.txt |   43 
 Documentation/networking/multicast.txt    |    1 
 Documentation/networking/net-modules.txt  |    3 
 drivers/net/8139cp.c                      |  100 
 drivers/net/8139too.c                     |  194 -
 drivers/net/Kconfig                       |   47 
 drivers/net/Makefile                      |    4 
 drivers/net/Space.c                       |    6 
 drivers/net/arm/etherh.c                  |   16 
 drivers/net/au1000_eth.c                  |   10 
 drivers/net/bmac.c                        |    2 
 drivers/net/dm9000.c                      | 1219 ++++++++++
 drivers/net/dm9000.h                      |  135 +
 drivers/net/pcmcia/pcnet_cs.c             |   17 
 drivers/net/ppp_generic.c                 |  175 -
 drivers/net/r8169.c                       |  343 ++-
 drivers/net/sk98lin/skge.c                |    8 
 drivers/net/skge.c                        | 3386 ++++++++++++++++++++++++++++++
 drivers/net/skge.h                        | 3005 ++++++++++++++++++++++++++
 drivers/net/smc91x.c                      |   58 
 drivers/net/smc91x.h                      |   15 
 drivers/net/starfire.c                    |  142 -
 drivers/net/starfire_firmware.h           |  346 +++
 drivers/net/tlan.c                        |    4 
 drivers/net/tokenring/ibmtr.c             |   11 
 drivers/net/wan/hdlc_fr.c                 |  318 +-
 drivers/net/wan/hdlc_generic.c            |   16 
 drivers/net/wan/lmc/lmc_main.c            |    8 
 drivers/net/wireless/orinoco.c            |  332 --
 drivers/net/wireless/orinoco.h            |    1 
 include/linux/dm9000.h                    |   36 
 include/linux/hdlc.h                      |    4 
 include/linux/if.h                        |    2 
 include/linux/wireless.h                  |  283 ++
 net/core/wireless.c                       |   74 
 38 files changed, 9435 insertions(+), 3827 deletions(-)


<felipewd@terra.com.br>:
  8139cp net driver: add MODULE_VERSION

<jgarzik@pretzel.yyz.us>:
  Automatic merge of /spare/repo/netdev-2.6 branch skge
  Automatic merge of /spare/repo/netdev-2.6 branch starfire
  Automatic merge of /spare/repo/netdev-2.6 branch smc91x
  Automatic merge of /spare/repo/netdev-2.6 branch remove-drivers
  Automatic merge of /spare/repo/netdev-2.6 branch iff-running
  Automatic merge of /spare/repo/netdev-2.6 branch we18
  Automatic merge of /spare/repo/netdev-2.6 branch viro
  Automatic merge of /spare/repo/netdev-2.6 branch r8169
  Automatic merge of /spare/repo/netdev-2.6 branch orinoco-hch
  Automatic merge of /spare/repo/netdev-2.6 branch ppp
  Automatic merge of /spare/repo/netdev-2.6 branch hdlc
  Automatic merge of /spare/repo/netdev-2.6 branch dm9000
  Automatic merge of /spare/repo/netdev-2.6 branch 8139too-iomap
  Automatic merge of /spare/repo/netdev-2.6 branch 8139cp
  Automatic merge of /spare/repo/netdev-2.6 branch master
  Automatic merge of rsync://www.fr.zoreil.com/linux-2.6.git branch HEAD
  Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD
  Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD

<jt@hpl.hp.com>:
  [PATCH] Wireless Extensions 18 (aka WPA)

<tgraf@suug.ch>:
  [netdrvrs] Use netif_carrier_* instead of IFF_RUNNING

Adrian Bunk <bunk@stusta.de>:
  [PATCH] remove two obsolete net drivers

Al Viro <viro@www.linux.org.uk>:
  pcnet_cs cleanup
  etherh iomem annotations
  skge missing include
  skge 64bit portability

Christoph Hellwig <hch@lst.de>:
  orinoco: make orinoco_stop() static
  orinoco: disconnect the network device on reset errors
  orinoco: misc fixes
  orinoco: Symbol 3.0x firmware needs broken_disableport
  orinoco: fix setting of 32 character ESSIDs

David Gibson <hermes@gibson.dropbear.id.au>:
  [PATCH] Orinoco: consolidate allocation code
  [PATCH] Orinoco: don't set channel in managed mode
  [PATCH] Orinoco: kill dump_recs
  [PATCH] Orinoco: ignore_disconnect flag
  [PATCH] Orinoco: wireless stats updates

Francois Romieu <romieu@fr.zoreil.com>:
  r8169: add module parameter (media)
  r8169: de-obfuscate supported PCI ID
  r8169: new PCI id
  [PATCH] r8169: incoming frame length check
  [PATCH] 8139cp: SG support fixes

Jeff Garzik <jgarzik@pobox.com>:
  [netdrvr starfire] Add GPL'd firmware, remove compat code
  [netdrvr 8139cp] TSO support

Krzysztof Halasa <khc@pm.waw.pl>:
  Generic HDLC update

Nicolas Pitre <nico@cam.org>:
  smc91x: more tweaks to help with RX overruns
  smc91x: improve diagnostic info
  [PATCH] smc91x warning fix
  [PATCH] smc91x addr config check

Paul Mackerras <paulus@samba.org>:
  [PATCH] PPP multilink fragmentation improvements

Pekka Enberg <penberg@cs.helsinki.fi>:
  [PATCH] 8139too: use iomap for pio/mmio

Richard Dawe <rich@phekda.gotadsl.co.uk>:
  r8169: minor cleanup

Sascha Hauer <s.hauer@pengutronix.de>:
  DM9000 network driver

Steffen Klassert <klassert@mathematik.tu-chemnitz.de>:
  [PATCH] 8139cp - add netpoll support

Stephen Hemminger <shemminger@osdl.org>:
  r8169: add ethtool support for dumping the chip statistics
  r8169: ethtool message level control support
  r8169: add module parameter (copybreak)
  r8169: identify the napi version
  [netdrvr] new driver skge, for SysKonnect cards
  [PATCH] 8139cp - module_param

