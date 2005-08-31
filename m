Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVHaHDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVHaHDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVHaHDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:03:23 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:60054 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932384AbVHaHDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:03:22 -0400
Date: Wed, 31 Aug 2005 16:47:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Cleanup asm/fcntl.h
Message-Id: <20050831164738.6cee5830.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches creates asm-generic/fcntl.h and consolidates as much
as possible from the asm-*/fcntl.h files into it.  Last time I posted
this, it caused no discussion at all - therefore people must agree with
it.  :-)

I have built this for ppc64 (various configs) and ppc.

The patch split up is so that people can convince themselves at each
stage that the changes are correct by inspection.

Please apply.

 include/asm-alpha/fcntl.h   |   35 ----------
 include/asm-arm/fcntl.h     |   78 -----------------------
 include/asm-arm26/fcntl.h   |   76 ----------------------
 include/asm-cris/fcntl.h    |   91 --------------------------
 include/asm-frv/fcntl.h     |   89 --------------------------
 include/asm-generic/fcntl.h |  149 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-h8300/fcntl.h   |   78 -----------------------
 include/asm-i386/fcntl.h    |   89 --------------------------
 include/asm-ia64/fcntl.h    |   78 +----------------------
 include/asm-m32r/fcntl.h    |   93 ---------------------------
 include/asm-m68k/fcntl.h    |   78 -----------------------
 include/asm-mips/fcntl.h    |   75 ++--------------------
 include/asm-parisc/fcntl.h  |   56 ----------------
 include/asm-powerpc/fcntl.h |   11 +++
 include/asm-ppc/fcntl.h     |   93 ---------------------------
 include/asm-ppc64/fcntl.h   |   89 --------------------------
 include/asm-s390/fcntl.h    |   98 ----------------------------
 include/asm-sh/fcntl.h      |   89 --------------------------
 include/asm-sh64/fcntl.h    |    6 --
 include/asm-sparc/fcntl.h   |   61 +-----------------
 include/asm-sparc64/fcntl.h |   46 +------------
 include/asm-v850/fcntl.h    |   78 -----------------------
 include/asm-x86_64/fcntl.h  |   77 ----------------------
 include/asm-xtensa/fcntl.h  |   48 +-------------
 24 files changed, 194 insertions(+), 1567 deletions(-)
 create mode 100644 include/asm-generic/fcntl.h
 create mode 100644 include/asm-powerpc/fcntl.h
 delete mode 100644 include/asm-ppc/fcntl.h
 delete mode 100644 include/asm-ppc64/fcntl.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
