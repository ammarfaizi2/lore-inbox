Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTKVSb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 13:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKVSb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 13:31:27 -0500
Received: from havoc.gtf.org ([63.247.75.124]:4573 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262608AbTKVSaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 13:30:02 -0500
Date: Sat, 22 Nov 2003 13:30:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x experimental net driver queue
Message-ID: <20031122183001.GA16993@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent changes:
* Most netdev alloc work from Al
* 8139too stuff from shemminger and Hirofumi
* r8169 stuff from Francois
* m68k fixes from Geert

BK users:

	bk pull bk://gkernel.bkbits.net/net-drivers-2.5-exp

Patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test9-bk25-netdrvr-exp1.patch.bz2

This will update the following files:

 Documentation/networking/8139too.txt    |  438 --------------
 drivers/net/68360enet.c                 |  951 --------------------------------
 Documentation/SubmittingPatches         |    4 
 Documentation/networking/netconsole.txt |   57 +
 drivers/char/synclink.c                 |   43 -
 drivers/net/3c501.c                     |  116 +--
 drivers/net/3c501.h                     |    1 
 drivers/net/3c503.c                     |  117 ++-
 drivers/net/3c505.c                     |  128 ++--
 drivers/net/3c507.c                     |  120 ++--
 drivers/net/3c515.c                     |  328 ++++-------
 drivers/net/3c523.c                     |  108 +--
 drivers/net/3c527.c                     |  682 ++++++++++------------
 drivers/net/3c527.h                     |    6 
 drivers/net/3c59x.c                     |   17 
 drivers/net/8139too.c                   |  405 ++++++++-----
 drivers/net/82596.c                     |   83 +-
 drivers/net/Kconfig                     |   27 
 drivers/net/Makefile                    |    2 
 drivers/net/Space.c                     |  587 +++++++++----------
 drivers/net/a2065.c                     |   21 
 drivers/net/ac3200.c                    |   91 ++-
 drivers/net/amd8111e.c                  |   14 
 drivers/net/apne.c                      |   81 +-
 drivers/net/appletalk/ipddp.c           |   62 +-
 drivers/net/appletalk/ltpc.c            |    2 
 drivers/net/arcnet/arc-rimi.c           |  131 +---
 drivers/net/arcnet/arcnet.c             |    6 
 drivers/net/arcnet/com20020-isa.c       |   84 +-
 drivers/net/arcnet/com20020-pci.c       |   54 -
 drivers/net/arcnet/com20020.c           |   16 
 drivers/net/arcnet/com90io.c            |  126 +---
 drivers/net/arcnet/com90xx.c            |  238 +++-----
 drivers/net/ariadne.c                   |   10 
 drivers/net/arm/am79c961a.c             |    2 
 drivers/net/arm/ether00.c               |    4 
 drivers/net/arm/ether1.c                |    2 
 drivers/net/arm/ether3.c                |    2 
 drivers/net/arm/etherh.c                |    2 
 drivers/net/at1700.c                    |  166 ++---
 drivers/net/atari_bionet.c              |   62 +-
 drivers/net/atari_pamsnet.c             |   67 +-
 drivers/net/atarilance.c                |   58 +
 drivers/net/atp.c                       |   40 -
 drivers/net/au1000_eth.c                |   61 --
 drivers/net/bagetlance.c                |   77 +-
 drivers/net/cs89x0.c                    |  132 ++--
 drivers/net/de600.c                     |   59 +
 drivers/net/de600.h                     |    1 
 drivers/net/de620.c                     |   63 +-
 drivers/net/declance.c                  |   17 
 drivers/net/defxx.c                     |    2 
 drivers/net/depca.c                     |   20 
 drivers/net/dummy.c                     |    2 
 drivers/net/e100/e100_config.c          |    8 
 drivers/net/e100/e100_main.c            |   41 -
 drivers/net/e100/e100_phy.c             |   14 
 drivers/net/e1000/e1000.h               |   10 
 drivers/net/e1000/e1000_ethtool.c       |   94 ++-
 drivers/net/e1000/e1000_hw.c            |   65 +-
 drivers/net/e1000/e1000_hw.h            |    9 
 drivers/net/e1000/e1000_main.c          |  143 ++--
 drivers/net/e1000/e1000_param.c         |   45 -
 drivers/net/e2100.c                     |   88 ++
 drivers/net/eepro.c                     |  256 ++++----
 drivers/net/eepro100.c                  |   21 
 drivers/net/eexpress.c                  |   91 ++-
 drivers/net/eql.c                       |    2 
 drivers/net/es3210.c                    |   87 ++
 drivers/net/eth16i.c                    |  119 ++--
 drivers/net/ethertap.c                  |    3 
 drivers/net/ewrk3.c                     |  684 +++++++++--------------
 drivers/net/fc/iph5526.c                |    3 
 drivers/net/fc/iph5526_scsi.h           |    2 
 drivers/net/fmv18x.c                    |  111 ++-
 drivers/net/gt96100eth.c                |   49 -
 drivers/net/hamradio/baycom_epp.c       |    2 
 drivers/net/hamradio/bpqether.c         |    2 
 drivers/net/hamradio/hdlcdrv.c          |    2 
 drivers/net/hamradio/yam.c              |    2 
 drivers/net/hp-plus.c                   |   84 ++
 drivers/net/hp.c                        |   84 ++
 drivers/net/hp100.c                     |  743 +++++++++++++------------
 drivers/net/hplance.c                   |   85 +-
 drivers/net/hydra.c                     |   19 
 drivers/net/jazzsonic.c                 |   88 ++
 drivers/net/lance.c                     |  129 ++--
 drivers/net/lasi_82596.c                |   17 
 drivers/net/lne390.c                    |   88 ++
 drivers/net/mac8390.c                   |  103 ++-
 drivers/net/mac89x0.c                   |   77 +-
 drivers/net/mace.c                      |   50 +
 drivers/net/macmace.c                   |   30 -
 drivers/net/macsonic.c                  |  103 +--
 drivers/net/meth.c                      |   83 +-
 drivers/net/mvme147.c                   |   64 +-
 drivers/net/natsemi.c                   |   39 -
 drivers/net/ne.c                        |   83 ++
 drivers/net/ne2.c                       |   82 ++
 drivers/net/ne2k-pci.c                  |    3 
 drivers/net/ne2k_cbus.c                 |  107 ++-
 drivers/net/ne2k_cbus.h                 |    2 
 drivers/net/ne3210.c                    |   18 
 drivers/net/netconsole.c                |  120 ++++
 drivers/net/ni5010.c                    |  184 +++---
 drivers/net/ni52.c                      |  118 ++-
 drivers/net/ni65.c                      |  101 ++-
 drivers/net/ns83820.c                   |    2 
 drivers/net/oaknet.c                    |   61 --
 drivers/net/pci-skeleton.c              |    2 
 drivers/net/pcmcia/3c574_cs.c           |    7 
 drivers/net/pcmcia/3c589_cs.c           |    7 
 drivers/net/pcmcia/com20020_cs.c        |   32 -
 drivers/net/pcmcia/fmvj18x_cs.c         |    7 
 drivers/net/pcmcia/nmclan_cs.c          |    7 
 drivers/net/pcmcia/smc91c92_cs.c        |    7 
 drivers/net/pcmcia/xirc2ps_cs.c         |    7 
 drivers/net/pcnet32.c                   |   11 
 drivers/net/plip.c                      |   18 
 drivers/net/ppp_generic.c               |   67 +-
 drivers/net/r8169.c                     |  448 ++++++++++-----
 drivers/net/saa9730.c                   |   63 +-
 drivers/net/sb1250-mac.c                |   49 -
 drivers/net/seeq8005.c                  |   97 +--
 drivers/net/sgiseeq.c                   |   29 
 drivers/net/shaper.c                    |   11 
 drivers/net/sk_g16.c                    |  182 ++----
 drivers/net/sk_mca.c                    |  119 +---
 drivers/net/sk_mca.h                    |    3 
 drivers/net/skfp/skfddi.c               |   32 -
 drivers/net/smc-ultra.c                 |   96 ++-
 drivers/net/smc-ultra32.c               |   85 +-
 drivers/net/smc9194.c                   |  110 +--
 drivers/net/stnic.c                     |   42 -
 drivers/net/sun3_82586.c                |   81 +-
 drivers/net/sun3lance.c                 |   85 +-
 drivers/net/tc35815.c                   |  194 ++----
 drivers/net/tg3.c                       |   16 
 drivers/net/tokenring/3c359.c           |    4 
 drivers/net/tokenring/abyss.c           |    2 
 drivers/net/tokenring/madgemc.c         |    6 
 drivers/net/tokenring/proteon.c         |  184 ++----
 drivers/net/tokenring/skisa.c           |  182 ++----
 drivers/net/tokenring/smctr.c           |  194 +++---
 drivers/net/tokenring/tmspci.c          |    2 
 drivers/net/tulip/Kconfig               |   20 
 drivers/net/tulip/de2104x.c             |    2 
 drivers/net/tulip/dmfe.c                |    2 
 drivers/net/tulip/interrupt.c           |  417 ++++++++++----
 drivers/net/tulip/tulip.h               |   18 
 drivers/net/tulip/tulip_core.c          |   78 +-
 drivers/net/tulip/winbond-840.c         |    2 
 drivers/net/tulip/xircom_tulip_cb.c     |    3 
 drivers/net/tun.c                       |   18 
 drivers/net/wan/cosa.c                  |   37 -
 drivers/net/wan/lmc/lmc_main.c          |  375 ++++--------
 drivers/net/wan/lmc/lmc_var.h           |   15 
 drivers/net/wan/x25_asy.c               |    2 
 drivers/net/wd.c                        |   89 ++
 drivers/net/wireless/arlan-main.c       |  283 +++------
 drivers/net/wireless/arlan.h            |    6 
 drivers/net/wireless/atmel.c            |    2 
 drivers/net/wireless/ray_cs.c           |   17 
 drivers/net/wireless/strip.c            |    2 
 drivers/net/wireless/wavelan.c          |  251 +++-----
 drivers/net/wireless/wavelan.p.h        |   58 -
 drivers/net/wireless/wavelan_cs.c       |  113 +--
 drivers/net/wireless/wavelan_cs.p.h     |   49 -
 drivers/net/znet.c                      |   36 -
 drivers/net/zorro8390.c                 |   19 
 drivers/s390/net/qeth.c                 |   18 
 drivers/usb/gadget/ether.c              |    2 
 include/linux/arcdevice.h               |    1 
 include/linux/com20020.h                |    1 
 include/linux/netdevice.h               |   18 
 include/linux/netpoll.h                 |   38 +
 include/linux/pci_ids.h                 |    2 
 net/Kconfig                             |   20 
 net/core/Makefile                       |    1 
 net/core/dev.c                          |   39 +
 net/core/netpoll.c                      |  646 +++++++++++++++++++++
 net/wanrouter/wanmain.c                 |    2 
 182 files changed, 8127 insertions(+), 7778 deletions(-)

through these ChangeSets:

<geert@linux-m68k.org> (03/11/22 1.1500)
   [PATCH] 2.6.x experimental net driver queue fix
   
   On Wed, 19 Nov 2003, Sam Creasey wrote:
   > On Tue, 18 Nov 2003, Geert Uytterhoeven wrote:
   > > On Mon, 17 Nov 2003, Geert Uytterhoeven wrote:
   > > > On Sun, 16 Nov 2003, Jeff Garzik wrote:
   > > > > Yet more updates.  Syncing with Andrew Morton, and more syncing with Al
   > > > > Viro.
   > > > >
   > > > > No users of init_etherdev remain in the tree.  (yay!)
   > > >
   > > > Here are some (untested, except for cross-gcc) fixes for the m68k-related
   > > > drivers:
   > >
   > > I forget to test the Sun-3 drivers:
   > >   - sun3_82586.c:
   > >       o add missing casts to iounmap() calls
   > >       o fix parameter of free_netdev()
   > >   - sun3lance.c: add missing casts to iounmap() calls
   > >
   > > Note that sun3_82586.c no longer compiles since SUN3_82586_TOTAL_SIZE is not
   > > defined. Sammy, is it OK to use PAGE_SIZE for that, since that's what's passed
   > > to ioremap()?
   >
   > Should be...  I looked back through a few versions of the code, and I'm
   > not even sure what SUN3_82586_TOTAL_SIZE even was (appears I commented
   > that line out long ago anyway).  (I'm also amazed just how much of that
   > driver I've forgotten in the last year or two :)
   
   OK, so here's a additional patch that fixes that:

<hirofumi@mail.parknet.co.jp> (03/11/22 1.1499)
   [PATCH] 8139too NAPI for net-drivers-2.5-exp
   
   Jeff Garzik <jgarzik@pobox.com> writes:
   
   > Stephen Hemminger wrote:
   > > Here is the 8139too version in net-drivers-2.5-exp modified for NAPI.
   > > Also:
   > > 	64k receive ring - has to handle wrap for that case;
   > > 	   the NoWrap flag does nothing if using this big ring.
   > > 	assert() -> BUG_ON()
   > >
   > > To deal with the races with tx_timeout, put back in the rx_lock from earlier versions.
   
   > +		local_irq_disable();
   > +		netif_rx_complete(dev);
   > +		RTL_W16_F(IntrMask, rtl8139_intr_mask);
   > +		local_irq_enable();
   
   Probably, by my mistake in previous mail. Sorry.  This still has the
   races condition. It can trigger the same problem by shared interrupt
   on SMP.
   
   Probably the following ISR style should use the below combination.
   
      in ISR
   	if (netif_rx_schedule_prep(dev)) {
   		RTL_W16 (IntrMask, rtl8139_norx_intr_mask);
   		__netif_rx_schedule(dev);
   	}
   
      in ->poll
   	local_irq_disable();
   	RTL_W16_F(IntrMask, rtl8139_intr_mask);
   	__netif_rx_complete(dev);
   	local_irq_enable();
   
   
   And another one should use the below combination.  (this style can
   change the flags of __LINK_STATE_RX_SCHED or __LINK_STATE_START anytime)
   
      in ISR
   	if (status & RxAckBits) {
   		RTL_W16_F (IntrMask, rtl8139_norx_intr_mask);
   		netif_rx_schedule (dev);
   	}
   
      in ->poll
   	local_irq_disable();
   	__netif_rx_complete(dev);
   	RTL_W16_F(IntrMask, rtl8139_intr_mask);
   	local_irq_enable();
   
      If happen the shared interrupt, the this ISR style may lose a
      chance of netif_rx_schedule().
   
   
   Anyway, the following patch should fix the problem. Please apply.
   
   Thanks.
   --
   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
   
    drivers/net/8139too.c |    2 +-
    1 files changed, 1 insertion(+), 1 deletion(-)

<shemminger@osdl.org> (03/11/22 1.1498)
   [PATCH] (3/3) 8139too -- poll_controller
   
   For net-drivers-2.5-exp, add a poll_controller hook to allow use of netconsole
   with this driver.
   
   jeff, don't have netconsole setup to test this so please give it a try before
   including it.

<shemminger@osdl.org> (03/11/22 1.1497)
   [PATCH] (2/3) 8139too -- configurable receive ring
   
   For net-drivers-2.5-exp:  Make the receive window configurable and go
   back to the original 32K by default.

<shemminger@osdl.org> (03/11/22 1.1496)
   [PATCH] (1/3) 8139too -- put back old assert
   
   For net-drivers-2.5-exp:
   Minimize code changes -- put back assert() macro with similar properties
   to the original.  Added unlikely() and KERN_ERR tag.

<romieu@fr.zoreil.com> (03/11/22 1.1495)
   [netdrvr r8169] Rx copybreak for small packets.
   - removal of rtl8169_unmap_rx() (unneeded as for now).

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1494)
   [wan cosa] netdev dyamic alloc

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1493)
   [wan synclink] netdev dynamic alloc

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1492)
   [netdrvr ppp] netdev dynamic alloc; convert ppp_net_init to alloc_netdev setup function

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1491)
   [arcnet] create and use alloc_arcdev helper

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1490)
   [arcnet com90xx] netdev dynamic alloc; module params; fix bugs

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1489)
   [arcnet com20020] netdev dynamic alloc; module params; fix bugs

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1488)
   [arcnet arc-rimi] use alloc_netdev; module params; fix bugs on error/cleanup

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1487)
   [arcnet com90io] use alloc_netdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1486)
   [appletalk ipddp] dynamically allocate struct net_device
   
   Converts from static to dynamic allocation, in preparation for
   further refcount changes.

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1485)
   [netdrvr ne3210] remove #if 0'd code

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1484)
   [wireless ray_cs] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1483)
   [netdrvr meth] use alloc_etherdev; fix leaks on error/cleanup

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/22 1.1482)
   [netdrvr qeth] use alloc_etherdev instead of hand-allocating struct net_device

<romieu@fr.zoreil.com> (03/11/20 1.1479)
   [netdrvr r8169] Conversion of Tx data buffers to PCI DMA:
   - endianness is kept in a fscked state as it is in the original code
     (will be adressed in a later patch);
   - buf_addr of an unmapped descriptor is always set to the same value 
     (cf rtl8169_unmap_tx_skb);
   - nothing fancy, really.

<romieu@fr.zoreil.com> (03/11/20 1.1478)
   [netdrvr r8169] rtl8169_start_xmit fixes:
   - it forgot to update stats if the skb couldn't be expanded;
   - it didn't free it either if the descriptor was not available;
   - move the spin_unlock nearer of the exit point instead of duplicating
     it in the new branch.

<romieu@fr.zoreil.com> (03/11/20 1.1477)
   [netdrvr r8169] Conversion of Rx data buffers to PCI DMA
   - endianness is kept in a fscked state as it is in the original code
     (will be adressed in a later patch);
   - rtl8169_rx_clear() walks the buffer ring and releases the allocated
     data buffers. It needs to be used in two places: 
     - rtl8169_init_ring() failure path;
     - normal device release (i.e. rtl8169_close);
   - rtl8169_free_rx_skb() releases a Rx data buffer. Mostly an helper
     for rtl8169_rx_clear(). As such it must:
     - unmap the memory area;
     - release the skb;
     - prevent the ring descriptor from being used again;
   - rtl8169_alloc_rx_skb() prepares a Rx data buffer for use.
     As such it must:
     - allocate an skb;
     - map the memory area;
     - reflect the changes in the ring descriptor.
     This function is balanced by rtl8169_free_rx_skb().
   - rtl8169_unmap_rx() simply helps with the 80-columns limit.
   - rtl8169_rx_fill() walks a given range of the buffer ring and
     try to turn any descriptor into a ready to use one. It returns the
     count of modified descriptors and exits if an allocation fails.
     It can be seen as balanced by rtl8169_rx_clear(). Motivation:
     - partially abstract the (usually big) piece of code for the refill
       logic at the end of the Rx interrupt;
     - factorize the refill logic and the initial ring setup.
   - simple conversion of rtl8169_rx_interrupt() without rx_copybreak
     (will be adressed in a later patch).

<romieu@fr.zoreil.com> (03/11/20 1.1476)
   [netdrvr r8169] Conversion of Rx/Tx descriptors to consistent DMA:
   - use pci_alloc_consistent() for Rx/Tx descriptors in rtl8169_open()
     (balanced by pci_free_consistent() on error path as well as in
     rtl8169_close());
   - removal of the fields {Rx/Tx}DescArrays in struct rtl8169_private
     as there is no need to store a non-256 bytes aligned address any more;
   - fix for rtl8169_open() leak when RxBufferRings allocation fails.
     Said allocation is pushed to rtl8169_init_ring() as part of an evil
     cunning plan.

<shemminger@osdl.org> (03/11/19 1.1435.2.96)
   [PATCH] 8139too NAPI for net-drivers-2.5-exp
   
   Here is the 8139too version in net-drivers-2.5-exp modified for NAPI.
   Also:
   	64k receive ring - has to handle wrap for that case;
   	   the NoWrap flag does nothing if using this big ring.
   	assert() -> BUG_ON()
   
   To deal with the races with tx_timeout, put back in the rx_lock from earlier versions.

<xose@wanadoo.es> (03/11/19 1.1435.2.95)
   [PATCH] more ne2k-pci clone boards

<xose@wanadoo.es> (03/11/19 1.1435.2.94)
   [PATCH] more RTL-8139 clone boards

<geert@linux-m68k.org> (03/11/18 1.1435.2.93)
   [PATCH] sun3-related net driver fixes
   
   On Mon, 17 Nov 2003, Geert Uytterhoeven wrote:
   > On Sun, 16 Nov 2003, Jeff Garzik wrote:
   > > Yet more updates.  Syncing with Andrew Morton, and more syncing with Al
   > > Viro.
   > >
   > > No users of init_etherdev remain in the tree.  (yay!)
   >
   > Here are some (untested, except for cross-gcc) fixes for the m68k-related
   > drivers:
   
   I forget to test the Sun-3 drivers:
     - sun3_82586.c:
         o add missing casts to iounmap() calls
         o fix parameter of free_netdev()
     - sun3lance.c: add missing casts to iounmap() calls
   
   Note that sun3_82586.c no longer compiles since SUN3_82586_TOTAL_SIZE is not
   defined. Sammy, is it OK to use PAGE_SIZE for that, since that's what's passed
   to ioremap()?

<geert@linux-m68k.org> (03/11/18 1.1435.2.92)
   [PATCH] m68k-related net driver fixes
   
   On Sun, 16 Nov 2003, Jeff Garzik wrote:
   > Yet more updates.  Syncing with Andrew Morton, and more syncing with Al
   > Viro.
   >
   > No users of init_etherdev remain in the tree.  (yay!)
   
   Here are some (untested, except for cross-gcc) fixes for the m68k-related
   drivers:
     - Space.c: fix incorrect prototypes for atarilance_probe() and mace_probe()
     - a2065.c: kill superfluous argument of alloc_etherdev()
     - apne.c:
         o fix incorrect prototype for apne_probe()
         o kill unused variable err
     - mac8390.c:
         o kill unused variable probed
         o fix typos ENDOEV -> ENODEV and ERR_PTE -> ERR_PTR
         o add missing variable slots
     - macmace.c: use ERR_PTR() where needed
     - macsonic.c: kill unused variable lp
     - mvme147.c:
         o kill conversion warning and kill a cast by making ram unsigned long
         o add missing variable err
   
   Note: The use of `slots' in mac8390.c is not in my tree. Do you know where that
   change comes from?

<mpm@selenic.com> (03/11/18 1.1435.2.91)
   [PATCH] netpoll: push zap_completion_queue for lkcd
   
   Move zap_completion_queue call inside netpoll so we don't need to
   export it separately.

<mpm@selenic.com> (03/11/18 1.1435.2.90)
   [PATCH] netpoll: fix compilation with CONFIG_NETPOLL_RX
   
   Fix compilation without CONFIG_NETPOLL_RX

<jgarzik@redhat.com> (03/11/16 1.1435.2.89)
   [netdrvr] remove init_etherdev mentions in Doc/SubmittingPatches, atari_pamsnet.c

<jgarzik@redhat.com> (03/11/16 1.1435.2.88)
   [netdrvr] remove Documentation/networking/8139too.txt
   
   All sections of the document are woefully outdated.

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.87)
   [netdrvr lasi_82596] remove ether_setup() call, fix leak in probe

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.86)
   [netdrvr] alloc_etherdev-related cleanups
   
   Mostly removing unneeded calls to ether_setup(), which alloc_etherdev()
   already does for us.

<jgarzik@redhat.com> (03/11/16 1.1435.2.85)
   [netdrvr 3c527] applied missing pieces of Richard Proctor's 3c527 SMP update
   
   Minor stuff... remove unused constants, and mark non-experimental
   and non-broken in Kconfig.

<jgarzik@redhat.com> (03/11/16 1.1435.2.84)
   [netdrvr tulip] clean up tulip NAPI poll disable
   
   Looks like the same patch was applied multiple times.  No negative
   effects except ugliness and a redundant test.

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.83)
   [netdrvr xircom_tulip_cb] remove bogus unregister_netdev call; use free_netdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.82)
   [netdrvr stnic] fix typo from last stnic cset

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.81)
   [netdrvr iph5526] use SET_MODULE_OWNER; small typedef cleanup

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.80)
   [netdrvr pcmcia] s/kfree/free_netdev/

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.79)
   [netdrvr ether00] s/kfree/free_netdev/ ; remove redundant memset() calls

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.78)
   [netdrvr] s/kfree/free_netdev/ where appropriate

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.77)
   [wireless wavelan{_cs}] use alloc_etherdev; remove useless net_device* typedef

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.76)
   [netdrvr de600] use alloc_etherdev; request_region fixes

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.75)
   [netdrvr atp] use alloc_etherdev, clean up probing

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.74)
   [netdrvr depca] fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.73)
   [netdrvr saa9730] use alloc_etherdev, annotate bugs found but not fixed

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.72)
   [netdrvr stnic] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.71)
   [netdrvr sgiseeq] alloc_etherdev, SET_MODULE_OWNER, fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.70)
   [netdrvr sb1250-mac] alloc_etherdev, fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.69)
   [netdrvr au1000_eth] alloc_etherdev, SET_MODULE_OWNER, fix leaks/small bugs

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.68)
   [netdrvr zorro8390] alloc_etherdev, SET_MODULE_OWNER

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.67)
   [netdrvr mace] alloc_etherdev, fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.66)
   [netdrvr znet] alloc_etherdev, SET_MODULE_OWNER, remove #ifdef MODULE

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.65)
   [netdrvr oaknet] use alloc_etherdev, fix leaks

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.64)
   [netdrvr hydra] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.63)
   [netdrvr gt96100eth] use alloc_etherdev, fix leaks

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.62)
   [netdrvr declance] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.61)
   [netdrvr ariadne] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1435.2.60)
   [netdrvr a2065] convert to alloc_etherdev

<jgarzik@redhat.com> (03/11/16 1.1435.2.59)
   [netdrvr tc35815] switch to using alloc_etherdev
   
   Also handle ioremap failure.

<jgarzik@redhat.com> (03/11/16 1.1435.2.58)
   [netdrvr tc35815] many fixes, major and minor
   
   * s/int/unsigned long/ for 'flags' arg passed to spin_lock_irqsave
   * s/unsigned int/unsigned long/ for I/O port addresses
   * no need to prevent tc35815_probe from being called multiple times...
     PCI layer will do things properly for us.
   * call pci_enable_device before accessing hardware, before obtaining
     irq number, and before obtaining I/O port addresses.
   * remove bogus 'if (pdev)' check in PCI API ->probe function
   * call SET_M0DULE_OWNER, remove MOD_{INC,DEC}_USE_COUNT
   * (cleanup) don't bother casting from a void*
   * (cleanup) mark debugging function with #if 0, just like the caller
   * Fix many printk statements to indicate that tc_readl() returns
     a long, not an int.
   * (cleanup) remove unused tc35815_proc_info function

<scott.feldman@intel.com> (03/11/16 1.1435.2.57)
   [e100] missed a kfree -> free_netdev
   
   * missed a kfree -> free_netdev

<scott.feldman@intel.com> (03/11/16 1.1435.2.56)
   [e100] add extended device-specific ethtool stats
   
   * Add extended device-specific ethtool stats

<scott.feldman@intel.com> (03/11/16 1.1435.2.55)
   [e100] remove __devinit from mis-marked funcs
   
   * Remove __devinit from mis-marked functions that are needed
     after init for things like ethtool.  (anton@samba.org)

<scott.feldman@intel.com> (03/11/16 1.1435.2.54)
   [e1000] Internal SERDES link detect; delay after SPI
   
   * Internal SERDES designs must use indirect method to sample
     link status based on sampling MAC sync bits.
   * Need 10 msec delay after SPI eeprom write, otherwise back-to-
     back writes can get corrupted.
   * Allow for setup of multiple MAC addresses (not used for
     Linux - shared code change).
   * Updated comment block.

<scott.feldman@intel.com> (03/11/16 1.1435.2.53)
   [e1000] exit polling loop if interface is brought down
   
   * Exit polling loop if interface is brought down.

<scott.feldman@intel.com> (03/11/16 1.1435.2.52)
   [e1000] improve Tx flush method
   
   * Flush queued in-flight Tx descriptors when link is lost.  8254x stops
     processing Tx descriptors when link is lost, so outstanding Tx
     buffers will not be returned to OS unless we flush the Tx descriptor
     ring.  This patch move the flush from the watchdog timer callback
     to process context to work around some issue with holding xmit_lock
     in timer callback.

<scott.feldman@intel.com> (03/11/16 1.1435.2.51)
   [e1000] print message if user overrides default ITR
   
   * Print message if user overrides default setting of ITR.

<scott.feldman@intel.com> (03/11/16 1.1435.2.50)
   [e1000] 82547 interrupt assert/de-assert re-ordering
   
   * 82547 needs interrupt disable/enable to keep interrupt assertion
     state synced between 82547 and APIC.  82547 will re-order
     assert and de-assert messages if hub link bus is busy (heavy
     traffic).  Disabling interrupt on device works around re-
     order issue.

<scott.feldman@intel.com> (03/11/16 1.1435.2.49)
   [e1000] use unsigned long for I/O base addr
   
   * Use unsigned long for I/O base addr; can be 64-bit on some archs.

<scott.feldman@intel.com> (03/11/16 1.1435.2.48)
   [e1000] loopback diag test failing on big-endian
   
   * ethtool diag loopback test was failing on ppc because of
     endianness issue.

<scott.feldman@intel.com> (03/11/16 1.1435.2.47)
   [e1000] use pdev->irq rather than netdev->irq for
   
   * Use pdev->irq rather than netdev->irq for interrupt
     registration in anticipation of MSI interrupt API support.

<scott.feldman@intel.com> (03/11/16 1.1435.2.46)
   [e1000] add ethtool ring param support
   
   * Add ethtool ring param support

<jgarzik@redhat.com> (03/11/16 1.1435.2.45)
   [netdrvr] Remove never-referenced 68360enet.c

<jgarzik@redhat.com> (03/11/12 1.1435.2.44)
   [netdrvr 3c515] fix non-modular build

<shemminger@osdl.org> (03/11/12 1.1435.2.43)
   [PATCH] (42/42) atari_lance
   
   NE68-atarilance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits
   	* also kill off last usage of probe_list

<shemminger@osdl.org> (03/11/12 1.1435.2.42)
   [PATCH] (41/42) sun3_lance
   
   NE67-sun3lance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.41)
   [PATCH] (40/42) sun3_82586
   
   NE66-sun3_82586
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.40)
   [PATCH] (39/42) apne
   
   NE64-apne
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.39)
   [PATCH] (38/42) bionet
   
   NE63-bionet
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.38)
   [PATCH] (37/42) pamsnet
   
   NE62-pamsnet
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.37)
   [PATCH] (36/42) hplance
   
   NE61-hplance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.36)
   [PATCH] (35/42) mvme147
   
   NE60-mvme147lance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.35)
   [PATCH] (34/42) mac_mace
   
   NE59-mace
   	* switched mace to dynamic allocation
   	* mace: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.34)
   [PATCH] (33/42) macsonic
   
   NE58-macsonic
   	* switched macsonic to dynamic allocation
   	* macsonic: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.33)
   [PATCH] (32/42) mac8390
   
   NE57-mac8390
   	* switched mac8390 to dynamic allocation
   	* mac8390: fixed resource leaks on failure exits
   	* get rid of MOD_INC/DEC

<shemminger@osdl.org> (03/11/12 1.1435.2.32)
   [PATCH] (31/42) mac89x0
   
   NE56-mac8390
   	* switched mac8390 to dynamic allocation
   	* mac8390: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.31)
   [PATCH] (30/42) jazzsonic
   
   NE55-jazzsonic
   	* switched jazzsonic to dynamic allocation
   	* jazzsonic: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.30)
   [PATCH] (29/42) bagetlance
   
   NE54-bagetlance
   	* switched bagetlance to dynamic allocation
   	* bagetlance: embedded ->priv
   	* bagetlance: fixed resource leaks on failure exits
   	* bagetlance: fixed resource leaks on rmmod

<shemminger@osdl.org> (03/11/12 1.1435.2.29)
   [PATCH] (28/42) ultra32
   
   NE52-ultra32
   	* switched smc-ultra32 to dynamic allocation
   	* smc-ultra32: fixed order of freeing bugs
   	* smc-ultra32: fixed clobbering on autoprobe
   	* smc-ultra32: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.28)
   [PATCH] (27/42) ac3200
   
   NE51-ac3200
   	* switched ac3200 to dynamic allocation
   	* ac3200: fixed order of freeing bugs
   	* ac3200: fixed clobbering on autoprobe
   	* ac3200: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.27)
   [PATCH] (26/42) es3210
   
   NE50-es3210
   	* switched es3210 to dynamic allocation
   	* es3210: fixed order of freeing bugs
   	* es3210: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.26)
   [PATCH] (25/42) lne390
   
   NE49-lne390
   	* switched lne390 to dynamic allocation
   	* lne390: fixed order of freeing bugs
   	* lne390: fixed clobbering on autoprobe
   	* lne390: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.25)
   [PATCH] (24/42) ne2
   
   NE48-ne2 from viro
   	* switched ne2 to dynamic allocation
   	* ne2: fixed order of freeing bugs
   	* ne2: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.24)
   [PATCH] (23/42) 3c523
   
   NE47-3c523 from viro
   	* switched 3c523 to dynamic allocation
   	* 3c523: switched to embedded ->priv
   	* 3c523: fixed order of freeing bugs
   	* 3c523: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.23)
   [PATCH] (22/42) 3c527
   
   NE46-3c527
   	* switched 3c527 to dynamic allocation
   	* 3c527: switched to embedded ->priv
   	* 3c527: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.22)
   [PATCH] (21/42) sk_mca
   
   NE45-sk_mca
   	* switched sk-mca to dynamic allocation
   	* sk-mca: switched to embedded ->priv
   	* sk-mca: fixed order of freeing bugs
   	* sk-mca: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.21)
   [PATCH] (20/42) hp100-T10
   
   NE44-hp100
   	* convert to dynamic allocation
   	* use device model for PCI and EISA
   	* use pci id's to find PCI devices
   	* fix missing id's for 10 Mbit only PCI boards

<shemminger@osdl.org> (03/11/12 1.1435.2.20)
   [PATCH] (19/42) 3c515-T10
   
   NE43-3c515
   	* convert to dynamic allocation
   	* fixed up device list handling

<shemminger@osdl.org> (03/11/12 1.1435.2.19)
   [PATCH] (18/42) ultra
   
   Based on viro NE42-ultra
   	* switched smc-ultra to dynamic allocation
   	* smc-ultra: fixed order of freeing bugs
   	* smc-ultra: fixed resource leaks on failure exits
   	* smc-ultra: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.18)
   [PATCH] (17/42) wd
   
   Based on viro NE41-wd
   	* switched wd to dynamic allocation
   	* wd: fixed order of freeing bugs
   	* wd: fixed resource leaks on failure exits
   	* wd: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.17)
   [PATCH] (16/42) 3c503
   
   Based on viro NE40-3c503
   	* switched 3c503 to dynamic allocation
   	* 3c503: fixed order of freeing bugs
   	* 3c503: fixed IO without request_region
   	* 3c503: fixed resource leaks on failure exits
   	* 3c503: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.16)
   [PATCH] (15/42) hp
   
   Based on viro NE39-hp
   	* switched hp to dynamic allocation
   	* hp: fixed order of freeing bugs
   	* hp: fixed resource leaks on failure exits
   	* hp: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.15)
   [PATCH] (14/42) hpplus
   
   Based on NE38-hpplus
   	* switched hp-plus to dynamic allocation
   	* hp-plus: fixed order of freeing bugs
   	* hp-plus: fixed resource leaks on failure exits
   	* hp-plus: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.14)
   [PATCH] (13/42) e2100
   
   Based on viro NE37-e2100
   	* switched e2100 to dynamic allocation
   	* e2100: fixed order of freeing bugs
   	* e2100: fixed resource leaks on failure exits
   	* e2100: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.13)
   [PATCH] (12/42) ne
   
   Based on NE36-ne
   	* switched ne/ne2k_cbus to dynamic allocation
   	* ne/ne2k_cbus: fixed order of freeing bugs
   	* ne/ne2k_cbus: fixed resource leaks on failure exits
   	* ne/ne2k_cbus: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.12)
   [PATCH] (11/42) lance
   
   Based on viro NE35-lance
   	* switched lance to dynamic allocation
   	* lance: fixed init_etherdev races
   	* lance: fixed resource leaks on failure exits
   	* NB: probing code is, to put it mildly, odd.  It _always_ does
   	  autoprobe, modular or not.  WTF is going on there?

<shemminger@osdl.org> (03/11/12 1.1435.2.11)
   [PATCH] (10/42) smc
   
   Based on viro NE34-smc
   	* switched smc to dynamic allocation
   	* smc: embedded ->priv
   	* smc: fixed resource leaks on failure exits
   	* smc: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.10)
   [PATCH] (9/42) seeq8005
   
   Based on viro NE33-seeq8005
   	* switched seeq8005 to dynamic allocation
   	* seeq8005: embedded ->priv
   	* seeq8005: fixed resource leaks on failure exits
   	* seeq8005: fixed clobbering on autoprobe
   	* seeq8005: fixed jiffies truncation
   	* seeq8005: fixed a typo in Kconfig - module is _not_ called ewrk3

<shemminger@osdl.org> (03/11/12 1.1435.2.9)
   [PATCH] (8/42) at1500
   
   Based on viro NE32-at1500
   	ROTFL.  The last remnants of CONFIG_AT1500 removed - that was a hell
   	of an ancient bug (at1500_probe() was never defined, AFAICS - all
   	way back to 0.99.15).

<shemminger@osdl.org> (03/11/12 1.1435.2.8)
   [PATCH] (7/42) cs89x0
   
   Based on viro NE31-cs89x0
   	* switched cs89x0 to dynamic allocation
   	* cs89x0: embedded ->priv
   	* cs89x0: fixed resource leaks on failure exits
   	* cs89x0: fixed clobbering on autoprobe
   	* NB: cs89x0 calls request_region() with very odd arguments.  Somebody
   	  ought to check WTF is going on there.

<shemminger@osdl.org> (03/11/12 1.1435.2.7)
   [PATCH] (6/42) at1700
   
   Based on viro NE30-at1700
   	* switched at1700 to dynamic allocation
   	* at1700: embedded ->priv
   	* at1700: fixed resource leaks on failure exits
   	* at1700: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1435.2.6)
   [PATCH] (5/42) fmv18
   
   Based on viro, NE29-fmv18
   	* switched fmv18x to dynamic allocation
   	* fmv18x: embedded ->priv
   	* fmv18x: fixed resource leaks on failure exits
   	* fmv18x: fixed clobbering on autoprobe
   	* fmv18x: compile fix - comment is _not_ an empty statement.  The thing
   	  had been b0rken since 2.4.3-pre2, BTW...

<shemminger@osdl.org> (03/11/12 1.1435.2.5)
   [PATCH] (4/42) eth16i
   
   NE28-eth16i
   	* switched eth16i to dynamic allocation
   	* eth16i: embedded ->priv
   	* eth16i: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.4)
   [PATCH] (3/42) eexpress
   
   Based on viro NE27-eexpress
   	* switched eexpress to dynamic allocation
   	* eexpress: embedded ->priv
   	* eexpress: fixed clobbering on autoprobe
   	* eexpress: fixed IO without request_region()
   	* eexpress: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.3)
   [PATCH] (2/42) eepro
   
   Patch from viro: NE26-eepro
   	* switched eepro to dynamic allocation
   	* eepro: embedded ->priv
   	* eepro: fixed clobbering on autoprobe
   	* eepro: fixed IO before request_region()
   	* eepro: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1435.2.2)
   [PATCH] (1/42) ewrk3
   
   Convert ewrk3 to dynamic allocation
   	* get rid of private device allocation method
   	* fix deeply nested function

<shemminger@osdl.org> (03/11/11 1.1428.2.5)
   [PATCH] sk_g16 missing declaration
   
   The new probe code in net-drivers-2.5-exp lost a declaration for the
   module case (thanks al).

<shemminger@osdl.org> (03/11/11 1.1428.2.4)
   [PATCH] arlan new probe code needs to register
   
   Fix arlan registration in the net-drivers-2.5-exp repo.
   Need to call register_netdev. Found by viro.

<shemminger@osdl.org> (03/11/11 1.1428.2.3)
   [PATCH] 3c59x netpoll typo
   
   Poll code (in net-drivers-2.5-exp) was calling undefined function.

<shemminger@osdl.org> (03/11/11 1.1428.2.2)
   [PATCH] typo in net-drivers-2.5-exp 3c507
   
   Fix auto-probing loop in new probing code for 3c507.
   This patch is against net-drivers-2.5-exp repository.
   Found by viro.

<ak@muc.de> (03/10/29 1.1380.2.24)
   [PATCH] netpoll for eepro100
   
   netpoll for eepro100
   
   This was in Ingo's old original netconsole patches.

<ak@muc.de> (03/10/29 1.1380.2.23)
   [PATCH] fix tg3 netpoll
   
   No need to use disable_irq because tg3 is properly spinlocked.
   Can just call the interrupt handler directly.

<ak@muc.de> (03/10/29 1.1380.2.22)
   [PATCH] Netpoll for pcnet32
   
   netpoll for pcnet32

<ak@muc.de> (03/10/29 1.1380.2.21)
   [PATCH] netpoll for amd8111e
   
   netpoll for amd8111e

<ak@muc.de> (03/10/29 1.1380.2.20)
   [PATCH] netpoll for tulip
   
   Netpoll for tulip. Uses disable_irq() because tulip is unfortunately
   still lockless.

<ak@muc.de> (03/10/29 1.1380.2.19)
   [PATCH] netpoll for 3c59x
   
   >From the old -aa tree with minor changes. Orginally done
   by Andrea I think.

<mpm@selenic.com> (03/10/29 1.1380.5.3)
   [NET] use the netpoll API to transmit kernel printks over UDP

<mpm@selenic.com> (03/10/29 1.1380.5.2)
   [NET] Add netpoll support for tg3

<mpm@selenic.com> (03/10/29 1.1380.5.1)
   [NET] add netpoll API

<shemminger@osdl.org> (03/10/29 1.1380.2.17)
   [PATCH] trivial -- skfp_probe should be static
   
   skfp_probe used to be called from Space.c but isn't any more.
   Therefore it no longer needs to be global.  All the calls to insert_device()
   pass skfp_probe as a second arg, so just use it directly.
   
   Jeff, this also is janitor type stuff, so just put it in net-2.5-exp

<shemminger@osdl.org> (03/10/29 1.1380.2.16)
   [PATCH] (4/6) skisa -- probe2
   
   Convert the SK-NET TMS380 ISA card to the new probe2 format.

<shemminger@osdl.org> (03/10/29 1.1380.2.15)
   [PATCH] (3/6) proteon -- probe2
   
   Convert proteon token ring driver to new probing.

<shemminger@osdl.org> (03/10/29 1.1380.2.14)
   [PATCH] (2/6) smctr -- probe2
   
   Convert the SMC tokenring driver to new probing.

<shemminger@osdl.org> (03/10/29 1.1380.2.13)
   [PATCH] (1/6) tokenring probing change
   
   Ugh, two patches got crossed. This is the correct first one.

<rnp@paradise.net.nz> (03/10/29 1.1380.2.12)
   [netdrvr 3c527] fix race

<rnp@paradise.net.nz> (03/10/29 1.1380.2.11)
   [netdrvr 3c527] whitespace changes (sync up with maintainer)

<shemminger@osdl.org> (03/10/14 1.1337.26.21)
   [PATCH] (12/12) Probe2 -- 82596
   
   Originally by Al Viro (NE23-82596)
   	* switched 82596 to dynamic allocation
   	* 82596: fixed resource leaks on failure exits
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.20)
   [PATCH] (11/12) Probe2 -- 3c501
   
   >From viro NE22-3c501
   	* switched 3c501 to dynamic allocation
   	* 3c501: embedded ->priv
   	* 3c501: fixed clobbering on autoprobe
   	* 3c501: fixed resource leaks on failure exits
   Additional:
   	* probe correctly when no device present
   	* fix loop forever bug in probing
   	* free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.19)
   [PATCH] (10/12) Probe2 -- wavelan
   
   Original by Al Viro (NE21-wavelan)
   	* switched wavelan to dynamic allocation
   	* wavelan: embedded ->priv
   	* wavelan: fixed clobbering on autoprobe
   	* wavelan: fixed IO before request_region()
   	* wavelan: fixed resource leaks on failure exits
   	* wavelan: fixed order of freeing bugs
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.18)
   [PATCH] (09/12) Probe2 -- arlan
   
   Convert arlan driver to new probing.  This meant a rather large
   rework of the probing code for this driver since it did a lot ofnon
   standard things.

<shemminger@osdl.org> (03/10/14 1.1337.26.17)
   [PATCH] (08/12) Probe2 -- 3c507
   
   Originally by Al Viro (NE19-3c507)
   	* switched 3c507 to dynamic allocation
   	* 3c507: embedded ->priv
   	* 3c507: fixed clobbering on autoprobe
   	* NB: 3c507.c buggers port 0x100 without claiming it.  Most likely it
   	  should be doing request_region() there.
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.16)
   [PATCH] (07/12) Probe2 -- 3c505
   
   from viro NE18-3c505
   	* switched 3c505 to dynamic allocation
   	* 3c505: embedded ->priv
   	* 3c505: fixed use of uninitialized variable
   	* 3c505: fixed resource leaks on failure exits
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.15)
   [PATCH] (06/12) Probe2 -- sk16
   
   from viro NE17-sk16
   	* switched sk_g16 to dynamic allocation
   	* sk_g16: embedded ->priv
   	* sk_g16: fixed buggy check for signature (|| instead of &&, somebody
   	  forgot to replace it when inverting the test).
   	* sk_g16: fixed use after kfree()
   	* sk_g16: fixed init_etherdev() race
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.14)
   [PATCH] (05/12) Probe2 -- ni5010
   
   from viro NE16-ni5010
   	* switched ni5010 to dynamic allocation
   	* ni5010: embedded ->priv
   	* ni5010: fixed clobbering ->irq
   	* ni5010: fixed IO before request_region()
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.13)
   [PATCH] (04/12) Probe2 -- ni52
   
   >From viro NE15-ni52
   	* switched ni52 to dynamic allocation
   	* ni52: embedded ->priv
   	* ni52: fixed clobbering of everything on autoprobe
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.12)
   [PATCH] (03/12) Probe2 -- ni65
   
   Convert ni65 driver to new probing; patch sequence goes bottom
   up on the probe list.
   
   	* switched ni65 to dynamic allocation
   	* ni65: fixed ->irq and ->dma clobbering on autoprobe

<shemminger@osdl.org> (03/10/14 1.1337.26.11)
   [PATCH] (2/12) Probe2 -- de620
   
   Rework de620 driver to new dynamic allocation
   Originally by Al Viro.
   	* switched de620 to dynamic allocation
   	* de620: embedded ->priv
   	* de620: fixed IO before request_region()
   
   Updated to ~jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.10)
   [PATCH] (1/12) Probe2 infrastructure for 2.6 experimental
   
   New infrastructure to allow probing older builtin drivers (like ISA)
   Originally by Al Viro, updated to apply agains jgarzik/net-drivers-2.5-exp

<jgarzik@redhat.com> (03/10/14 1.1337.26.9)
   [netdrvr tulip] support NAPI
   
   Contributed by Robert Ollsson.

<shemminger@osdl.org> (03/10/14 1.1337.26.8)
   [PATCH] smctr - get rid of MOD_INC/DEC
   
   Get rid of warning now that module refcounting now done by network code not drivers.
   
   Not tested on real hardware.

<rddunlap@osdl.org> (03/10/14 1.1337.26.7)
   [PATCH] janitor: insert missing iounmap(), add error handling
   
   Hi,
   Please apply to 2.6.0-test6-current.
   
   Thanks,
   --
   ~Randy
   
   
   
   From: Leann Ogasawara <ogasawara@osdl.org>
   Subject: Re: [Kernel-janitors] [PATCH] insert missing iounmap()
   
   > > Patch inserts a missing iounmap().  Implements a cleanup path
   > > for error handling as well.  Feedback is much appreciated.  Thanks :)
   
   
   
   ===== drivers/net/natsemi.c 1.55 vs edited =====
   
   
    linux-260-test6-kj1-rddunlap/drivers/net/natsemi.c |   39 ++++++++++-----------
    1 files changed, 20 insertions(+), 19 deletions(-)

<felipewd@terra.com.br> (03/10/14 1.1337.26.6)
   [PATCH] release region in skfddi driver
   
   This is a multi-part message in MIME format.

<felipewd@terra.com.br> (03/10/14 1.1337.26.5)
   [netdrvr 3c527] remove cli/sti
   
   
       Richard Procter and I worked to remove cli/sti to add proper SMP support (I did the original stuff and Richard did the actual current code :)).
   
       Besides that, Richard did a great jog improving the perfomance of the driver quite a bit:
   
       - Improve mc32_command by 770% (438% non-inlined) over the semaphore version (at a cost of 1 sem + 2 completions per driver).
   
       - Removed mutex covering mc32_send_packet (hard_start_xmit). This lets the interrupt handler operate concurrently and removes unnecessary locking. It makes the code only slightly more brittle
   
       Original post:
   
   http://marc.theaimsgroup.com/?l=linux-netdev&m=106438449315202&w=2
   
       Since it didn't apply cleanly against 2.6.0-test6, I forward ported it. Patch attached.
   
       Jeff, please consider applying,
   
       Thanks.

<shemminger@osdl.org> (03/10/14 1.1337.26.4)
   [PATCH] remove dev_get from wanrouter
   
   The call to dev_get() in wanrouter_device_new_if is racy and redundant and should
   be removed.  The later 'register_netdev()' does the same test internally and will
   return the appropriate error if the name already exists.
   
   This patch is against 2.6.0-test6.
   Resend of earlier patch because it was ignored, or missed.

<romieu@fr.zoreil.com> (03/10/14 1.1337.26.3)
   [PATCH] 2.6.0-test6 - more free_netdev() conversion
   
   Compiles ok (with true .o generated, yeah). Please review.
   
   free_netdev() of devices allocated through use of alloc_netdev().
   Though baroque, drivers/net/3c515.c now uses alloc_etherdev().
   
   
    drivers/net/3c515.c   |   23 ++++++++++++-----------
    drivers/net/defxx.c   |    2 +-
    drivers/net/dummy.c   |    2 +-
    drivers/net/eql.c     |    2 +-
    drivers/net/ns83820.c |    2 +-
    drivers/net/plip.c    |   14 ++++++++++----
    drivers/net/shaper.c  |   11 ++++++++---
    drivers/net/tun.c     |   18 +++++++++---------
    9 files changed, 43 insertions(+), 31 deletions(-)

<shemminger@osdl.org> (03/10/14 1.1337.26.2)
   [PATCH] wan/lmc -- convert to new network device model
   
   Resend of LMC driver patch for 2.6.0-test6
     * do proper probing
     * allocate network device with alloc_netdev
     * use standard pci_id's instead of local defines
     * use standard PCI device interface to find and remove devices.

<krishnakumar@naturesoft.net> (03/10/14 1.1337.26.1)
   [netdrvr 8139too] support netif_msg_* interface

