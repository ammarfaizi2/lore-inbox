Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263265AbTCUFSL>; Fri, 21 Mar 2003 00:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263266AbTCUFSL>; Fri, 21 Mar 2003 00:18:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15263 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263265AbTCUFSG>;
	Fri, 21 Mar 2003 00:18:06 -0500
Message-ID: <3E7AA337.5000402@pobox.com>
Date: Fri, 21 Mar 2003 00:29:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: [BK PATCH] net driver merges
Content-Type: multipart/mixed;
 boundary="------------090202050203080509050606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090202050203080509050606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------090202050203080509050606
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/e100/e100_vendor.h     |  311 -----
 Documentation/networking/e100.txt  |    9 
 Documentation/networking/e1000.txt |  132 +-
 MAINTAINERS                        |    5 
 drivers/net/3c509.c                |   44 
 drivers/net/8390.h                 |    3 
 drivers/net/Kconfig                |   56 +
 drivers/net/Makefile               |    1 
 drivers/net/Makefile.lib           |    1 
 drivers/net/Space.c                |    2 
 drivers/net/at1700.c               |  120 ++
 drivers/net/e100/e100.h            |   15 
 drivers/net/e100/e100_config.c     |   21 
 drivers/net/e100/e100_config.h     |    4 
 drivers/net/e100/e100_eeprom.c     |    2 
 drivers/net/e100/e100_main.c       |  272 +++--
 drivers/net/e100/e100_phy.c        |   38 
 drivers/net/e100/e100_phy.h        |    4 
 drivers/net/e100/e100_test.c       |    5 
 drivers/net/e100/e100_ucode.h      |    2 
 drivers/net/e1000/e1000.h          |   32 
 drivers/net/e1000/e1000_ethtool.c  |  104 --
 drivers/net/e1000/e1000_hw.c       | 1920 ++++++++++++++++++++++++++-----------
 drivers/net/e1000/e1000_hw.h       |  303 +++++
 drivers/net/e1000/e1000_main.c     |  834 ++++++++++------
 drivers/net/e1000/e1000_osdep.h    |   24 
 drivers/net/e1000/e1000_param.c    |   85 +
 drivers/net/ne2k_cbus.c            |  879 ++++++++++++++++
 drivers/net/ne2k_cbus.h            |  481 +++++++++
 drivers/net/tg3.c                  |    8 
 30 files changed, 4243 insertions(+), 1474 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/03/21 1.1189)
   [netdrvr tg3] fix memleak in DMA test
   
   Also, bump version to 1.5.
   
   Leak fix contributed by Don Fry @ IBM

<cramerj@intel.com> (03/03/20 1.1171.1.17)
   [E1000] NAPI re-insertion w/ changes
   
   * Previous patch wiped NAPI support, adding it back here.  But,
     with a twist: this one doesn't disable/enable interrupts each
     time we enter/leave polling.  (It's EXPERIMENTAL).

<cramerj@intel.com> (03/03/20 1.1171.1.16)
   [E1000] whitespace fix from previous patches
   
   * Corrected indentation from previous patches

<cramerj@intel.com> (03/03/20 1.1171.1.15)
   [E1000] Controller wake-up thru ASF fix
   
   * Fixed controller wake-up through ASF

<cramerj@intel.com> (03/03/20 1.1171.1.14)
   [E1000] Added Interrupt Throttle Rate tuning support
   
   * Added Interrupt Throttle Rate tuning support

<cramerj@intel.com> (03/03/20 1.1171.1.13)
   [E1000] Added Tx FIFO flush routine
   
   * Added method to flush Tx FIFO after link disconnect; the hardware
     hangs on to Tx skb's that were in flight prior to link loss

<cramerj@intel.com> (03/03/20 1.1171.1.12)
   [E1000] Whitespace changes
   
   * Miscellaneous whitespace changes

<cramerj@intel.com> (03/03/20 1.1171.1.11)
   [E1000] Compaq to HP branding change
   
   * Changed "Compaq" branding to "HP"

<cramerj@intel.com> (03/03/20 1.1171.1.10)
   [E1000] Read/Write register macro optimizations
   
   * Optimized E1000_*_REG macros

<cramerj@intel.com> (03/03/20 1.1171.1.9)
   [E1000] Tx Descriptor cleanup
   
   * Completely clean Tx descriptor to avoid potential dirty descriptor
     fetching (rare, but possible)

<cramerj@intel.com> (03/03/20 1.1171.1.8)
   [E1000] Perform single PCI read per interrupt
   
   * ISR cleanup; performing single PCI read

<cramerj@intel.com> (03/03/20 1.1171.1.7)
   [E1000] Modulus math removed
   
   * Removed modulus math; decreases CPU utilization, especially on PPC64
     [anton@samba.org]

<cramerj@intel.com> (03/03/20 1.1171.1.6)
   [E1000] Added MII support
   
   * Added MII support

<cramerj@intel.com> (03/03/20 1.1171.1.5)
   [E1000] Added 82541 & 82547 support
   
   * Added support for 82541 and 82547 gigabit ethernet adapters

<cramerj@intel.com> (03/03/20 1.1171.1.4)
   [E1000] IRQ registration fix
   
   * Fixed IRQ registration bug; IRQ now registered after resources are
     acquired

<cramerj@intel.com> (03/03/20 1.1171.1.3)
   [E1000] Spd/dplx abstraction; eeprom size changes
   
   * Setting speed/duplex is now it's own routine
   * Update ETHTOOL_GEEPROM routine to use new eeprom size variable

<cramerj@intel.com> (03/03/20 1.1171.1.2)
   [E1000] Version, copyright, changelog and MAINTAINERS
   
   * Version, copyright, changelog and MAINTAINERS updates

<cramerj@intel.com> (03/03/20 1.1171.1.1)
   [E1000] Documentation/networking/e1000.txt updates
   
   * Documentation/networking/e1000.txt updates

<tomita@cinet.co.jp> (03/03/20 1.1187)
   [PATCH] Support PC-9800 subarchitecture (9/14) NIC
   
   This is the patch to support NEC PC-9800 subarchitecture
   against 2.5.65-ac1. (9/14)
   
   C-bus(PC98's legacy bus like ISA) network cards support.
   Change IO port and IRQ assign.
   Add NE2000 compatible driver for PC-9800.
     PCI netwwork card works fine without patch.
   
   Regards,
   Osamu Tomita

<scott.feldman@intel.com> (03/03/20 1.1186)
   [E100] ASF wakeup enabled, but only if set in EEPROM
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Check if ASF is enabled in EEPROM, and if so, enable
     PME wakeup when suspending.

<scott.feldman@intel.com> (03/03/20 1.1185)
   [E100] ethtool EEPROM and GSTRING fixes
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Bug fix: read wrong byte in EEPROM when offset is odd number
   * Bug fix: memory leak in ETHTOOL_GSTRINGS
     [Oleg Drokin <green@linuxhacker.ru]

<scott.feldman@intel.com> (03/03/20 1.1184)
   [E100] Validate updates to MAC address
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Validate updates to MAC address as valid ethernet address.

<scott.feldman@intel.com> (03/03/20 1.1183)
   [E100] interrupt handler free fix
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Bug fix on e100_close when repeating hot remove/hot add
     from team.  Basically need to disable interurpts and
     unregister handler before shutting h/w down.
   * Need to mask only the relevant bits in the interrupt
     status register

<scott.feldman@intel.com> (03/03/20 1.1182)
   [E100] Honor WOL settings in EEPROM
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Honor WOL settings in EEPROM: only advertise WOL magic
     packet if in EEPROM.

<scott.feldman@intel.com> (03/03/20 1.1181)
   [E100] ICH5 support added
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * ICH5 support: chipset integrated LAN (8255x)
   * PHY loopback diags is broken on all ICHs

<scott.feldman@intel.com> (03/03/20 1.1180)
   [E100] forced speed/duplex link recover
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Bug fix when changing to non-autoneg, device may lose
     link with some switches, so try to recover link by
     forcing PHY.

<scott.feldman@intel.com> (03/03/20 1.1179)
   [E100] Banish strong branding marketing strings
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Get rid of all of the strong marketing brand strings
     and replace with simple pci_device_id table.  pci.ids
     should be the master list for device ID/strings.

<scott.feldman@intel.com> (03/03/20 1.1178)
   [E100] Bug fix on setting up Tx csum
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Bug fix on setting up Tx csum

<scott.feldman@intel.com> (03/03/20 1.1177)
   [E100] Clean up #include order
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * clean up #includes

<scott.feldman@intel.com> (03/03/20 1.1176)
   [E100] Add support for VLAN hw offload
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Add support for VLAN hw offload

<scott.feldman@intel.com> (03/03/20 1.1175)
   [E100] Spelling mistakes
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Spelling mistakes

<scott.feldman@intel.com> (03/03/20 1.1174)
   [E100] update version, copyright year, changelog
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Update version, copyright year, changelog

<scott.feldman@intel.com> (03/03/20 1.1173)
   [E100] Update Documentation/networking/e100.txt
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Update Documentation/networking/e100.txt

<scott.feldman@intel.com> (03/03/20 1.1172)
   [E100] back out memleak patch cuz it messed up following
   
   On Thu, 20 Mar 2003, Scott Feldman wrote:
   
   
   * Back this patch out - we'll add it later.  I was working against
     2.5.64 when this was checked into 2.5.65, so it messed up
     my patches.


--------------090202050203080509050606--

