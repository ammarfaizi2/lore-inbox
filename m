Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422823AbWBIGOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWBIGOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWBIGOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:14:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22685 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422823AbWBIGOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:14:43 -0500
Date: Wed, 8 Feb 2006 22:14:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1 patches don't apply
Message-Id: <20060208221434.f48618d1.pj@sgi.com>
In-Reply-To: <20060209055638.GV13729@waste.org>
References: <20060208194359.bd1c1a4b.pj@sgi.com>
	<20060208201644.568379d6.akpm@osdl.org>
	<20060208213025.ef61a679.pj@sgi.com>
	<20060209055638.GV13729@waste.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The git->hg conversion script may be borked right now. 

Ok - since you have suspicions, I will dump what I have found so far,
and pass the baton to your good hands.

The following "facts" are not to be trusted too much, just what I
think I have now.

The following 34 files seem to come up differently in the hg side than
the git side, for 2.6.16-rc2, with the hg side having patches showing
up as already in 2.6.16-rc2, that the git side things showed up later,
after Linus tagged 2.6.16-rc2.

./arch/arm/mach-s3c2410/Makefile
./arch/arm/mm/proc-xscale.S
./arch/cris/Makefile
./arch/ia64/Kconfig
./arch/ia64/kernel/sal.c
./arch/ia64/sn/Makefile
./arch/ia64/sn/kernel/Makefile
./arch/ia64/sn/kernel/bte.c
./arch/ia64/sn/kernel/klconflib.c
./arch/ia64/sn/kernel/setup.c
./arch/ia64/sn/kernel/sn2/Makefile
./arch/ia64/sn/kernel/sn2/sn2_smp.c
./arch/ia64/sn/pci/Makefile
./arch/ia64/sn/pci/pcibr/Makefile
./arch/parisc/Kconfig.debug
./arch/parisc/hpux/entry_hpux.S
./arch/parisc/kernel/parisc_ksyms.c
./arch/parisc/kernel/perf_images.h
./arch/parisc/kernel/signal32.c
./arch/parisc/kernel/signal32.h
./arch/parisc/math-emu/decode_exc.c
./drivers/media/dvb/b2c2/Kconfig
./drivers/media/dvb/b2c2/flexcop-dma.c
./drivers/media/dvb/b2c2/flexcop-misc.c
./drivers/media/dvb/b2c2/flexcop-pci.c
./drivers/media/dvb/bt8xx/bt878.h
./drivers/net/wan/dscc4.c
./include/asm-arm/checksum.h
./include/asm-ia64/sal.h
./include/asm-ia64/sn/bte.h
./include/asm-ia64/system.h
./include/asm-parisc/compat_ucontext.h
./include/asm-parisc/pgalloc.h
./include/asm-parisc/rt_sigframe.h

The linus.patch of 2.6.16-rc2-mm1 won't apply to the git variant
of 2.6.16-rc2, because that *-mm1 tries to apply the changes on the
above files that are already present.

Good luck with it.

Thanks, Matt.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
