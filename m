Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312074AbSCTT1B>; Wed, 20 Mar 2002 14:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312071AbSCTT0z>; Wed, 20 Mar 2002 14:26:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312074AbSCTT0f>;
	Wed, 20 Mar 2002 14:26:35 -0500
Message-ID: <3C98E23A.2090504@mandrakesoft.com>
Date: Wed, 20 Mar 2002 14:25:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Linux kernel net-drivers-2.4.19-pre3-jg1
Content-Type: multipart/mixed;
 boundary="------------020807090503060801070606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807090503060801070606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.19/net-drivers-2.4.19.3-1.patch.bz2

NOTE!  This patch includes Marcelo's latest BK changesets 
(post-2.4.19-pre3).

Changeset (not including Marcelo's newest changesets) and pull info follow.


--------------020807090503060801070606
Content-Type: text/plain;
 name="net-drivers-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.4.txt"

Marcelo and other BK users, please do a

	bk pull http://gkernel.bkbits.net/net-drivers-2.4

This will update the following files:

 Documentation/networking/dl2k.txt  |    6 
 drivers/net/3c503.c                |    9 
 drivers/net/ac3200.c               |    9 
 drivers/net/acenic.c               |  227 ++++++++----
 drivers/net/acenic.h               |   33 -
 drivers/net/at1700.c               |    1 
 drivers/net/bmac.c                 |    1 
 drivers/net/de4x5.c                |   32 -
 drivers/net/de620.c                |   15 
 drivers/net/dl2k.c                 |  137 +++++--
 drivers/net/dl2k.h                 |    5 
 drivers/net/e2100.c                |   11 
 drivers/net/eepro100.c             |  198 +++++------
 drivers/net/epic100.c              |   12 
 drivers/net/es3210.c               |    9 
 drivers/net/hp-plus.c              |    7 
 drivers/net/hp.c                   |    7 
 drivers/net/hp100.c                |   57 ++-
 drivers/net/lne390.c               |    7 
 drivers/net/ne.c                   |    9 
 drivers/net/ne2k-pci.c             |    6 
 drivers/net/ne3210.c               |    9 
 drivers/net/pcmcia/xircom_cb.c     |  658 +++++++++++++------------------------
 drivers/net/pcnet32.c              |  442 ++++++++++++------------
 drivers/net/sk98lin/skge.c         |   42 ++
 drivers/net/smc-ultra.c            |    7 
 drivers/net/smc-ultra32.c          |    4 
 drivers/net/wd.c                   |    9 
 drivers/net/wireless/orinoco_plx.c |   11 
 drivers/s390/net/ctctty.c          |    2 
 include/asm-i386/checksum.h        |  106 ++---
 31 files changed, 1079 insertions(+), 1009 deletions(-)

through these ChangeSets:

<jgarzik@mandrakesoft.com> (02/03/20 1.242)
   Revert 2.4.18 epic100 net driver power-up sequence "fix".

<jgarzik@mandrakesoft.com> (02/03/20 1.241)
   Merge include/asm-i386/checksum.h from 2.5.7.
   This updates the code to not use multi-line strings in __asm__, a source
   of many gcc 3.x warnings.

<jgarzik@mandrakesoft.com> (02/03/20 1.240)
   Build fix: include linux/crc32.h in bmac net driver.
    
   Noticed by Joshua Uziel.
   

<arjanv@redhat.com> (02/03/20 1.239)
   Move pci_enable_device and associated code above first PCI resource info access.

<arjanv@redhat.com> (02/03/20 1.238)
   eepro100 net driver h/w bug workaround updates:
   Whitespace cleanup on hardware bug check.
   Add udelay(1) after enabling h/w bug workaround, to "make it stick"

<arjanv@redhat.com> (02/03/20 1.237)
   Update eepro100 net driver to properly enable/disable software timer
   at suspend/resume time.

<arjanv@redhat.com> (02/03/20 1.236)
   Implement RX soft reset for certain cases in eepro100 net driver.
     
   Author: Steve Parker @ sun

<arjanv@redhat.com> (02/03/20 1.235)
   Add eepro100 net driver rx soft reset function.
     
   Author: Steve Parker @ Sun

<arjanv@redhat.com> (02/03/20 1.234)
   Increase eepro100 net driver tx/rx ring sizes, to be more appropriate for 100mbit

<arjanv@redhat.com> (02/03/20 1.233)
   Revert xircom_cb net driver back to earlier version which works in all cases.

<go@turbolinux.co.jp> (02/03/20 1.232)
   Update pcnet32 net driver with the following changes:
   v1.27   improved CSR/PROM address detection, lots of cleanups,
          new pcnet32vlb module option, HP-PARISC support,
          added module parameter descriptions, 
          initial ethtool support - Helge Deller <deller@gmx.de>
   v1.27a  Sun Feb 10 2002 Go Taniguchi <go@turbolinux.co.jp>
          use alloc_etherdev and register_netdev
          fix pci probe not increment cards_found
          FD auto negotiate error workaround for xSeries250
          clean up and using new mii module

<p_gortmaker@yahoo.com> (02/03/20 1.231)
   MODULE_DESC net drivers cleanup.
     
   Idea is that if there is a valid name in MODULE_DESCRIPTION("...")
   then the name of the hardware/driver should not be also repeated
   in each MODULE_PARM_DESC("...").  MODULE_DESCRIPTION has been
   added to essentially all the 8390 drivers.
     
   All of the drivers changed are 8390 based, with the exception of
   eepro100 and 3c509.

<brownfld@irridia.com> (02/03/20 1.230)
   Support second port on dual-port SysConnect SK-9844 NICs.

<jgarzik@mandrakesoft.com> (02/03/20 1.229)
   (sync with 2.5.x.  in 2.4.x, this is just a cosmetic change)
   s/foo/DE4X5_foo/ in de4x5 net driver, for 'ALIGN' and 'CACHE'
   constants which may or do indeed conflict with linux/cache.h.

<jgarzik@mandrakesoft.com> (02/03/20 1.228)
   s/kfree/kfree_skb/ in drivers/s390/net/ctctty.c.
   Contributor forgotten :(

<k.kasprzak@box43.pl> (02/03/20 1.227)
   de620 net driver janitor fixes:
   * free_irq on error
   * check request_region return value for error

<jes@wildopensource.com> (02/03/20 1.226)
   Update acenic gigabit ethernet driver to clean up VLAN support integration.

<jgarzik@mandrakesoft.com> (02/03/20 1.225)
   Add pci id to orinoco_plx wireless driver (Brendan McAdams)
   and some CodingStyle cleanups (me)

<jgarzik@mandrakesoft.com> (02/03/20 1.224)
   dl2k net driver updates:
   * Fix race using, s/del_timer/del_timer_sync/
   * CodingStyle cleanups

<edward_peng@dlink.com.tw> (02/03/20 1.223)
   Update dl2k gigabit ethernet driver to watch RX in case of lockup.

<jgarzik@mandrakesoft.com> (02/03/15 1.197.1.11)
   Don't include linux/delay.h twice in eepro100 net driver.
   
   Noticed by alan cox.

<jt@bougret.hpl.hp.com> (02/03/15 1.197.1.10)
   Convert hp100 net driver to PCI DMA mapping API.

<jes@wildopensource.com> (02/03/15 1.197.1.9)
   acenic driver fixes:
   * Fix Tigon I support
   * Fix memory leak

<jes@wildopensource.com> (02/03/15 1.197.1.8)
   acenic gige net driver update:
   * Various small cleanups
   * ETHTOOL_GDRVINFO support

<anton@samba.org> (02/03/15 1.197.1.7)
   pcnet32 net driver updates 6/6:
   perform dwio reset after checking wio, otherwise some cards fail
   the probe, fix from Paul Mackerras

<anton@samba.org> (02/03/15 1.197.1.6)
   pcnet32 net driver updates 5/6:
   pcnet32_purge_tx_ring can be called from interrupt, so must use
   dev_kfree_skb_any, fix from Dave Engebretsen.

<anton@samba.org> (02/03/15 1.197.1.5)
   pcnet32 net driver updates 4/6:
   Increase device watchdog timeout, fix from Dave Engebretsen.

<anton@samba.org> (02/03/15 1.197.1.4)
   pcnet32 net driver updates 3/6:
   protect pcnet32_tx_timeout and pcnet32_set_multicast_list with
   spinlock, fix from Dave Engebretsen

<anton@samba.org> (02/03/15 1.197.1.3)
   pcnet32 net driver updates 2/6:
   irq could overflow unsigned char, change to unsigned int
   ioaddr could overflow unsigned int, change to unsigned long

<jgarzik@mandrakesoft.com> (02/03/15 1.197.1.2)
   pcnet32 net driver update 1/6:
   fix leak in pci memory space on machines with IOMMUs.

<sawa@yamamoto.gr.jp> (02/03/15 1.197.1.1)
   Fix bug in at1700 net driver:
   Make sure to assign RX_MODE in all cases, including multicast.
   Fixes multicast.


--------------020807090503060801070606--

