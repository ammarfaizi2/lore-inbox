Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315711AbSENNWi>; Tue, 14 May 2002 09:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSENNWi>; Tue, 14 May 2002 09:22:38 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:60375 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315711AbSENNWg>;
	Tue, 14 May 2002 09:22:36 -0400
Date: Tue, 14 May 2002 23:21:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] rationalise asm-*/errno.h
Message-Id: <20020514232156.3e997bbc.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the vein of the previous patch ...

I noticed that most of the asm-*/errno.h files are basically
identical.  This patch rationalises them.  It should not change
the kernel object code.  i386 builds.

diffstat:
 asm-alpha/errno.h        |   38 +------------
 asm-arm/errno.h          |  128 ----------------------------------------------
 asm-cris/errno.h         |  130 -----------------------------------------------
 asm-generic/errno-base.h |   39 ++++++++++++++
 asm-generic/errno.h      |  100 ++++++++++++++++++++++++++++++++++++
 asm-i386/errno.h         |  128 ----------------------------------------------
 asm-ia64/errno.h         |  128 ----------------------------------------------
 asm-m68k/errno.h         |  128 ----------------------------------------------
 asm-mips/errno.h         |   37 +------------
 asm-mips64/errno.h       |   37 +------------
 asm-parisc/errno.h       |   36 -------------
 asm-ppc/errno.h          |  127 +--------------------------------------------
 asm-ppc64/errno.h        |  127 +--------------------------------------------
 asm-s390/errno.h         |  129 ----------------------------------------------
 asm-s390x/errno.h        |  130 -----------------------------------------------
 asm-sh/errno.h           |  128 ----------------------------------------------
 asm-sparc/errno.h        |   37 +------------
 asm-sparc64/errno.h      |   37 +------------
 asm-x86_64/errno.h       |  128 ----------------------------------------------
 19 files changed, 173 insertions(+), 1599 deletions(-)

http://www.canb.auug.org.au/~sfr/15-si.1.2.diff.gz

[Just though it was a little big for linux-kernel.]

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
