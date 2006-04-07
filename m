Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWDGR3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWDGR3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWDGR3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:29:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:48045 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964828AbWDGR3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:29:02 -0400
Date: Fri, 7 Apr 2006 10:23:53 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.2
Message-ID: <20060407172353.GA29863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.2 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.1 and 2.6.16.2, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                      |    2 -
 arch/i386/kernel/cpu/cpufreq/Kconfig          |    1 
 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c    |    2 -
 arch/powerpc/kernel/pci_64.c                  |    1 
 drivers/base/node.c                           |    2 -
 drivers/char/Kconfig                          |    1 
 drivers/char/tlclk.c                          |    1 
 drivers/ieee1394/sbp2.c                       |   32 ++++++++++++--------------
 drivers/net/irda/irda-usb.c                   |    5 ++--
 drivers/net/wireless/Kconfig                  |    5 +++-
 drivers/net/wireless/hostap/hostap_80211_tx.c |    2 -
 drivers/net/wireless/ipw2200.c                |    5 +---
 drivers/pcmcia/ds.c                           |    2 -
 drivers/usb/core/message.c                    |   12 +++++----
 drivers/usb/host/ehci-sched.c                 |   11 ++++----
 drivers/video/cfbimgblt.c                     |    2 -
 fs/nfsd/nfs3proc.c                            |    2 -
 fs/nfsd/nfs4proc.c                            |    2 -
 fs/nfsd/nfsproc.c                             |    2 -
 fs/proc/vmcore.c                              |    4 +--
 fs/sysfs/file.c                               |    2 -
 include/asm-powerpc/floppy.h                  |    5 ++--
 include/linux/fb.h                            |    2 -
 include/linux/proc_fs.h                       |    2 -
 kernel/exec_domain.c                          |    1 
 kernel/fork.c                                 |    2 -
 net/ipv4/fib_trie.c                           |   12 ++++-----
 net/ipv4/netfilter/ip_conntrack_netlink.c     |    2 -
 net/netfilter/nf_conntrack_netlink.c          |    2 -
 sound/isa/opti9xx/opti92x-ad1848.c            |    6 ++++
 sound/pci/hda/patch_realtek.c                 |    2 +
 31 files changed, 75 insertions(+), 59 deletions(-)

Summary of changes from v2.6.16.1 to v2.6.16.2
==============================================

Adrian Bunk:
      PCMCIA_SPECTRUM must select FW_LOADER
      drivers/net/wireless/ipw2200.c: fix an array overun
      AIRO{,_CS} <-> CRYPTO fixes

Andrew Morton:
      tlclk: fix handling of device major

Antonino A. Daplas:
      fbcon: Fix big-endian bogosity in slow_imageblit()

Christoph Lameter:
      Fix NULL pointer dereference in node_read_numastat()

Clemens Ladisch:
      USB: EHCI full speed ISO bugfixes

Dave Jones:
      Mark longhaul driver as broken.

David S. Miller:
      fib_trie.c node freeing fix

Eugene Teo:
      USB: Fix irda-usb use after use

Greg Kroah-Hartman:
      sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
      Linux 2.6.16.2

Horst Schirmeier:
      USB: usbcore: usb_set_configuration oops (NULL ptr dereference)

Janos Farkas:
      pcmcia: permit single-character-identifiers

Jouni Malinen:
      hostap: Fix EAPOL frame encryption

Kirill Korotaev:
      wrong error path in dup_fd() leading to oopses in RCU

Martin Josefsson:
      {ip, nf}_conntrack_netlink: fix expectation notifier unregistration

maximilian attems:
      isicom must select FW_LOADER

NeilBrown:
      knfsd: Correct reserved reply space for read requests.

Sergey Vlasov:
      Fix module refcount leak in __set_personality()

Stefan Richter:
      sbp2: fix spinlock recursion

Stephen Rothwell:
      powerpc: make ISA floppies work again

Takashi Iwai:
      opti9x - Fix compile without CONFIG_PNP
      Add default entry for CTL Travel Master U553W

Venkatesh Pallipadi:
      Fix the p4-clockmod N60 errata workaround.

Vivek Goyal:
      kdump proc vmcore size oveflow fix

