Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUHKWSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUHKWSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268273AbUHKWSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:18:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17367 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268271AbUHKWSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:18:32 -0400
Date: Thu, 12 Aug 2004 00:18:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc4-mm1: legacy_va_layout compile error with SYSCTL=n
Message-ID: <20040811221825.GM26174@fs.tum.de>
References: <20040810002110.4fd8de07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810002110.4fd8de07.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:21:10AM -0700, Andrew Morton wrote:
>...
> All 529 patches:
>...
> sysctl-tunable-for-flexmmap.patch
>   sysctl tunable for flexmmap
>...

This patch breaks compilation with CONFIG_SYSCTL=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/i386/mm/built-in.o(.text+0x1cd6): In function `arch_pick_mmap_layout':
: undefined reference to `sysctl_legacy_va_layout'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

