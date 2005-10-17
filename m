Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVJQOtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVJQOtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVJQOtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 10:49:21 -0400
Received: from dsl-62-3-75-185.zen.co.uk ([62.3.75.185]:50848 "EHLO
	natsu.giantx.co.uk") by vger.kernel.org with ESMTP id S1751230AbVJQOtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 10:49:21 -0400
Date: Mon, 17 Oct 2005 15:49:00 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4-mm1 ntfs/namei.c missing compat.h?
Message-ID: <20051017144900.GA2942@giantx.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: nyk <nyk@giantx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like fs/ntfs/namei.c is missing linux/compat.h

  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC [M]  fs/ntfs/namei.o
In file included from include/linux/dcache.h:6,
                 from fs/ntfs/namei.c:23:
include/asm/atomic.h:383: error: syntax error before '*' token
include/asm/atomic.h:384: warning: function declaration isn't a prototype
include/asm/atomic.h: In function 'atomic_scrub':
include/asm/atomic.h:385: error: 'u32' undeclared (first use in this function)
include/asm/atomic.h:385: error: (Each undeclared identifier is reported only once
include/asm/atomic.h:385: error: for each function it appears in.)
include/asm/atomic.h:385: error: syntax error before 'i'
include/asm/atomic.h:386: error: 'i' undeclared (first use in this function)
include/asm/atomic.h:386: error: 'size' undeclared (first use in this function)
include/asm/atomic.h:386: error: 'virt_addr' undeclared (first use in this function)
include/asm/atomic.h:386: warning: left-hand operand of comma expression has no effect
include/asm/atomic.h:386: warning: statement with no effect
include/asm/atomic.h:390: error: memory input 0 is not directly addressable
make[2]: *** [fs/ntfs/namei.o] Error 1
make[1]: *** [fs/ntfs] Error 2
make: *** [fs] Error 2

Compiles fine with #include <linux/compat.h> added to the top of
fs/ntfs/namei.c

If that's the right place for it, of course.

hth
Nyk
-- 
/__
\_|\/
   /\
