Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSFTG63>; Thu, 20 Jun 2002 02:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSFTG62>; Thu, 20 Jun 2002 02:58:28 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:64994 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318132AbSFTG62>;
	Thu, 20 Jun 2002 02:58:28 -0400
Date: Thu, 20 Jun 2002 16:57:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consolidate include/asm/signal.h
Message-Id: <20020620165750.6d621e68.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[It occurred to me that this patch may not have made it to LKML due to
its size, so here it is with a URL]

Hi all,

Have I gone too far this time? :-)

This patch consolidates most of the common signal.h stuff between
architectures into include/asm-generic/signal.h.  It builds fine
on i386, but may have broken all the other architectures despite
being careful.

Please test (at least a build) and/or comment.

http://www.canb.auug.org.au/~sfr/22-sfr.5.diff.gz

diffstat looks like this:
 asm-alpha/signal.h   |   62 --------------
 asm-arm/signal.h     |  128 ------------------------------
 asm-cris/signal.h    |  126 ------------------------------
 asm-generic/signal.h |  212 +++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-i386/signal.h    |  126 ------------------------------
 asm-ia64/signal.h    |   83 ++-----------------
 asm-m68k/signal.h    |  126 ------------------------------
 asm-mips/signal.h    |   46 +----------
 asm-mips64/signal.h  |   40 +--------
 asm-parisc/signal.h  |   72 ++++-------------
 asm-ppc/signal.h     |  100 ------------------------
 asm-ppc64/signal.h   |   96 -----------------------
 asm-s390/signal.h    |  104 -------------------------
 asm-s390x/signal.h   |  104 -------------------------
 asm-sh/signal.h      |  114 ---------------------------
 asm-sparc/signal.h   |   75 +++++-------------
 asm-sparc64/signal.h |   72 ++++-------------
 asm-x86_64/signal.h  |  108 +------------------------
 18 files changed, 326 insertions(+), 1468 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
