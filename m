Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVEPRtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVEPRtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVEPRtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:49:12 -0400
Received: from mail.portrix.net ([212.202.157.208]:5557 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261477AbVEPRsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:48:52 -0400
Message-ID: <4288DC6D.1020606@ppp0.net>
Date: Mon, 16 May 2005 19:46:21 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050331 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2, alpha and mips broke
References: <20050516021302.13bd285a.akpm@osdl.org>
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing 2.6.12-rc4-mm1 to 2.6.12-rc4-mm2 (defconfig)
======================================================

- alpha: broke
    AR      arch/alpha/lib/lib.a
    GEN     .version
    CHK     include/linux/compile.h
    UPD     include/linux/compile.h
    CC      init/version.o
    LD      init/built-in.o
    LD      .tmp_vmlinux1
  mm/built-in.o(.text+0xe79c):/usr/src/ctest/mm/kernel/mm/slab.c:339: undefined reference to `__bad_size'
  mm/built-in.o(.text+0xe7a0):/usr/src/ctest/mm/kernel/mm/slab.c:339: undefined reference to `__bad_size'
  make[1]: *** [.tmp_vmlinux1] Error 1
  make: *** [_all] Error 2

  Details: http://l4x.org/k/?d=3741

- mips: broke
    CC      mm/mempool.o
    CC      mm/oom_kill.o
    CC      mm/fadvise.o
    CC      mm/page_alloc.o
    CC      mm/page-writeback.o
    CC      mm/pdflush.o
    CC      mm/readahead.o
    CC      mm/slab.o
  mm/slab.c:117:2: #error "Broken Configuration: CONFIG_NUMA not set but MAX_NUMNODES !=1 !!"
  make[1]: *** [mm/slab.o] Error 1
  make: *** [mm] Error 2

  Details: http://l4x.org/k/?d=3753


-- 
Jan
