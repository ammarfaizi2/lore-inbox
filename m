Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTGTEY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 00:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270582AbTGTEY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 00:24:59 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:11753
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S262093AbTGTEYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 00:24:49 -0400
Date: Sun, 20 Jul 2003 00:39:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: torvalds@osdl.org
Subject: [BK PATCHES] more 2.6.x net driver merges
Message-ID: <20030720043948.GA20201@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Added some more stuff at

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6

Others may download the patch from

ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test1-netdrvr2.patch.bz2

This will update the following files:

 Documentation/networking/ifenslave.c |  346 +-
 MAINTAINERS                          |    4 
 drivers/net/8139too.c                |    4 
 drivers/net/b44.c                    |   54 
 drivers/net/b44.h                    |    2 
 drivers/net/e1000/e1000_ethtool.c    |  101 
 drivers/net/e1000/e1000_main.c       |    2 
 drivers/net/ne2k-pci.c               |    1 
 drivers/net/pcmcia/3c574_cs.c        |    3 
 drivers/net/sk_mca.c                 |   17 
 drivers/net/sk_mca.h                 |    1 
 drivers/net/via-rhine.c              |   17 
 drivers/net/wan/Kconfig              |    3 
 drivers/net/wireless/Kconfig         |   10 
 drivers/net/wireless/Makefile        |    2 
 drivers/net/wireless/airo.c          |  510 +--
 drivers/net/wireless/wl3501.h        | 1764 +++++++---
 drivers/net/wireless/wl3501_cs.c     | 5616 ++++++++++++++++++++++++-----------
 include/linux/ethtool.h              |    2 
 19 files changed, 5835 insertions(+), 2624 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/07/19 1.1548)
   [wireless airo] fix 2.4-isms that break build

<jgarzik@redhat.com> (03/07/19 1.1547)
   [bonding] sync ifenslave with 2.4 (pulls in several bug fixes)

<achirica@telefonica.net> (03/07/19 1.1546)
   [wireless airo] Update to wireless extensions 16 (new spy API).

<achirica@telefonica.net> (03/07/19 1.1545)
   [wireless airo] Update to wireless extensions 15 (add monitor mode).

<achirica@telefonica.net> (03/07/19 1.1544)
   [wireless airo] Return channel in infrastructure mode.

<achirica@telefonica.net> (03/07/19 1.1543)
   [wireless airo] Checks for small packets before transmitting them.

<achirica@telefonica.net> (03/07/19 1.1542)
   [wireless airo] Returns proper status in case of transmission error.

<achirica@telefonica.net> (03/07/19 1.1541)
   [wireless airo] Fix small endianness bug.

<achirica@telefonica.net> (03/07/19 1.1540)
   [wireless airo] Don't call MIC functions if the card doesn't support them.

<achirica@telefonica.net> (03/07/19 1.1539)
   [wireless airo] Don't sleep when the stats are requested.

<achirica@telefonica.net> (03/07/19 1.1538)
   [wireless airo] Make locking "per thread" so it's fully preemptive.

<achirica@telefonica.net> (03/07/19 1.1537)
   [wireless airo] Update structs with the new fields in latest firmwares.

<achirica@telefonica.net> (03/07/19 1.1536)
   [wireless airo] Simplify dynamic buffer code in Cisco extensions.

<spse@secret.org.uk> (03/07/19 1.1535)
   [PATCH] 3c574_cs initialise spinlock
   
   This patch against 2.5.75 initialises a spinlock when the structure containing
   it is allocated

<petero2@telia.com> (03/07/19 1.1534)
   [PATCH] Software suspend and RTL 8139too in 2.6.0-test1
   
   This patch is needed to make software suspend work with the 8139too
   driver loaded.

<rl@hellgate.ch> (03/07/19 1.1533)
   [PATCH] via-rhine 1.19-2.5: One more Rhine-I fix
   
   This patch fixes another way the Rhine-I found to break down under load. It
   should bring Rhine-I behavior on par with the Rhine-II.

<buffer@antifork.org> (03/07/19 1.1532)
   [PATCH] sk_mca

<scott.feldman@intel.com> (03/07/19 1.1531)
   [PATCH] Add ethtool TSO, Rx/Tx csum, SG Get/Set support
   
   * Add ethtool TSO, Rx/Tx csum, SG Get/Set support.

<scott.feldman@intel.com> (03/07/19 1.1530)
   [PATCH] add ethtool TSO get/set
   
   * Add TSO get/set command to ethtool interface.  Applies to both 2.4/2.5.
     Ethtool application patch sent under separate cover.

<shemminger@osdl.org> (03/07/19 1.1529)
   [PATCH] mark comx obsolete, by request

<daniel.ritz@gmx.ch> (03/07/19 1.1528)
   [PATCH] fix ne2k-pci memleak
   
   ne2k-pci leaks memory on unload. dev->priv is allocated in ethdev_init(), but
   never freed. against 2.4-bk, but also applies to 2.5-bk with offset.

<pp@netppl.fi> (03/07/19 1.1527)
   [netdrvr b44] tons of fixes. should work now.

<gorgo@thunderchild.debian.net> (03/07/19 1.1525)
   [netdrvr wan] update comx maintainer, by request
   
   Previous entry said to be out of date by two years or more.

<acme@conectiva.com.br> (03/07/18 1.1310.96.56)
   o wl3501: cleanup types

<acme@conectiva.com.br> (03/07/18 1.1310.96.55)
   o wl3501: slow_down_io exists only on __i386___
   
   The joys of having several arches at my home lab, thanks
   to parisc this time.

<acme@conectiva.com.br> (03/07/17 1.1310.96.54)
   o wl3501: first cut at power management support

<acme@conectiva.com.br> (03/07/17 1.1310.96.53)
   o wl3501: remove lots of uneeded casts

<acme@conectiva.com.br> (03/07/17 1.1310.96.52)
   o wl3501: create iw_default_channel
   
   Also aimed at being moved to the core wireless extensions code.

<acme@conectiva.com.br> (03/07/17 1.1310.96.51)
   o wl3501: create iw_valid_channel
   
   To validade if a channel is OK in a specific regulatory domain, I
   prefixed it with iw_ as I plan to move this stuff to the main
   wireless extensions code, ditto for the next changeset, where I'll
   introduce iw_chan2freq and iw_default_channel.

<acme@conectiva.com.br> (03/07/17 1.1310.96.50)
   o wl3501: use more c99 style struct initializers

<acme@conectiva.com.br> (03/07/16 1.1310.96.49)
   o wl3501: keep it simple, support only ARPHRD_ETHER packets

<acme@conectiva.com.br> (03/07/16 1.1310.96.48)
   o wl3501: nuke def_chan, useless
   
   But I still didn't managed to change the channel on the
   firmware... will implement wl3501_set_mib_value...

<acme@conectiva.com.br> (03/07/16 1.1310.96.47)
   o wl3501: use c99 init style for the signals
   
   also remove some unneeded casts.

<acme@conectiva.com.br> (03/07/15 1.1310.96.46)
   o wl3501: create wl3501_esbq_exec to avoid cut'n'paste in several functions

<acme@conectiva.com.br> (03/07/15 1.1310.96.45)
   o wl3501: use the regulatory domain defines
   
   I.e. less magic numbers, also rename freq_domain to reg_domain, as
   in regulatory domain, as the atmel driver does, and that made me
   realize that this defines and the function that checks if a channel
   is valid in a regulatory domain should be moved to the wireless
   extensions (or some other place) common code.

<acme@conectiva.com.br> (03/07/15 1.1310.96.44)
   o wl3501: remove llc_type stuff, not used

<acme@conectiva.com.br> (03/07/09 1.1310.96.43)
   o wl3501: remove duplicate assignment of link->irq.IRQInfo2

<acme@conectiva.com.br> (03/07/07 1.1310.96.42)
   o wl3501: kill wl3501_mac_addr, to follow the de-facto standard for mac addrs

<acme@conectiva.com.br> (03/07/07 1.1310.96.41)
   o wl3501: kill wl3501_80211_data_mac_hdr, we already have ieee802_11_hdr

<acme@conectiva.com.br> (03/07/07 1.1310.96.40)
   o wl3501: argh, WL3501_MIB_ATTR_{SHORT,LONG}_RETRY_LIMIT is u8

<acme@conectiva.com.br> (03/07/07 1.1310.96.39)
   o wl3501: fix some mib variables sizes
   
   Following what is in the 802.11 specs and doing
   experimentations.

<acme@conectiva.com.br> (03/07/07 1.1310.96.38)
   o wl3501: remove dead code that was surviving from original driver
   
   It never was used for anything meaningful, i.e. driver_state never
   is set to non zero.

<acme@conectiva.com.br> (03/07/06 1.1310.96.37)
   o wl3501: kill magic numbers in cap_info, fix bss_type setting
   
   it was only setting INFRA mode...

<acme@conectiva.com.br> (03/07/06 1.1310.96.36)
   o wl3501: kill WL3501_SLOW_DOWN_IO, use slow_down_io() instead
   
   Also fix some loop variables use, one of which potentially is
   related to ADHOC not working, i.e. it was not being properly
   initialized, thanks to gcc 3.3.1 (pre-release) and this was
   caught...

<acme@conectiva.com.br> (03/07/06 1.1310.96.35)
   o wl3501: remove more unused code in wl3501.h
   
   will be back in some way with iwpriv support.

<acme@conectiva.com.br> (03/07/02 1.1310.96.34)
   o wl3501: remove commented out code
   
   Will get back to this at some point.

<acme@conectiva.com.br> (03/07/02 1.1310.96.33)
   o wl3501: revert the change to get_encode wrt priv_opt_implemented
   
   It turns out that the first implementation of get_encode was right
   wrt checking WL3501_MIB_ATTR_PRIV_OPT_IMPLEMENTED, according to
   the "802.12 Wireless Networks - The Definitive Guide" O'Reilly book,
   so, put it back in.

<acme@conectiva.com.br> (03/07/02 1.1310.96.32)
   o wl3501: kill a race in wl3501_get_mib_value and more
   
   . collect statistics in wl3501_get_wireless_stats
   . WL3501_MIB_ATTR_PRIV_OPT_IMPLEMENTED doesn't seems
     to be related to WEP, remove its test in get_encode

<acme@conectiva.com.br> (03/07/01 1.1310.96.31)
   o wl3501: implement get retry wireless extension

<acme@conectiva.com.br> (03/07/01 1.1310.96.30)
   o wl3501: implement get tx power wireless extension

<acme@conectiva.com.br> (03/07/01 1.1310.96.29)
   o wl3501: implement get power wireless extension
   
   Now to study how to enable power management.

<acme@conectiva.com.br> (03/07/01 1.1310.96.28)
   o wl3501: implement get encode wireless extension
   
   . Well, this is just for completeness, as with this specific
     firmware in the cards I have WEP is not implemented...
     This is the information for the cards I have (tested just one
     but I doubt the others have WEP...):
     Card Name: OEM WLAN/WPCMCIA
     Firmware Date: 02.00.06 01/07/2000 12:13:49

<acme@conectiva.com.br> (03/07/01 1.1310.96.27)
   o wl3501: implement get frag threshold wireless extension

<acme@conectiva.com.br> (03/07/01 1.1310.96.26)
   o wl3501: use the MIB stuff in this card, add one more wireless extension
   
   . Using the MIB in the card I'm now able to find lots of useful information
     that will get used in more support for wireless extensions.
   . Also some cleanups wrt ifdefing the code not yet used to write into the
     flash of this card and some more messages tidy up.

<acme@conectiva.com.br> (03/07/01 1.1310.96.25)
   o wl3501: use offsetof(struct wl3501_{rx,tx}_hdr, addr4) in more places

<acme@conectiva.com.br> (03/07/01 1.1310.96.24)
   o wl3501: merge some bits from yet another fork of the original sources
   
   This time from work done by Heiko Kirschke, and also do some
   simplification wrt access to ->addr4 in tx headers, i.e. use
   offsetoff and do just one wl3501_set_to_wla in wl3501_send_pkt.

<acme@conectiva.com.br> (03/07/01 1.1310.96.23)
   o wl3501: initialize link->release timer and use alloc_etherdev

<acme@conectiva.com.br> (03/07/01 1.1310.96.22)
   o wl3501: clarify arp type checking in wl3501_md_ind_interrupt
   
   Information collected from another driver source found on the net
   for this hardware, written by magyver@zcom.com.tw, that I'm
   reading to find more information about this hardware, coalescing
   several efforts to have a driver for this card.

<acme@conectiva.com.br> (03/07/01 1.1310.96.21)
   o wl3501: update this->rssi at wl3501_md_ind_interrupt
   
   Now the sensitivity information in iwconfig is dinamically
   updated.

<acme@conectiva.com.br> (03/07/01 1.1310.96.20)
   o wl3501: finally a sane use for this->def_chan!
   
   With this we can finally select in a sane way the channel to use,
   selectable thru wireless extensions/iwconfig interface freq nr_channel
   :-)

<acme@conectiva.com.br> (03/07/01 1.1310.96.19)
   o wl3501: kill one magic number, introducing WL3501_ESSID_MAX_LEN

<acme@conectiva.com.br> (03/07/01 1.1310.96.18)
   o wl3501: the first two chars in this->essid are special
   
   . The real BSSID is after the first two bytes, that is why this->bssid
     has 34 chars when IW_ESSID_MAX_SIZE is just 32...
   . Include some debug, selectable with the pc_debug kernel module
     parameter, that is turned off by default.

<acme@conectiva.com.br> (03/06/30 1.1310.96.17)
   o wl3501: use wl3501_reset when changing some parameters

<acme@conectiva.com.br> (03/06/29 1.1310.96.16)
   o wl3501: first cut at adding set_freq wireless extension
   
   This will require further study and probably to include the MIB stuff
   in the original driver.

<acme@conectiva.com.br> (03/06/29 1.1310.96.15)
   o wl3501: implement get_rate wireless extension
   
   For now returning a fixed rate of 2 Mbit/s, that is by far
   the most common for this thing, but perhaps this card can
   work at 1 Mbit/s and so I have to find out from were to get
   this info, without documentation coding drivers is, humm,
   "fun" :-\

<acme@conectiva.com.br> (03/06/29 1.1310.96.14)
   o wl3501: subtract one from this->channel to get the correct frequency

<acme@conectiva.com.br> (03/06/29 1.1310.96.13)
   o wl3501: do proper tx throttling
   
   . check if queue was stopped when receiving interrupt tx confirmation,
     prior to calling netif_wake_queue.
   . stop the queue processing if there is less than 2 tx blocks in the
     card, with this I get no drops in pktgen, whee! 8)

<acme@conectiva.com.br> (03/06/29 1.1310.96.12)
   o wl3501: create channel to frequency table and use it in get_freq
   
   This table was obtained from the Planet WAP 1000 Access Point web
   interface, accessing it over this driver after I ran nmap against
   the AP box that is now only with the wireless interface, i.e. all
   accesses to it are over this driver :-)

<acme@conectiva.com.br> (03/06/29 1.1310.96.11)
   o wl3501: remove leftover debug from get_freq

<acme@conectiva.com.br> (03/06/29 1.1310.96.10)
   o wl3501: more wireless extensions: {get,set}_nick and get_freq

<acme@conectiva.com.br> (03/06/29 1.1310.96.9)
   o wl3501: update tx statistics

<acme@conectiva.com.br> (03/06/28 1.1310.96.8)
   o wl3501: restructure netdev handling and kill card_start abomination

<acme@conectiva.com.br> (03/06/28 1.1310.96.7)
   o wl3501: implement some more wireless extensions
   
   Also reorganize wl3501_card struct a bit to avoid wasting some
   bytes.
   
   This time get_sense and set_wap wireless extensions were added,
   work in progress, ya know 8)

<acme@conectiva.com.br> (03/06/28 1.1310.96.6)
   o wl3501: initial batch of support for wireless extensions and ethtool

<acme@conectiva.com.br> (03/06/27 1.1310.96.5)
   o wl3501: tidy up wl3501_ioctl
   
   . check if the device is present, bail out if not
   . move the buffer to the place where it is used
   . check the size of the firmware buffer passed from userspace
   . make wl3501_write_flash return -EIO on failure, 0 on success

<acme@conectiva.com.br> (03/06/27 1.1310.96.4)
   o wl3501: move some variable declaration to where they are needed

<acme@conectiva.com.br> (03/06/27 1.1310.96.3)
   o wl3501: add locking in the interrupt handler

<acme@conectiva.com.br> (03/06/27 1.1310.96.2)
   o wl3501: remove stupid loop

<acme@conectiva.com.br> (03/06/26 1.1310.60.10)
   o wl3501: remove comment about supporting wireless extensions
   
   It will, but is not supporting now, just some basic skeleton is
   in place.

<acme@conectiva.com.br> (03/06/26 1.1310.60.9)
   o wl3501: uncomment spin_lock usage, working well, have to stress this thing more now

<acme@conectiva.com.br> (03/06/26 1.1310.60.8)
   o wl3501: disabling the stupid loop for now, working well...

<acme@conectiva.com.br> (03/06/26 1.1310.60.7)
   o wl3501: use eth_copy_and_sum, assorted cleanups

<acme@conectiva.com.br> (03/06/26 1.1310.60.6)
   o wl3501: fix the bug that prevented us from reliably using MTU ~> WL3501_BLKSZ

<acme@conectiva.com.br> (03/06/26 1.1310.60.5)
   o wl3501: reorganization
   
   . use enun instead of tons of #defines
   . put the initial smp locking, still commented out
   . use some defines for magic numbers
   . break the rx_interrupt routine in multiple inlines for each signal
     type
   . CodingStyle cleanups
   . Activated the stupid loop, will now try without it, works? kill this
     stupidity

<acme@conectiva.com.br> (03/06/21 1.1310.48.6)
   o wl3501: new wireless driver for Planet WL 3501 802.11 PCMCIA card
   
   After a long while, and with wireless becoming a hot topic, at least
   for me, I get back to work on this driver, Aristeu, Niemeyer, Marcelino,
   this will finally be integrated! Whee! :-)

