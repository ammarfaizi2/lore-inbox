Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVEGWSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVEGWSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 18:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVEGWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 18:18:44 -0400
Received: from exo1066.net2.nerim.net ([213.41.175.60]:64645 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S262757AbVEGWSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 18:18:33 -0400
Date: Sun, 8 May 2005 00:18:27 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-hf8
Message-ID: <20050507221827.GA13611@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here comes the eighth hotfix release for kernel 2.4.29. It should be the last
*announced* version, but will silently follow 2.4.30-hf updates. To support
multiple parallel versions, I've inserted a directory level on the site with
the base version number. I prefered risking breaking a few bookmarks now than
adding confusion later. The release is available at usual places :

    http://linux.exosec.net/kernel/2.4-hf/

Small changelog below. Nothing critical there.

Regards,
Willy

Changelog From 2.4.29-hf7 to 2.4.29-hf8 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed


+ 2.4.30-panic-if-more-than-one-moxa-1                         (David Monniaux)

  [PATCH] fix moxa crash with more than one 1 board.
  The current Moxa Intellio driver (moxa.c) panics when using > 1 board.
  Fixed build by declaring variable prior to usage - Willy.

+ 2.4.30-bonding-rmmod-oops-1                                  (Mitch Williams)

  It fixes a stack dump when unloading the bonding module in 802.3ad mode
  if spinlock debugging is turned on, and it was already merged in 2.6.

+ 2.4.29-sk_rmem_alloc-assertion-failure-1                         (Herbert Xu)

  [NETLINK]: Fix sk_rmem_alloc assertion failure in af_netlink.c.
  In netlink_dump we're operating on sk after dropping the cb lock. This is
  racy because the owner of the socket could close it after we drop the cb
  lock. The solution is to hold a ref count on the socket before we drop the
  cb lock.

+ 2.4.30-rwsem-spinlocks-must-disable-interrupts-2              (David Howells)

  [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks.
  The attached patch makes read/write semaphores use interrupt disabling
  spinlocks in the slow path, thus rendering the up functions and trylock
  functions available for use in interrupt context.  This matches the
  regular semaphore behaviour. Typo fixed by Mikael Pettersson.


