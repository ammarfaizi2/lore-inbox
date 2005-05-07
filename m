Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVEGWZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVEGWZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 18:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVEGWZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 18:25:36 -0400
Received: from exo1066.net2.nerim.net ([213.41.175.60]:390 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261153AbVEGWZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 18:25:28 -0400
Date: Sun, 8 May 2005 00:25:25 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-hf1
Message-ID: <20050507222525.GA23035@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here comes the first hotfix release for kernel 2.4.30 :

    http://linux.exosec.net/kernel/2.4-hf/

It only contains 4 minor patches. Please check small
changelog below. Only compiled on x86 right now, but
I'm testing it on sparc64 and alpha right now in order
to be confident in the first release.

Regards,
Willy


Changelog From 2.4.30 to 2.4.30-hf1 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed


+ 2.4.30-panic-if-more-than-one-moxa-2                         (David Monniaux)

  [PATCH] fix moxa crash with more than one 1 board.
  The current Moxa Intellio driver (moxa.c) panics when using > 1 board.
  Fixed build by declaring variable prior to usage - Willy.

+ 2.4.30-bonding-rmmod-oops-1                                  (Mitch Williams)

  It fixes a stack dump when unloading the bonding module in 802.3ad mode
  if spinlock debugging is turned on, and it was already merged in 2.6.

+ 2.4.30-madvise-must-return-EIO-1                               (Hugh Dickins)

  [PATCH] madvise_willneed -EIO beyond EOF.
  When the rlim_rss was removed from madvise_willneed, we unintentionally
  changed its error when applied to an area wholly beyond end of file: it
  used to report -EIO (whereas 2.6 reports success), it currently reports
  the confusingly inappropriate -EBADF.  Revert to -EIO in that case.

+ 2.4.30-rwsem-spinlocks-must-disable-interrupts-2              (David Howells)

  [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks.
  The attached patch makes read/write semaphores use interrupt disabling
  spinlocks in the slow path, thus rendering the up functions and trylock
  functions available for use in interrupt context.  This matches the
  regular semaphore behaviour. Typo fixed by Mikael Pettersson.

