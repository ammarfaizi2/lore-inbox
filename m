Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUL0QBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUL0QBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUL0QBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:01:52 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:47268 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261920AbUL0P5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:57:37 -0500
Subject: [BK PATCH] MCA updates for 2.6.10
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 09:57:14 -0600
Message-Id: <1104163035.5295.15.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is one clean up and one disentangling of the MCA_bus variable
(which touches quite a lot of files since originally MCA_bus had to be
defined in processor.h).

The patch is available from:

bk://linux-voyager.bkbits.net/mca-2.6

The shortlog is:

Adrian Bunk:
  o i386 mca.c: small cleanups

Matthew Wilcox:
  o Move MCA_bus to linux/mca.h

And the diffstat:

 arch/i386/kernel/i386_ksyms.c     |    1 -
 arch/i386/kernel/mca.c            |    7 +++++--
 arch/i386/kernel/setup.c          |   13 +++++++++++--
 arch/i386/kernel/time.c           |    5 ++---
 drivers/serial/8250.c             |    3 +--
 include/asm-alpha/processor.h     |    6 ------
 include/asm-arm/processor.h       |    3 ---
 include/asm-arm26/processor.h     |    3 ---
 include/asm-h8300/processor.h     |    5 -----
 include/asm-i386/mca.h            |    3 ---
 include/asm-i386/processor.h      |    5 -----
 include/asm-m68knommu/processor.h |    5 -----
 include/asm-mips/processor.h      |    6 ------
 include/asm-parisc/processor.h    |    3 ---
 include/asm-ppc/processor.h       |    6 ------
 include/asm-ppc64/processor.h     |    6 ------
 include/asm-sh/processor.h        |    6 ------
 include/asm-sh64/processor.h      |    6 ------
 include/asm-sparc/processor.h     |    6 ------
 include/asm-sparc64/processor.h   |    4 ----
 include/asm-v850/processor.h      |    7 -------
 include/asm-x86_64/processor.h    |    6 ------
 include/linux/mca.h               |   14 +++-----------
 23 files changed, 22 insertions(+), 107 deletions(-)

James


