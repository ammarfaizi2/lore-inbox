Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbUDFPaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbUDFPaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:30:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4056 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263873AbUDFPaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:30:23 -0400
Message-ID: <4072CD01.6070408@pobox.com>
Date: Tue, 06 Apr 2004 11:30:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [NET] net driver updates
Content-Type: multipart/mixed;
 boundary="------------080600040902090101010001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080600040902090101010001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


With upstream 2.6.x having been frozen for a while (and will be until 
end of week or so), a bunch of net driver updates have accumulated.

Even though the shortlog output is attached, here's an even shorter summary:
* acenic converted to PCI API (yay!).  Please test.
* new 10gige driver, s2io
* Francois work on r8169, epic100, sis190: PCI DMA, NAPI, other minor 
fixes and cleanups
* 8139cp, pcnet32 updates
* other minor stuff

BK repository:
	http://gkernel.bkbits.net/netdev-2.6

Patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.5-netdev2.patch.bz2

--------------080600040902090101010001
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="changelog.txt"


Andrew Morton:
  o s2io.h: gcc-3.5 build fix

Christoph Hellwig:
  o convert acenic to pci_driver API
  o kill acient compat cruft from acenic

Daniel Ritz:
  o netdev_priv for xirc2ps_cs, nmclan_cs

Domen Puncer:
  o lmc header file not needed

Don Fry:
  o pcnet32 add led blink capability
  o pcnet32 correct name display
  o pcnet32 all printk under netif_msg
  o pcnet32.c add support for 79C976

Fran�ois Romieu:
  o [netdrvr r8169] TX irq handler looping fix
  o [netdrvr r8169] DAC changes
  o [netdrvr r8169] Barrier against compiler optimization
  o [netdrvr r8169] ethtool driver info
  o [netdrvr r8169] DMA api resync
  o [netdrvr sis190] more RX path work
  o [netdrvr sis190] don't use one huge buffer for all RX skb's
  o [netdrvr sis190] add dirty_rx to private structure
  o [netdrvr sis190] separate out RX skb alloc, fill
  o [netdrvr sis190] add helpers
  o [netdrvr sis190] sis190_open() fixes/updates
  o [netdrvr sis190] add pci-disable-device
  o [netdrvr sis190] fix endianness issues
  o [netdrvr epic100] napi fixes
  o [netdrvr epic100] napi 3/3 - transmit path
  o [netdrvr epic100] napi 2/3 - receive path
  o [netdrvr epic100] napi 1/3 - just shuffle some code around
  o [netdrvr epic100] minor cleanups
  o [netdrvr r8169] Rx wrap bug
  o [netdrvr r8169] fix TX race
  o [netdrvr r8169] fix phy initialization loop init
  o [netdrvr r8169] fix rx counter masking bug
  o [netdrvr r8169] fix oops by removing __devinitdata marker
  o 2.6.1-rc1-mm1 - typo of death in the r8169 driver
  o [netdrvr r8169] Stats fix (Fernando Alencar Marótica <famarost@unimep.br>)
  o [netdrvr r8169] Endianness update (original idea from Alexandra N. Kossovsky)
  o [netdrvr r8169] fix RX
  o [netdrvr r8169] Suspend/resume code (Fernando Alencar Marótica)
  o [netdrvr r8169] Modification of the interrupt mask (RealTek)
  o [netdrvr r8169] Driver forgot to update the transmitted bytes counter
  o [netdrvr r8169] Merge of changes from Realtek
  o [netdrvr r8169] Merge of timer related changes from Realtek
  o [netdrvr r8169] Merge of changes done by Realtek to rtl8169_init_one()
  o [netdrvr r8169] Add {mac/phy}_version
  o [netdrvr r8169] Rx copybreak for small packets
  o [netdrvr r8169] Conversion of Tx data buffers to PCI DMA
  o [netdrvr r8169] rtl8169_start_xmit fixes
  o [netdrvr r8169] Conversion of Rx data buffers to PCI DMA
  o [netdrvr r8169] Conversion of Rx/Tx descriptors to consistent DMA

Hirofumi Ogawa:
  o 8139too: more useful debug info for tx_timeout

Jeff Garzik:
  o [netdrvr natsemi] correct DP83816 IntrHoldoff register offset
  o [netdrvr 8139cp] better dev->close() handling, and misc related stuff
  o [netdrvr 8139cp] complete 64-bit DMA (PCI DAC) support
  o [netdrvr 8139cp] use netdev_priv()
  o [netdrvr 8139cp] minor cleanups
  o [NET] define HAVE_NETDEV_PRIV back-compat hook
  o [netdrvr 8139cp] locking cleanups
  o [netdrvr s2io] NAPI build fixes
  o [netdrvr 8139cp] rearrange priv struct, add cacheline-align markers
  o [net/fc iph5526] s/rx_dropped/tx_dropped/ in TX routines
  o [netdrvr s2io] correct an incorrect cleanup I made
  o [netdrvr] Add S2IO 10gige network driver
  o Remove unused compatibility-defines include wan/lmc/lmc_ver.h
  o Manually merge with upstream

Jeff Muizelaar:
  o tc35815 cleanup

Leana Ogasawara:
  o dgrs: add missing iounmaps

Luiz Fernando N. Capitulino:
  o com20020-isa.c warning fix

Pavel Machek:
  o Support newer revisions of broadcoms in b44.c

Randy Dunlap:
  o remove magic '31' for netdev priv. alignment

Scott Feldman:
  o Update MAINTAINERS with new e100/e1000/ixgb maintainers


--------------080600040902090101010001--

