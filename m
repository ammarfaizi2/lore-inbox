Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVKKGVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVKKGVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 01:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVKKGVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 01:21:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:50921 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932364AbVKKGU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 01:20:59 -0500
Date: Thu, 10 Nov 2005 22:19:20 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.14.2
Message-ID: <20051111061920.GD12008@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.14.2 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.14.1 and 2.6.14.2, as it is small enough to do so.

The updated 2.6.14.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/
 
thanks,

greg k-h

--------

 Makefile                                  |    2 
 drivers/block/cfq-iosched.c               |    4 -
 drivers/net/wireless/airo.c               |    2 
 drivers/net/wireless/airo.h               |    9 ++++
 drivers/net/wireless/airo_cs.c            |    6 --
 drivers/net/wireless/prism54/islpci_eth.c |    7 ---
 drivers/usb/core/sysfs.c                  |   33 ++++++---------
 drivers/usb/core/usb.c                    |   63 ++++++++++--------------------
 fs/exec.c                                 |   10 +++-
 fs/xfs/Kconfig                            |    2 
 include/asm-alpha/barrier.h               |    2 
 kernel/ptrace.c                           |    2 
 kernel/signal.c                           |    2 
 net/core/datagram.c                       |    4 +
 net/ipv4/ipvs/ip_vs_core.c                |    7 +--
 net/ipv4/tcp_bic.c                        |    2 
 16 files changed, 73 insertions(+), 84 deletions(-)

Summary of changes from v2.6.14.1 to v2.6.14.2
==============================================

Adrian Bunk:
      airo.c/airo_cs.c: correct prototypes

Dimitri Puzin:
      fix XFS_QUOTA for modular XFS

Greg Kroah-Hartman:
      USB: always export interface information for modalias
      Linux 2.6.14.2

Herbert Xu:
      NET: Fix zero-size datagram reception

Ivan Kokshaysky:
      fix alpha breakage

Jens Axboe:
      Oops on suspend after on-the-fly switch to anticipatory i/o scheduler - PowerBook5, 4

Julian Anastasov:
      ipvs: fix connection leak if expire_nodest_conn=1

Linus Torvalds:
      Fix ptrace self-attach rule

Oleg Nesterov:
      - fix signal->live leak in copy_process()
      fix de_thread() vs send_group_sigqueue() race

Roger While:
      prism54 : Fix frame length

Stephen Hemminger:
      tcp: BIC max increment too large

