Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275578AbRIZUVW>; Wed, 26 Sep 2001 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275579AbRIZUVO>; Wed, 26 Sep 2001 16:21:14 -0400
Received: from [199.247.156.30] ([199.247.156.30]:58511 "HELO
	whitehorse.blackwire.com") by vger.kernel.org with SMTP
	id <S275578AbRIZUU7>; Wed, 26 Sep 2001 16:20:59 -0400
From: pjordan@whitehorse.blackwire.com
Date: Wed, 26 Sep 2001 11:11:15 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 SMP on powermac3,3 7400. had to hack.
Message-ID: <20010926111115.A22056@panama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

find /usr/src/linux -type f -exec grep mmu_gathers -n {} \; -ls

and for some funny reason, the arch/ppc/mm/init.c is the only one that does not have the lines 

#include <asm/tlb.h>

mmu_gather_t mmu_gathers[NR_CPUS];


in it.


Sorry for no proper patch.  It is too late and I am too lazy.

Anyway, there is some funny video driver issue or something, I have to use prevent xdm from trying to start
or this bugger will hang .. or at least I lose the video display and the monitor power light blinks on and off.

Also if I run gpm and select a line of text on the console I get the highlighted area turning into
funny non-printable characters and happy faces and such.

Good night.

oh: Without the above patch the kernel build fails right at the end when linking mm.o with others and complains
about no reference to mm_gathers in zap_page_reg or something like that.


Peter
