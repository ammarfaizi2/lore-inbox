Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTD1Enr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 00:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTD1Enr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 00:43:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39913 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263434AbTD1Eno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 00:43:44 -0400
Message-ID: <3EACB453.90309@pobox.com>
Date: Mon, 28 Apr 2003 00:55:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] net driver merges
Content-Type: multipart/mixed;
 boundary="------------040104090202090607010100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104090202090607010100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

main things are more of Andrew's irqreturn_t stuff, and a driver for 
Intel's 10gige hardware.

--------------040104090202090607010100
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 Documentation/networking/ixgb.txt     |  226 ++
 MAINTAINERS                           |    7 
 drivers/net/3c523.c                   |   12 
 drivers/net/3c527.c                   |    8 
 drivers/net/68360enet.c               |    8 
 drivers/net/7990.c                    |    6 
 drivers/net/8139cp.c                  |    7 
 drivers/net/Kconfig                   |   48 
 drivers/net/Makefile                  |    1 
 drivers/net/a2065.c                   |    7 
 drivers/net/am79c961a.c               |   19 
 drivers/net/appletalk/cops.c          |    6 
 drivers/net/appletalk/ltpc.c          |    7 
 drivers/net/ariadne.c                 |   25 
 drivers/net/atarilance.c              |    9 
 drivers/net/au1000_eth.c              |    7 
 drivers/net/bagetlance.c              |   10 
 drivers/net/declance.c                |    4 
 drivers/net/e1000/e1000.h             |    2 
 drivers/net/e1000/e1000_main.c        |   12 
 drivers/net/eth16i.c                  |   10 
 drivers/net/ewrk3.c                   |    5 
 drivers/net/gt96100eth.c              |   14 
 drivers/net/hamradio/baycom_ser_fdx.c |    7 
 drivers/net/hamradio/baycom_ser_hdx.c |    7 
 drivers/net/hamradio/dmascc.c         |    5 
 drivers/net/hamradio/yam.c            |    3 
 drivers/net/ibmlana.c                 |    5 
 drivers/net/ioc3-eth.c                |    3 
 drivers/net/isa-skeleton.c            |   11 
 drivers/net/ixgb/Makefile             |   35 
 drivers/net/ixgb/ixgb.h               |  331 ++-
 drivers/net/ixgb/ixgb_ee.c            | 1521 ++++++++++++-----
 drivers/net/ixgb/ixgb_ee.h            |  212 +-
 drivers/net/ixgb/ixgb_ethtool.c       | 1405 +++++++++++----
 drivers/net/ixgb/ixgb_hw.c            | 2583 ++++++++++++++++++++---------
 drivers/net/ixgb/ixgb_hw.h            | 1387 +++++++++++----
 drivers/net/ixgb/ixgb_ids.h           |   52 
 drivers/net/ixgb/ixgb_main.c          | 2992 ++++++++++++++++++++++++++++++----
 drivers/net/ixgb/ixgb_osdep.h         |  104 +
 drivers/net/ixgb/ixgb_param.c         |  598 ++++++
 drivers/net/lasi_82596.c              |   10 
 drivers/net/mac89x0.c                 |    8 
 drivers/net/pci-skeleton.c            |    7 
 drivers/net/pcmcia/3c574_cs.c         |   52 
 drivers/net/pcmcia/3c589_cs.c         |   34 
 drivers/net/pcmcia/axnet_cs.c         |   27 
 drivers/net/pcmcia/com20020_cs.c      |   29 
 drivers/net/pcmcia/fmvj18x_cs.c       |   27 
 drivers/net/pcmcia/ibmtr_cs.c         |   27 
 drivers/net/pcmcia/nmclan_cs.c        |   30 
 drivers/net/pcmcia/smc91c92_cs.c      |   28 
 drivers/net/pcmcia/xirc2ps_cs.c       |   39 
 drivers/net/rrunner.c                 |    5 
 drivers/net/rrunner.h                 |    5 
 drivers/net/saa9730.c                 |    4 
 drivers/net/sb1000.c                  |   10 
 drivers/net/sb1250-mac.c              |   12 
 drivers/net/sgiseeq.c                 |    3 
 drivers/net/sk_g16.c                  |    5 
 drivers/net/sk_mca.c                  |    5 
 drivers/net/skfp/skfddi.c             |   12 
 drivers/net/sonic.c                   |    5 
 drivers/net/sonic.h                   |    2 
 drivers/net/sun3_82586.c              |    7 
 drivers/net/tc35815.c                 |   10 
 drivers/net/tokenring/3c359.c         |   15 
 drivers/net/tokenring/ibmtr.c         |   13 
 drivers/net/tokenring/madgemc.c       |   12 
 drivers/net/tokenring/olympic.c       |   13 
 drivers/net/tokenring/smctr.c         |   12 
 drivers/net/wan/comx-hw-comx.c        |    7 
 drivers/net/wan/comx-hw-mixcom.c      |    6 
 drivers/net/wan/comx-hw-munich.c      |    4 
 drivers/net/wan/cosa.c                |    5 
 drivers/net/wan/cycx_main.c           |    7 
 drivers/net/wan/dscc4.c               |   11 
 drivers/net/wan/farsync.c             |    3 
 drivers/net/wan/pc300_drv.c           |    9 
 drivers/net/wan/sbni.c                |    5 
 drivers/net/wan/sdla.c                |    7 
 drivers/net/wan/sdlamain.c            |   21 
 drivers/pci/pci.ids                   |    3 
 83 files changed, 9449 insertions(+), 2828 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/04/28 1.1141)
   [netdrvr ixgb] more cleanups
   
   - support new 2.5 irqreturn_t
   - s/usec_delay/udelay/
   - remove two stored-but-never-used members of struct ixgb_hw
   - read PCI vendor/device ids from struct pci_dev, not h/w
   - remove some unused wrappers from ixgb_osdep.h

<jgarzik@redhat.com> (03/04/28 1.1140)
   [netdrvr ixgb] use standard kernel u8/u16/u32 types

<jgarzik@redhat.com> (03/04/28 1.1139)
   [netdrvr ixgb] Lindent, then fix up obvious indent uglies by hand

<ganesh.venkatesan@intel.com> (03/04/28 1.1138)
   [netdrvr ixgb] add new driver for Intel's 10 gig ethernet

<scott.feldman@intel.com> (03/04/27 1.1137)
   [netdrvr e1000] add a bit of source cross-version compat
   
   * Wrap TSO support with NETIF_F_TSO to keep same driver
     source between 2.4 and 2.5.
   

<scott.feldman@intel.com> (03/04/27 1.1136)
   [netdrvr e1000] mark e1000 NAPI feature not-experimental

<akpm@digeo.com> (03/04/27 1.1122.1.4)
   net driver cleanup, volume 7
   
   100% irqreturn_t cleanups
   
   Affected drivers: 3c523, 527, 68360enet, 7990, a2065, am79c961a,
   appletalk/{ltpc,cops}, ariadne, {lotsa}lance, au1000_eth, eth16i,
   ewrk3, gt96100eth, hamradio/several, ibmlana, ioc3-eth, *-skeleton,
   lasi_82596, mac89x0, pcmcia/3c574_cs, rrunner, sb1000, sb1250-mac,
   sgiseeq, sk_g16, sk_mca, skfddi, sonic, sun3_82586, tc35815,
   tokenring/several, wan/several

<romieu@fr.zoreil.com> (03/04/27 1.1122.1.3)
   [wan dscc4] irqreturn_t update

<hch@lst.de> (03/04/27 1.1122.1.2)
   [netdrvr pcmcia] switch drivers to using pcmcia_register_driver
   
   Affected drivers: 3c574_cs, 3c589_cs, axnet_cs, com20020_cs,
   fmvj18x_cs, ibmtr_cs, nmclan_cs, smc91c92_cs, xir2ps_cs

<anton@samba.org> (03/04/27 1.1122.1.1)
   [netdrvr 8139cp] enable MWI via pci_set_mwi, rather than manually


--------------040104090202090607010100--

