Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVGPEuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVGPEuH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 00:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVGPEuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 00:50:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:37848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262194AbVGPEuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 00:50:05 -0400
Date: Fri, 15 Jul 2005 21:48:16 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Linux 2.6.12.3
Message-ID: <20050716044815.GA10063@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.12.3 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.12.2 and 2.6.12.3, as it is small enough to do so.

The updated 2.6.12.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.12.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

----------

 Makefile                                     |    2 
 arch/ppc/kernel/time.c                       |   13 ++--
 arch/um/kernel/process.c                     |   48 ++++++++++-------
 drivers/acpi/pci_irq.c                       |    2 
 drivers/char/tpm/tpm.c                       |   76 ---------------------------
 drivers/char/tpm/tpm.h                       |    2 
 drivers/char/tpm/tpm_atmel.c                 |   16 +++--
 drivers/char/tpm/tpm_nsc.c                   |   16 +++--
 drivers/char/tty_ioctl.c                     |    4 -
 drivers/media/video/cx88/cx88-video.c        |    2 
 drivers/net/hamradio/Kconfig                 |    2 
 drivers/net/shaper.c                         |   40 +++++---------
 fs/char_dev.c                                |    2 
 include/linux/if_shaper.h                    |    2 
 net/ipv4/ip_output.c                         |    3 -
 net/ipv4/netfilter/ip_conntrack_standalone.c |    7 ++
 net/packet/af_packet.c                       |    6 ++
 17 files changed, 93 insertions(+), 150 deletions(-)


Summary of changes from v2.6.12.2 to v2.6.12.3
==============================================

Alexander Nyberg:
  If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.

David S. Miller:
  fix Shaper driver lossage in 2.6.12

Greg Kroah-Hartman:
  Linux 2.6.12.3

john stultz:
  ppc32: stop misusing ntps time_offset value

KAMBAROV, ZAUR:
  coverity: tty_ldisc_ref return null check

Kylene Jo Hall:
  tpm breaks 8139cp

Michael Krufky:
  v4l cx88 hue offset fix

Paolo 'Blaisorblade' Giarrusso:
  uml: fix TT mode by reverting "use fork instead of clone"

Patrick McHardy:
  revert nf_reset change

Ralf Baechle:
  SMP fix for 6pack driver

Wen-chien Jesse Sung:
  fix semaphore handling in __unregister_chrdev_region
