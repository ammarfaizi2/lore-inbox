Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWIXQYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWIXQYq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWIXQYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:24:45 -0400
Received: from havoc.gtf.org ([69.61.125.42]:41644 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751187AbWIXQYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:24:43 -0400
Date: Sun, 24 Sep 2006 12:24:42 -0400
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver updates
Message-ID: <20060924162442.GA14260@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just sent upstream to Andrew & Linus; patch available in git, it's too
large to post]

Nothing major of interest.  A couple new drivers (ehea, qla3xxx,
ep93xx_eth), a lot of trailing whitespace killed, a deleted MIPS driver,
e1000 update, ...

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 Documentation/networking/LICENSE.qla3xxx        |   46 
 MAINTAINERS                                     |   37 
 drivers/isdn/i4l/Kconfig                        |    1 
 drivers/net/3c501.c                             |   61 
 drivers/net/3c501.h                             |    4 
 drivers/net/3c503.c                             |   16 
 drivers/net/3c503.h                             |    4 
 drivers/net/3c505.c                             |   24 
 drivers/net/3c505.h                             |    2 
 drivers/net/3c507.c                             |   14 
 drivers/net/3c509.c                             |   53 
 drivers/net/3c515.c                             |   64 
 drivers/net/3c523.c                             |   28 
 drivers/net/3c523.h                             |   14 
 drivers/net/3c527.c                             |  530 
 drivers/net/3c527.h                             |    4 
 drivers/net/3c59x.c                             |   36 
 drivers/net/7990.c                              |   60 
 drivers/net/7990.h                              |   24 
 drivers/net/8139cp.c                            |  122 
 drivers/net/8139too.c                           |   11 
 drivers/net/82596.c                             |   12 
 drivers/net/8390.c                              |  246 
 drivers/net/8390.h                              |    2 
 drivers/net/Kconfig                             |   67 
 drivers/net/Makefile                            |   13 
 drivers/net/Space.c                             |   24 
 drivers/net/a2065.c                             |   40 
 drivers/net/a2065.h                             |    4 
 drivers/net/ac3200.c                            |    6 
 drivers/net/acenic.c                            |   46 
 drivers/net/acenic.h                            |    6 
 drivers/net/acenic_firmware.h                   |18808 ++++++++++++------------
 drivers/net/amd8111e.c                          |  489 
 drivers/net/amd8111e.h                          |  102 
 drivers/net/apne.c                              |   10 
 drivers/net/arcnet/com20020-pci.c               |    2 
 drivers/net/ariadne.c                           |    2 
 drivers/net/arm/Kconfig                         |    7 
 drivers/net/arm/Makefile                        |    1 
 drivers/net/arm/at91_ether.c                    |    2 
 drivers/net/arm/ep93xx_eth.c                    |  944 +
 drivers/net/arm/etherh.c                        |    2 
 drivers/net/at1700.c                            |   30 
 drivers/net/atari_bionet.c                      |   14 
 drivers/net/atari_pamsnet.c                     |    2 
 drivers/net/atarilance.c                        |   22 
 drivers/net/atp.c                               |    2 
 drivers/net/au1000_eth.c                        |   71 
 drivers/net/au1000_eth.h                        |   12 
 drivers/net/b44.c                               |    4 
 drivers/net/bmac.c                              |   54 
 drivers/net/bmac.h                              |    2 
 drivers/net/bnx2.c                              |  166 
 drivers/net/bnx2.h                              |   82 
 drivers/net/bonding/bond_main.c                 |    2 
 drivers/net/bsd_comp.c                          |   68 
 drivers/net/cassini.c                           |  540 
 drivers/net/cassini.h                           |  766 
 drivers/net/chelsio/cxgb2.c                     |    4 
 drivers/net/cris/eth_v10.c                      |    4 
 drivers/net/cs89x0.c                            |   82 
 drivers/net/cs89x0.h                            |    4 
 drivers/net/de600.c                             |    4 
 drivers/net/de620.c                             |   38 
 drivers/net/declance.c                          |    8 
 drivers/net/defxx.c                             |  270 
 drivers/net/defxx.h                             |  192 
 drivers/net/depca.c                             |  110 
 drivers/net/depca.h                             |   28 
 drivers/net/dgrs.c                              |   26 
 drivers/net/dgrs.h                              |    4 
 drivers/net/dgrs_asstruct.h                     |    2 
 drivers/net/dgrs_bcomm.h                        |    2 
 drivers/net/dgrs_ether.h                        |    4 
 drivers/net/dgrs_i82596.h                       |    2 
 drivers/net/dl2k.c                              |  164 
 drivers/net/dl2k.h                              |    6 
 drivers/net/dummy.c                             |   28 
 drivers/net/e100.c                              |   32 
 drivers/net/e1000/e1000.h                       |    6 
 drivers/net/e1000/e1000_ethtool.c               |  279 
 drivers/net/e1000/e1000_hw.c                    | 1167 -
 drivers/net/e1000/e1000_hw.h                    |   26 
 drivers/net/e1000/e1000_main.c                  |  154 
 drivers/net/e1000/e1000_osdep.h                 |   19 
 drivers/net/e1000/e1000_param.c                 |  161 
 drivers/net/e2100.c                             |    4 
 drivers/net/eepro.c                             |    7 
 drivers/net/eepro100.c                          |   40 
 drivers/net/eexpress.c                          |   98 
 drivers/net/eexpress.h                          |   14 
 drivers/net/ehea/Makefile                       |    6 
 drivers/net/ehea/ehea.h                         |  447 
 drivers/net/ehea/ehea_ethtool.c                 |  294 
 drivers/net/ehea/ehea_hcall.h                   |   51 
 drivers/net/ehea/ehea_hw.h                      |  292 
 drivers/net/ehea/ehea_main.c                    | 2654 +++
 drivers/net/ehea/ehea_phyp.c                    |  705 
 drivers/net/ehea/ehea_phyp.h                    |  455 
 drivers/net/ehea/ehea_qmr.c                     |  582 
 drivers/net/ehea/ehea_qmr.h                     |  358 
 drivers/net/epic100.c                           |   11 
 drivers/net/eql.c                               |   32 
 drivers/net/eth16i.c                            |  308 
 drivers/net/ewrk3.c                             |   68 
 drivers/net/ewrk3.h                             |   30 
 drivers/net/fealnx.c                            |   44 
 drivers/net/fec.c                               |   84 
 drivers/net/fec_8xx/fec_main.c                  |   28 
 drivers/net/forcedeth.c                         |  562 
 drivers/net/fs_enet/fs_enet-main.c              |    2 
 drivers/net/gianfar.c                           |   11 
 drivers/net/gianfar.h                           |    2 
 drivers/net/gianfar_ethtool.c                   |   18 
 drivers/net/gianfar_mii.c                       |    4 
 drivers/net/gianfar_mii.h                       |    2 
 drivers/net/gianfar_sysfs.c                     |    2 
 drivers/net/gt64240eth.h                        |    2 
 drivers/net/gt96100eth.c                        | 1566 -
 drivers/net/gt96100eth.h                        |  346 
 drivers/net/hamachi.c                           |  240 
 drivers/net/hp-plus.c                           |    4 
 drivers/net/hp.c                                |    2 
 drivers/net/hp100.c                             |  155 
 drivers/net/hp100.h                             |   44 
 drivers/net/hplance.c                           |   12 
 drivers/net/ibm_emac/ibm_emac_core.c            |    2 
 drivers/net/ibmveth.c                           |    2 
 drivers/net/ifb.c                               |   42 
 drivers/net/ioc3-eth.c                          |    8 
 drivers/net/irda/mcs7780.c                      |    1 
 drivers/net/irda/w83977af_ir.c                  |    1 
 drivers/net/isa-skeleton.c                      |   16 
 drivers/net/iseries_veth.c                      |    2 
 drivers/net/ixgb/ixgb.h                         |    5 
 drivers/net/ixgb/ixgb_ethtool.c                 |    8 
 drivers/net/ixgb/ixgb_hw.c                      |   17 
 drivers/net/ixgb/ixgb_ids.h                     |    1 
 drivers/net/ixgb/ixgb_main.c                    |  152 
 drivers/net/ixgb/ixgb_osdep.h                   |   12 
 drivers/net/jazzsonic.c                         |   12 
 drivers/net/lance.c                             |   38 
 drivers/net/lasi_82596.c                        |   48 
 drivers/net/lne390.c                            |    4 
 drivers/net/loopback.c                          |    6 
 drivers/net/lp486e.c                            |   22 
 drivers/net/mac8390.c                           |   48 
 drivers/net/mac89x0.c                           |   18 
 drivers/net/mace.c                              |   10 
 drivers/net/macmace.c                           |   88 
 drivers/net/macsonic.c                          |   38 
 drivers/net/meth.c                              |   14 
 drivers/net/mii.c                               |   18 
 drivers/net/mv643xx_eth.c                       |    6 
 drivers/net/myri10ge/myri10ge.c                 |  230 
 drivers/net/myri10ge/myri10ge_mcp.h             |   47 
 drivers/net/myri_code.h                         | 9538 ++++++------
 drivers/net/myri_sbus.c                         |   28 
 drivers/net/natsemi.c                           |   41 
 drivers/net/ne-h8300.c                          |    2 
 drivers/net/ne.c                                |    4 
 drivers/net/ne2.c                               |   70 
 drivers/net/ne2k-pci.c                          |   12 
 drivers/net/ne3210.c                            |   16 
 drivers/net/netx-eth.c                          |    1 
 drivers/net/ni5010.c                            |  118 
 drivers/net/ni52.c                              |    2 
 drivers/net/ni52.h                              |   16 
 drivers/net/ni65.c                              |   20 
 drivers/net/ni65.h                              |    6 
 drivers/net/ns83820.c                           |   42 
 drivers/net/oaknet.c                            |   14 
 drivers/net/pci-skeleton.c                      |    9 
 drivers/net/pcmcia/3c574_cs.c                   |    4 
 drivers/net/pcmcia/3c589_cs.c                   |    4 
 drivers/net/pcmcia/axnet_cs.c                   |    7 
 drivers/net/pcmcia/fmvj18x_cs.c                 |    8 
 drivers/net/pcmcia/ibmtr_cs.c                   |    2 
 drivers/net/pcmcia/nmclan_cs.c                  |    4 
 drivers/net/pcmcia/pcnet_cs.c                   |   19 
 drivers/net/pcmcia/smc91c92_cs.c                |    9 
 drivers/net/pcmcia/xirc2ps_cs.c                 |    4 
 drivers/net/pcnet32.c                           |  692 
 drivers/net/phy/fixed.c                         |    4 
 drivers/net/phy/smsc.c                          |    1 
 drivers/net/phy/vitesse.c                       |    1 
 drivers/net/plip.c                              |   42 
 drivers/net/ppp_async.c                         |    6 
 drivers/net/ppp_deflate.c                       |    4 
 drivers/net/ppp_generic.c                       |   16 
 drivers/net/ppp_synctty.c                       |    2 
 drivers/net/pppoe.c                             |   16 
 drivers/net/qla3xxx.c                           | 3537 ++++
 drivers/net/qla3xxx.h                           | 1194 +
 drivers/net/r8169.c                             |  660 
 drivers/net/rionet.c                            |    2 
 drivers/net/rrunner.c                           |   52 
 drivers/net/rrunner.h                           |    8 
 drivers/net/s2io-regs.h                         |    4 
 drivers/net/s2io.c                              |   57 
 drivers/net/s2io.h                              |   10 
 drivers/net/saa9730.c                           |    2 
 drivers/net/saa9730.h                           |   16 
 drivers/net/sb1000.c                            |   24 
 drivers/net/sb1250-mac.c                        |    9 
 drivers/net/seeq8005.c                          |   98 
 drivers/net/seeq8005.h                          |    4 
 drivers/net/sgiseeq.h                           |    4 
 drivers/net/shaper.c                            |  104 
 drivers/net/sis190.c                            |    7 
 drivers/net/sis900.c                            |  227 
 drivers/net/sis900.h                            |   18 
 drivers/net/sk98lin/skethtool.c                 |    2 
 drivers/net/sk98lin/skge.c                      |    4 
 drivers/net/sk_mca.c                            |   18 
 drivers/net/sk_mca.h                            |    4 
 drivers/net/skfp/skfddi.c                       |    2 
 drivers/net/skge.c                              |  206 
 drivers/net/skge.h                              |    1 
 drivers/net/sky2.c                              |  423 
 drivers/net/sky2.h                              |   35 
 drivers/net/slhc.c                              |   34 
 drivers/net/slip.c                              |   32 
 drivers/net/slip.h                              |    4 
 drivers/net/smc-mca.c                           |   10 
 drivers/net/smc-ultra.c                         |    6 
 drivers/net/smc-ultra32.c                       |    6 
 drivers/net/smc911x.c                           |    4 
 drivers/net/smc9194.c                           |    4 
 drivers/net/smc9194.h                           |   72 
 drivers/net/smc91x.c                            |    8 
 drivers/net/sonic.c                             |   22 
 drivers/net/sonic.h                             |    4 
 drivers/net/spider_net.c                        |   10 
 drivers/net/spider_net.h                        |   13 
 drivers/net/spider_net_ethtool.c                |   57 
 drivers/net/starfire.c                          |    8 
 drivers/net/stnic.c                             |    8 
 drivers/net/sun3_82586.c                        |   18 
 drivers/net/sun3_82586.h                        |   18 
 drivers/net/sun3lance.c                         |   74 
 drivers/net/sunbmac.c                           |    2 
 drivers/net/sundance.c                          |   69 
 drivers/net/sungem.c                            |   88 
 drivers/net/sungem.h                            |   12 
 drivers/net/sungem_phy.c                        |   50 
 drivers/net/sungem_phy.h                        |    2 
 drivers/net/sunhme.c                            |   14 
 drivers/net/sunlance.c                          |   60 
 drivers/net/sunqe.c                             |    6 
 drivers/net/tc35815.c                           |   10 
 drivers/net/tg3.c                               |  128 
 drivers/net/tlan.c                              |  344 
 drivers/net/tlan.h                              |   24 
 drivers/net/tokenring/3c359.c                   |    2 
 drivers/net/tokenring/lanstreamer.c             |    2 
 drivers/net/tulip/21142.c                       |    6 
 drivers/net/tulip/de2104x.c                     |   20 
 drivers/net/tulip/de4x5.c                       |    2 
 drivers/net/tulip/dmfe.c                        |    6 
 drivers/net/tulip/eeprom.c                      |    2 
 drivers/net/tulip/interrupt.c                   |    2 
 drivers/net/tulip/media.c                       |    2 
 drivers/net/tulip/pnic.c                        |    2 
 drivers/net/tulip/pnic2.c                       |    2 
 drivers/net/tulip/timer.c                       |   16 
 drivers/net/tulip/tulip.h                       |   36 
 drivers/net/tulip/tulip_core.c                  |  104 
 drivers/net/tulip/uli526x.c                     |   16 
 drivers/net/tulip/winbond-840.c                 |   94 
 drivers/net/tulip/xircom_cb.c                   |    2 
 drivers/net/tulip/xircom_tulip_cb.c             |    6 
 drivers/net/tun.c                               |   58 
 drivers/net/typhoon-firmware.h                  | 7488 ++++-----
 drivers/net/typhoon.c                           |   20 
 drivers/net/typhoon.h                           |    4 
 drivers/net/ucc_geth.c                          |   19 
 drivers/net/via-rhine.c                         |   13 
 drivers/net/via-velocity.c                      |  228 
 drivers/net/via-velocity.h                      |   23 
 drivers/net/wan/cycx_main.c                     |    1 
 drivers/net/wan/dlci.c                          |    1 
 drivers/net/wan/dscc4.c                         |    2 
 drivers/net/wan/farsync.c                       |    2 
 drivers/net/wan/lmc/lmc_main.c                  |    2 
 drivers/net/wan/pc300_drv.c                     |    2 
 drivers/net/wan/pci200syn.c                     |    2 
 drivers/net/wan/sdla.c                          |    1 
 drivers/net/wan/wanxl.c                         |    2 
 drivers/net/wd.c                                |   12 
 drivers/net/wireless/Kconfig                    |   23 
 drivers/net/wireless/airo.c                     |   52 
 drivers/net/wireless/atmel_pci.c                |    2 
 drivers/net/wireless/bcm43xx/bcm43xx.h          |  181 
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c  |   80 
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.h  |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c      |  583 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h      |  296 
 drivers/net/wireless/bcm43xx/bcm43xx_ethtool.c  |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_ethtool.h  |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_leds.c     |   10 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c     |  900 -
 drivers/net/wireless/bcm43xx/bcm43xx_main.h     |    6 
 drivers/net/wireless/bcm43xx/bcm43xx_phy.c      |   33 
 drivers/net/wireless/bcm43xx/bcm43xx_pio.c      |    4 
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c    |  178 
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c       |  166 
 drivers/net/wireless/bcm43xx/bcm43xx_xmit.c     |    5 
 drivers/net/wireless/hostap/hostap.h            |    2 
 drivers/net/wireless/hostap/hostap_cs.c         |    1 
 drivers/net/wireless/hostap/hostap_ioctl.c      |    2 
 drivers/net/wireless/ipw2100.c                  |    9 
 drivers/net/wireless/ipw2200.c                  |  248 
 drivers/net/wireless/ipw2200.h                  |   51 
 drivers/net/wireless/orinoco.c                  |    5 
 drivers/net/wireless/orinoco.h                  |    8 
 drivers/net/wireless/orinoco_nortel.c           |    2 
 drivers/net/wireless/orinoco_pci.c              |    2 
 drivers/net/wireless/orinoco_plx.c              |    2 
 drivers/net/wireless/orinoco_tmd.c              |    2 
 drivers/net/wireless/prism54/isl_ioctl.c        |  597 
 drivers/net/wireless/prism54/isl_ioctl.h        |    6 
 drivers/net/wireless/prism54/islpci_dev.c       |    4 
 drivers/net/wireless/prism54/islpci_dev.h       |    2 
 drivers/net/wireless/prism54/islpci_hotplug.c   |    2 
 drivers/net/wireless/ray_cs.c                   |    6 
 drivers/net/wireless/wavelan_cs.c               |    2 
 drivers/net/wireless/wl3501_cs.c                |    2 
 drivers/net/wireless/zd1211rw/Makefile          |    1 
 drivers/net/wireless/zd1211rw/zd_chip.c         |   62 
 drivers/net/wireless/zd1211rw/zd_chip.h         |   15 
 drivers/net/wireless/zd1211rw/zd_def.h          |    6 
 drivers/net/wireless/zd1211rw/zd_ieee80211.h    |    2 
 drivers/net/wireless/zd1211rw/zd_mac.c          |    8 
 drivers/net/wireless/zd1211rw/zd_mac.h          |    6 
 drivers/net/wireless/zd1211rw/zd_netdev.c       |   17 
 drivers/net/wireless/zd1211rw/zd_rf.c           |    7 
 drivers/net/wireless/zd1211rw/zd_rf.h           |    1 
 drivers/net/wireless/zd1211rw/zd_rf_al2230.c    |  155 
 drivers/net/wireless/zd1211rw/zd_rf_al7230b.c   |  274 
 drivers/net/wireless/zd1211rw/zd_usb.c          |  124 
 drivers/net/wireless/zd1211rw/zd_usb.h          |   15 
 drivers/net/yellowfin.c                         |   56 
 drivers/net/znet.c                              |   72 
 include/asm-arm/arch-ep93xx/ep93xx-regs.h       |    1 
 include/asm-arm/arch-ep93xx/platform.h          |    6 
 include/linux/netdevice.h                       |    2 
 include/net/ieee80211.h                         |    9 
 include/net/ieee80211softmac.h                  |   60 
 net/core/ethtool.c                              |   14 
 net/ieee80211/ieee80211_crypt_ccmp.c            |   23 
 net/ieee80211/ieee80211_crypt_tkip.c            |  114 
 net/ieee80211/ieee80211_crypt_wep.c             |   38 
 net/ieee80211/ieee80211_rx.c                    |   56 
 net/ieee80211/ieee80211_tx.c                    |    9 
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |   21 
 net/ieee80211/softmac/ieee80211softmac_io.c     |   14 
 net/ieee80211/softmac/ieee80211softmac_module.c |   90 
 net/ieee80211/softmac/ieee80211softmac_priv.h   |    8 
 360 files changed, 40596 insertions(+), 28263 deletions(-)

Adrian Bunk:
      make drivers/net/e1000/e1000_hw.c:e1000_phy_igp_get_info() static

Alan Cox:
      gt96100: move to pci_get_device API
      s2io: Switch to pci_get_device

Andy Gospodarek:
      cleanup unnecessary forcedeth printk
      Remove more unnecessary driver printk's

Arjan van de Ven:
      resend of 8390 patch for lockdep

Auke Kok:
      e100: increment version to 3.5.10-k4
      e1000: Same cosmetic fix as earlier sent out for IPV4.
      e1000: Increment driver version to 7.1.9-k6
      ixgb: Increment version to 1.0.109-k4
      e1000: Whitespace cleanup, cosmetic changes
      e1000: error out if we cannot enable PCI device on resume
      e1000: remove unused part_num reading code
      e1000: Use module param array code
      e1000: Increment driver version to 7.2.7-k2
      e100: Convert e100 to use netdev_alloc_skb().
      e100: remove skb->dev assignment
      e100: increment version to 3.5.16-k2
      ixgb: Convert dev_alloc_skb to netdev_alloc_skb.
      ixgb: convert dev->priv to netdev_priv(dev).
      ixgb: recalculate after how many descriptors to wake the queue
      ixgb: remove skb->dev assignment
      ixgb: Increment version to 1.0.112-k2

Auke-Jan H Kok:
      e1000: revert 'e1000: Remove 0x1000 as supported device'

Ayaz Abdulla:
      forcedeth: move mac address setup/teardown
      forcedeth: mac address corrected
      forcedeth: errata for marvell phys
      forcedeth: decouple vlan and rx checksum dependency

Brice Goglin:
      myri10ge: define some previously hardwired firmware constants
      myri10ge: convert to netdev_alloc_skb
      myri10ge: use netif_msg_link
      myri10ge: use multicast support in the firmware
      myri10ge: improve firmware selection

Christian Steineck:
      hostap_cs: added support for Proxim Harmony PCI W-Lan card

Christoph Hellwig:
      e1000: clean up skb allocation code

Dale Farnsworth:
      mv643xx_eth: restrict to 32-bit PPC_MULTIPLATFORM

Dan Williams:
      prism54: update to WE-19 for WPA support

Daniel Drake:
      zd1211rw: Add Sagem device ID's
      zd1211rw: Implement SIOCGIWNICKN
      Add zd1211rw MAINTAINERS entry
      ieee80211: small ERP handling additions
      softmac: ERP handling and driver-level notifications
      softmac: export highest_supported_rate function
      ieee80211: Make ieee80211_rx_any usable
      softmac: Add MAINTAINERS entry
      zd1211rw: ZD1211B ASIC/FWT, not jointly decoder
      zd1211rw: Match vendor driver IFS values
      zd1211rw: AL2230 ZD1211B vendor sync
      zd1211rw: Support AL7230B RF
      zd1211rw: Add ID for Senao NUB-8301
      zd1211rw: Add ID for Allnet ALLSPOT Hotspot finder
      zd1211rw: Firmware version vs bootcode version mismatch handling
      zd1211rw: Add ID for ZyXEL G220F
      zd1211rw: Convert installer CDROM device into WLAN device
      zd1211rw: Add ID for Siemens Gigaset USB Stick 54
      zd1211rw: Add ID for Asus WL-159g

Daniele Venzano:
      Add new PHY to sis900 supported list

Dave Jones:
      remove unnecessary config.h includes from drivers/net/

Don Fry:
      pcnet32: remove unnecessary save/restore register accesses.
      pcnet32: magic number cleanup
      pcnet32: move/create receive and transmit routines
      pcnet32: break receive routine into two pieces.
      pcnet32: NAPI implementation

Francois Romieu:
      r8169: mac address change support
      r8169: RX fifo overflow recovery
      r8169: hardware flow control
      r8169: remove rtl8169_init_board
      r8169: sync with vendor's driver
      r8169: use NETDEV_TX_{BUSY/OK}
      r8169: udelay() removal
      r8169: trim trailing whitespaces and convert whitespaces to tabs
      r8169: use standard #defines from mii.h instead of declaring private ones
      r8169: add basic MII ioctl support
      r8169: the 0x8136 needs a 8 bytes alignment
      8139cp: trim ring_info
      8139cp: remove gratuitous indirection
      8139cp: ring_info removal for the receive path
      8139cp: sync the device private data with its r8169 counterpart
      8139cp: removal of useless BUG_ON() check
      8139cp: use PCI_DEVICE() to shorten the PCI device table
      Defer tulip_select_media() to process context
      r8169: quirk for the 8110sb on arm platform
      8139cp: ring_info removal for the transmit path
      r8169: the MMIO region of the 8167 stands behin BAR#1

François Romieu:
      8139cp: pci_get_drvdata(pdev) can not be NULL in suspend handler

Grant Grundler:
      Print physical address in tulip_init_one
      Flush MMIO writes in reset sequence
      Clean up tulip.h
      Use tulip.h in winbond-840.c

Henrik Kretzschmar:
      initialisation cleanup for ULI526x-net-driver
      remove an unused function from the header

Jan-Bernd Themann:
      ehea: IBM eHEA Ethernet Device Driver
      ehea: bugfix for register access functions

Jean Tourrilhes:
      Prism54 : add bitrates to scan result

Jeff Garzik:
      drivers/net: Remove deprecated use of pci_module_init()
      drivers/net: Trim trailing whitespace
      drivers/net: const-ify ethtool_ops declarations
      drivers/net/phy/fixed: #if 0 some incomplete code
      e1000, ixgb: Remove pointless wrappers
      net/ieee80211: fix more crypto-related build breakage

Jeff Kirsher:
      e100: Fix MDIO/MDIO-X
      e1000: Remove 0x1000 as supported device
      e1000: Allow NVM to setup LPLU for IGP2 and IGP3
      e1000: Force full DMA clocking for 10/100 speed
      e1000: Disable aggressive clocking on esb2 with SERDES port

Jesse Brandeburg:
      e1000: Explicitly power up the PHY during loopback testing.
      e1000: explicit locking for two ethtool path functions
      ixgb: fix cache miss due to miscalculation
      e1000: unify WoL capability detection code
      e1000: Add PCI ID 0x10a4 for our new 4-port PCI-Express device
      ixgb: Set a constant blink rate for ixgb adapter identify (1sec on, 1sec off)
      ixgb: Cache-align all TX components of the adapter struct.
      ixgb: Add buffer_info and test like e1000 has.

Jim Lewis:
      Spidernet: add ethtool -S (show statistics)

John W. Linville:
      bcm43xx: fix-up build breakage from merging patches out of order
      bcm43xx: reduce mac_suspend delay loop count

Komuro:
      network: pcnet_cs.c: remove unnecessary 'mdio_reset'
      network: axnet_cs.c: add new id (0x021b, 0x0202)

Larry Finger:
      bcm43xx: improved statistics
      bcm43xx: improved statistics
      bcm43xx: add missing mac_suspended initialization
      bcm43xx: optimization of DMA bitfields
      bcm43xx: return correct hard_start_xmit error code
      bcm43xx - set correct value in mac_suspended for ifdown/ifup sequence
      bcm43xx: Set floor of wireless signal and noise at -110 dBm
      bcm43xx-softmac: Init, shutdown and restart fixes
      bcm43xx: Correct out of sequence initialization step
      bcm43xx: remove dead statistics code
      bcm43xx: Add firmware version printout
      bcm43xx: ucode debug status via sysfs
      bcm43xx: remove dead code in bcm43xx_sysfs.c

Lennert Buytenhek:
      Cirrus Logic ep93xx ethernet driver

Linas Vepstas:
      e100: fix error recovery
      ixgb: Add PCI Error recovery callbacks
      e1000 disable device on PCI error

Manasi Deval:
      ixgb: Add CX4 PHY type detection and subdevice ID.

Michael Buesch:
      bcm43xx: opencoded locking
      bcm43xx: voluntary preemtion in the calibration loops
      bcm43xx: suspend MAC while executing long pwork
      bcm43xx: lower mac_suspend udelay
      bcm43xx: fix mac_suspend refcount
      bcm43xx: init routine rewrite
      bcm43xx: >1G and 64bit DMA support
      bcm43xx: re-add bcm43xx_rng_init() call
      MAINTAINERS: Add Larry Finger for bcm43xx (softmac)

Michael Wu:
      ray_cs: Remove dependency on ieee80211

Pavel Machek:
      cleanup // comments from ipw2200

Pavel Roskin:
      orinoco: Don't use "extern inline" on locking functions
      orinoco: include linux/if_arp.h directly

Philippe De Muyter:
      sundance: small cleanup

Ralf Baechle:
      Cleanup SLHC configuration
      Convert to kzalloc
      Remove useless casts
      Remove useless #ifdef MODULE stuff and printout
      [NET] GT96100: Delete bitrotting ethernet driver

Robert Schulze:
      airo: collapse debugging-messages in issuecommand to one line

Ron Mercer:
      qla3xxx NIC driver

shemminger@osdl.org:
      sky2: remove cloned/pskb_expand_head check
      sky2: use netdev_alloc_skb
      sky2: dont use force status bit
      sky2: MSI test timing
      sky2: TSO mss optimization
      sky2: optimize checksum offload information
      sky2: power down PHY when not up
      sky2: pci post bug
      sky2: version 1.7

Stephen Hemminger:
      sky2: add another PCI ID
      forcedeth: coding style cleanups
      forcedeth: le32 annotation
      sky2: more pci device ids
      sky2: status interrupt handling improvement
      forcdeth: revised NAPI support
      skge: cleanup suspend/resume code
      skge: pci bus post fixes
      skge: use dev_alloc_skb
      skge: use ethX for irq assigments
      skge: version 1.7
      sky2: more pci device id's
      skge: use netdev_alloc_skb
      skge: irq lock race
      skge: use NAPI for transmit complete
      skge: version 1.8
      skge: check for PCI hotplug during IRQ
      sky2: tx pause bug fix
      sky2: fiber support
      sky2: big endian
      ethtool: allow const ethtool_ops

Stephen Rothwell:
      Remove powerpc specific parts of 3c509 driver

Sukadev Bhattiprolu:
      kthread: airo.c

Thibaut Varene:
      Make DS21143 printout match lspci output

Ulrich Kunitz:
      zd1211rw: USB id 1582:6003 for Longshine 8131G3 added
      zd1211rw: cleanups
      zd1211rw: Removed unneeded packed attributes

Valerie Henson:
      Change tulip maintainer
      Handle pci_enable_device() errors in resume

Vasily Averin:
      e1000: IRQ resources cleanup
      e1000: e1000_probe resources cleanup
      e1000: ring buffers resources cleanup

Zhu Yi:
      ieee80211: Fix header->qos_ctl endian issue
      ieee80211: remove ieee80211_tx() is_queue_full warning
      ieee80211: TKIP and CCMP replay check rework
      ieee80211: Fix TKIP and WEP decryption error on SMP machines
      ieee80211: Workaround malformed 802.11 frames from AP
      ipw2200: always enable frequently used debugging code
      ipw2200: SIOCGIWFREQ ioctl returns frequency rather than channel
      ipw2200: ipw_wx_set_essid fix
      ipw2200: Reassociate even if set the same essid.
      ipw2200: remove unused struct ipw_rx_buffer
      ipw2200: Fix ipw2200 QOS parameters endian issue
      ipw2200: remove the MAC timestamp present field from radiotap head
      ipw2200: mark "iwconfig retry 255" as invalid
      ipw2200: Fix kernel Oops if cmdlog debug is enabled
      ipw2200: Add pci .shutdown handler
      ipw2100: Fix deadlock detected by lockdep
      ipw2200: enable wireless extension passive scan
      ipw2200: Update version stamp to 1.1.4
      ipw2200: Fix compile error when CONFIG_IPW2200_DEBUG is not selected

