Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTITT2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 15:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTITT2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 15:28:05 -0400
Received: from havoc.gtf.org ([63.247.75.124]:35033 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261364AbTITT1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 15:27:51 -0400
Date: Sat, 20 Sep 2003 15:27:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [bk patches] 2.6.x net driver updates
Message-ID: <20030920192750.GA27666@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First queue push after return from Silly Valley.


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Patch is also available at:

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test5-bk7-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/irda/smc-ircc.c           | 1258 ----------------------------------
 drivers/net/irda/toshoboe.c           |  957 -------------------------
 Documentation/networking/bonding.txt  |    4 
 drivers/net/3c501.c                   |    6 
 drivers/net/3c505.c                   |   12 
 drivers/net/3c515.c                   |    1 
 drivers/net/Space.c                   |    4 
 drivers/net/acenic.c                  |    3 
 drivers/net/bonding/bond_alb.c        |  150 +++-
 drivers/net/bonding/bond_alb.h        |    8 
 drivers/net/bonding/bond_main.c       | 1202 ++++++++++++++++++++------------
 drivers/net/bonding/bonding.h         |    4 
 drivers/net/cs89x0.c                  |    1 
 drivers/net/depca.c                   |  944 ++++++++++++-------------
 drivers/net/e1000/e1000_main.c        |   13 
 drivers/net/eepro.c                   |    6 
 drivers/net/ewrk3.c                   |    5 
 drivers/net/hamradio/baycom_par.c     |    1 
 drivers/net/hamradio/baycom_ser_fdx.c |    1 
 drivers/net/hamradio/baycom_ser_hdx.c |    1 
 drivers/net/hamradio/hdlcdrv.c        |    1 
 drivers/net/hamradio/scc.c            |  208 +++--
 drivers/net/hamradio/yam.c            |    1 
 drivers/net/ibmlana.c                 |    1 
 drivers/net/irda/Kconfig              |   24 
 drivers/net/irda/Makefile             |    2 
 drivers/net/irda/ali-ircc.c           |   84 --
 drivers/net/irda/donauboe.c           |   50 -
 drivers/net/irda/irda-usb.c           |   44 -
 drivers/net/irda/nsc-ircc.c           |   78 --
 drivers/net/irda/sir_kthread.c        |    4 
 drivers/net/irda/via-ircc.c           |   92 --
 drivers/net/irda/w83977af_ir.c        |   54 -
 drivers/net/lance.c                   |   10 
 drivers/net/mace.c                    |    1 
 drivers/net/ne2.c                     |    1 
 drivers/net/ni5010.c                  |    5 
 drivers/net/ni52.c                    |    5 
 drivers/net/ni65.c                    |    1 
 drivers/net/ns83820.c                 |   10 
 drivers/net/pcmcia/com20020_cs.c      |   41 -
 drivers/net/rcpci45.c                 |    4 
 drivers/net/rrunner.c                 |   17 
 drivers/net/rrunner.h                 |    1 
 drivers/net/sb1000.c                  |    1 
 drivers/net/sis900.c                  |    1 
 drivers/net/sk98lin/h/skdrv1st.h      |    4 
 drivers/net/sk98lin/skge.c            |    1 
 drivers/net/sk_mca.h                  |    2 
 drivers/net/skfp/h/targetos.h         |    1 
 drivers/net/smc9194.c                 |    1 
 drivers/net/tokenring/lanstreamer.h   |    2 
 drivers/net/tokenring/proteon.c       |    2 
 drivers/net/tokenring/skisa.c         |    2 
 drivers/net/tokenring/smctr.c         |    1 
 drivers/net/tokenring/tms380tr.c      |    1 
 drivers/net/wan/comx-hw-comx.c        |    1 
 drivers/net/wan/comx-hw-locomx.c      |    1 
 drivers/net/wan/comx-hw-mixcom.c      |    1 
 drivers/net/wan/comx-hw-munich.c      |    1 
 drivers/net/wan/comx-proto-fr.c       |    1 
 drivers/net/wan/comx-proto-lapb.c     |    1 
 drivers/net/wan/comx-proto-ppp.c      |    1 
 drivers/net/wan/comx.c                |    1 
 drivers/net/wan/cycx_x25.c            |    1 
 drivers/net/wan/dlci.c                |    1 
 drivers/net/wan/dscc4.c               |    1 
 drivers/net/wan/lmc/lmc_ver.h         |    2 
 drivers/net/wan/pc300_drv.c           |    1 
 drivers/net/wan/pc300_tty.c           |    1 
 drivers/net/wan/sbni.c                |   20 
 drivers/net/wan/sdla_chdlc.c          |    1 
 drivers/net/wan/sdla_fr.c             |    1 
 drivers/net/wan/sdla_ft1.c            |    1 
 drivers/net/wan/sdla_ppp.c            |    1 
 drivers/net/wan/sdla_x25.c            |    1 
 drivers/net/wan/sdladrv.c             |    1 
 drivers/net/wan/sdlamain.c            |    1 
 drivers/net/wan/sealevel.c            |  157 ++--
 drivers/net/wan/wanpipe_multppp.c     |    1 
 drivers/net/wd.c                      |    5 
 drivers/net/wireless/airo.c           |   11 
 drivers/net/wireless/arlan-proc.c     |    3 
 drivers/net/wireless/arlan.c          |    1 
 drivers/net/wireless/arlan.h          |    1 
 drivers/net/wireless/strip.c          |    1 
 include/net/syncppp.h                 |    7 
 87 files changed, 1799 insertions(+), 3769 deletions(-)

through these ChangeSets:

<shemminger@osdl.org> (03/09/20 1.1386)
   [PATCH] Road Runner HIPPI driver (rrunner)
   
   Small clean up, to use current APIs.

<achirica@telefonica.net> (03/09/20 1.1385)
   [wireless airo] Fix MIC support with CryptoAPI

<achirica@telefonica.net> (03/09/20 1.1384)
   [wireless airo] fix PCI probe

<jochen@scram.de> (03/09/20 1.1383)
   [tokenring] fix breakage in proteon, skisa
   
   this one fixes both drivers. They have been broken since the
   reorganization in June. Unfortunately, my major build platform (alpha) had
   some issues with later 2.5.X kernels (cache problems causing all kind of
   funny behaviour), so i waited until these problems had been resolved by
   the alpha gurus :-/...
   
   In the mean time i also upgraded pine. I hope the patch corruption issue
   is resolved by now.
   

<shemminger@osdl.org> (03/09/20 1.1382)
   [PATCH] hamradio/scc -
   
   Update hamradio/scc for 2.6.0-test5
   	- use seq_file for /proc
   	- get rid of dev_get()
   	- use alloc_netdev
   
   Don't have hardware, but can load/unload the module fine.

<amir.noam@intel.com> (03/09/20 1.1381)
   [PATCH] [bonding] Convert /proc to seq_file
   
   This patch converts /proc/net/bondX/info into /proc/net/bonding/bondX
   using the seq_file interface.
   
   This is based on Stephen's recent patch, but slightly modified to work
   with the propagation patch set and with some locking changes to make it
   simpler.
   
   The patch applies both on 2.4 (after the sync set from earlier today)
   and on 2.6 (after the propagation set from 2003/11/9).
   
   Amir

<bunk@fs.tum.de> (03/09/20 1.1380)
   [PATCH] fix sbni.c compile with gcc 3.3
   
   sbni.c in 2.6.0-test5 fails to compile with gcc 3.3 with the following
   error:
   
   <--  snip  -->
   
   ...
     CC      drivers/net/wan/sbni.o
   ...
   drivers/net/wan/sbni.c: In function `calc_crc32':
   drivers/net/wan/sbni.c:1568: error: asm-specifier for variable `_crc'
   conflicts with asm clobber list
   make[3]: *** [drivers/net/wan/sbni.o] Error 1
   
   <--  snip  -->
   
   Below is the patch by Margit Schubert-White to fix this issue (it is
   already in 2.4).
   
   cu
   Adrian

<akpm@osdl.org> (03/09/20 1.1379)
   [PATCH] e1000 bug
   
   Rick Lindsley <ricklind@us.ibm.com> wrote:
   >
   > since it's been out for a while you probably already know, but the patch
   > for e1000_main.c has a bug in it.  Looks like it will fail at line 1550 if
   > compiled with NETIF_F_TSO defined.
   >
   
   So it will.  I blame the gcc developers.
   
    25-akpm/drivers/net/e1000/e1000_main.c |   13 +++++++++----
    1 files changed, 9 insertions(+), 4 deletions(-)

<amir.noam@intel.com> (03/09/20 1.1378)
   [PATCH] [bonding 2.6] Fix ipx_hdr compile error

<amir.noam@intel.com> (03/09/20 1.1377)
   [PATCH] [bonding 2.6] Add missing free_netdev()

<amir.noam@intel.com> (03/09/20 1.1376)
   [PATCH] [bonding 2.6] Enhance netdev notification handling

<amir.noam@intel.com> (03/09/20 1.1375)
   [PATCH] [bonding 2.6] Consolidate /proc code, add CHANGENAME handler

<amir.noam@intel.com> (03/09/20 1.1374)
   [PATCH] [bonding 2.6] Add support for changing HW address in ALB/TLB modes

<amir.noam@intel.com> (03/09/20 1.1373)
   [PATCH] [bonding 2.6] Add support for changing HW address and MTU

<amir.noam@intel.com> (03/09/20 1.1372)
   [PATCH] [bonding 2.6] Decouple promiscuous handling from multicast mode setting

<amir.noam@intel.com> (03/09/20 1.1371)
   [PATCH] [bonding 2.6] fix assign_current_slave

<amir.noam@intel.com> (03/09/20 1.1370)
   [PATCH] [bonding 2.6] consolidate change_active operations

<shemminger@osdl.org> (03/09/20 1.1369)
   [PATCH] update arcnet/pcmcia driver
   
   Redo of earlier patch to get rid of MOD_INC/DEC and use alloc_netdev.
   This is against 2.6.0-test5 bk latest.

<shemminger@osdl.org> (03/09/20 1.1368)
   [PATCH] sealevel wan driver
   
   Update sealevel driver to match current net_device interface:
   	- dynamically allocate netdevice and private data.
   	- get rid of MOD_INC/DEC
   	- if_ptr not used
   	- bugfix: not all of board structure was being zeroed.
   
   Note: this driver still doesn't probe() correctly since it just assumes that
   if loaded the hardware is there!
   
   Since I don't have one of these boards...
   tested it by #ifdef'ing out all the bits that touch actual hardware.

<shemminger@osdl.org> (03/09/20 1.1367)
   [IrDA] ali-ircc -- dev_alloc cleanout
   
   Convert ali-ircc driver to:
   	- use alloc_net_dev not dev_alloc
   	- allocate private data at same time
   	- cleanup error unwinds
   	- call free_netdev.
   
   Builds and loads, but don't have real hardware.

<shemminger@osdl.org> (03/09/20 1.1366)
   [IrDA] via-ircc -- dev_alloc cleanout
   
   Convert via-ircc 2.6.0-test5
   	- use alloc_net_dev not dev_alloc
   	- allocate private data at same time
   	- cleanup error unwinds
   	- call free_netdev.
   
   Builds and loads, but don't have real hardware.

<shemminger@osdl.org> (03/09/20 1.1365)
   [IrDA] nsc-ircc -- dev_alloc cleanout
   
   Cleanup nsc-ircc driver for 2.6.0-test5
   	- replace dev_alloc with alloc_netdev
   	- use private data allocated with alloc_netdev
   	- error unwind cleanup

<shemminger@osdl.org> (03/09/20 1.1364)
   [IrDA] donahoboe -- dev_alloc cleanout
   
   Fixes for donauboe for 2.6.0-test5
   	- replace dev_alloc with alloc_netdev
   	- error unwind cleanup

<shemminger@osdl.org> (03/09/20 1.1363)
   [IrDA] w83977af -- dev_alloc cleanout
   
   Yet another irda driver cleanup for 2.6.0-test5
   	- replace dev_alloc with alloc_netdev
   	- use private data allocated with alloc_netdev
   	- use free_netdev

<shemminger@osdl.org> (03/09/20 1.1362)
   [IrDA] irda-usb -- dev_alloc cleanout
   
   Update irda-usb for 2.6.0-test5
   	- use alloc_netdev (but can't use dev->priv area cause that is allocated elsewhere).

<rddunlap@osdl.org> (03/09/20 1.1361)
   [PATCH] janitor: ns83820 error handling
   
   Subject: Re: [Kernel-janitors] [PATCH] insert missing free_irq and fix 	cleanup path
   From: Leann Ogasawara <ogasawara@osdl.org>
   
   On Thu, 2003-09-04 at 13:17, Benjamin LaHaise wrote:
   > The if()s before free are redundant, turf them and it's good.

<rddunlap@osdl.org> (03/09/20 1.1360)
   [PATCH] janitor: insert a missing iounmap()
   
   From: Leann Ogasawara <ogasawara@osdl.org>
   Subject: [Kernel-janitors] [PATCH] insert missing iounmap()
   
   Patch inserts a missing iounmap().

<shemminger@osdl.org> (03/09/20 1.1359)
   [PATCH] get rid of old IRDA drivers.
   
   According to Jean the toshoboe and old smc ircc drivers are no longer needed.
   This patch removes them from 2.6.0-test5

<chrisw@osdl.org> (03/09/20 1.1358)
   [netdrvr] use cpu_relax() in busy loop, or mdelay instead of busy loop
   
   Replace busy loop nop with cpu_relax(), and just use mdelay where it's better.

<rddunlap@osdl.org> (03/09/20 1.1357)
   [PATCH] janitor: remove (or add) unneeded includes (drivers/net/)
   
   From: Randy Hron <rwhron@earthlink.net>

<rddunlap@osdl.org> (03/09/20 1.1356)
   [PATCH] janitor: remove unneeded includes (hamradio)
   
   From: Randy Hron <rwhron@earthlink.net>

<rddunlap@osdl.org> (03/09/20 1.1355)
   [PATCH] janitor: remove (or add) unneeded includes (wireless)
   
   From: Randy Hron <rwhron@earthlink.net>

<rddunlap@osdl.org> (03/09/20 1.1354)
   [PATCH] janitor: remove unneeded includes (skfp)
   
   From: Randy Hron <rwhron@earthlink.net>

<rddunlap@osdl.org> (03/09/20 1.1353)
   [PATCH] janitor: remove (or add) unneeded includes
   
   From: Randy Hron <rwhron@earthlink.net>

<rddunlap@osdl.org> (03/09/20 1.1352)
   [PATCH] janitor: remove unneeded includes (sk98lin)
   
   From: Randy Hron <rwhron@earthlink.net>

<rddunlap@osdl.org> (03/09/20 1.1351)
   [PATCH] janitor: remove unneeded includes (tokenring)
   
   From: Randy Hron <rwhron@earthlink.net>

<shemminger@osdl.org> (03/09/20 1.1350)
   [PATCH] replace sppp_of macro with inline
   
   Replace macro with inline and get some type checking.

<felipewd@terra.com.br> (03/09/20 1.1349)
   [PATCH] Unneeded memory barrier in net/irda code

<mzyngier@freesurf.fr> (03/09/20 1.1348)
   [PATCH] depca update
   
   I finally found some time to hack the depca driver, in basically the
   same way I did with the de4x5 driver. The patch is quite big (shuffles
   a lot of code around, removes lots of global variables), mainly in
   order to use the driver model on every bus supported by this driver.
   
   I also removed the probing from Space.c, so the usual warning about
   device renumbering applies.
   
   Tested on alpha (DE422, EISA) and i386 (two DE201, ISA), built-in and
   modular. The MCA part is completly untested, since I lack the hardware
   (no, I do not own every single piece of junk hardware out
   there... ;-).

