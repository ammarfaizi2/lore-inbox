Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSJ1Wkv>; Mon, 28 Oct 2002 17:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJ1Wkv>; Mon, 28 Oct 2002 17:40:51 -0500
Received: from smtp.comcast.net ([24.153.64.2]:61119 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261492AbSJ1Wku>;
	Mon, 28 Oct 2002 17:40:50 -0500
Date: Mon, 28 Oct 2002 17:46:51 -0500
From: Tom Vier <tmv@comcast.net>
Subject: conflicting types for sys_swap{on,off} Re: Linux 2.5.44-ac5
In-reply-to: <200210281452.g9SEqwF17910@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021028224651.GA11490@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
References: <200210281452.g9SEqwF17910@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm not sure how to fix this. does anyone have a patch?

make -f kernel/Makefile 
  gcc -Wp,-MD,kernel/.sys.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=sys -DEXPORT_SYMTAB  -c -o kernel/sys.o kernel/sys.c
kernel/sys.c:216: conflicting types for `sys_swapon'
include/linux/swap.h:212: previous declaration of `sys_swapon'
kernel/sys.c:217: conflicting types for `sys_swapoff'
include/linux/swap.h:211: previous declaration of `sys_swapoff'
make[1]: *** [kernel/sys.o] Error 1
make: *** [kernel] Error 2


-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
