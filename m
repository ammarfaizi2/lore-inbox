Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTKWWVI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTKWWVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:21:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:9125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263485AbTKWWVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:21:05 -0500
Date: Sun, 23 Nov 2003 14:27:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][2.6-mm] __kunmap/oprofile final link failure
Message-Id: <20031123142715.170109f5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0311211811040.2498@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0311211811040.2498@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
>  arch/i386/kernel/built-in.o(.text+0x927): In function `__switch_to':
>  arch/i386/kernel/process.c:564: undefined reference to 
>  `__kunmap_atomic_type'
>  arch/i386/kernel/built-in.o(.text+0x92e):arch/i386/kernel/process.c:565: 
>  undefined reference to `__kunmap_atomic_type'
>  arch/i386/kernel/built-in.o(.text+0x939):arch/i386/kernel/process.c:566: 
>  undefined reference to `__kmap_atomic'
>  arch/i386/kernel/built-in.o(.text+0x944):arch/i386/kernel/process.c:567: 
>  undefined reference to `__kmap_atomic'
>  arch/i386/kernel/built-in.o(.text+0x94e):arch/i386/kernel/process.c:572: 
>  undefined reference to `__kmap_atomic_vaddr'
>  arch/i386/oprofile/built-in.o(.text+0x171a): In function 
>  `oprofile_reset_stats':
>  include/asm/bitops.h:251: undefined reference to `cpu_possible_map'
>  arch/i386/oprofile/built-in.o(.text+0x179e): In function 
>  `oprofile_create_stats_files':
>  include/asm/bitops.h:251: undefined reference to `cpu_possible_map'
> 
>  Test compiled with NR_CPUS = 4, 64 and !CONFIG_SMP on i386

OK, there's just way too much compile breakage from the cpu_possible()
changes.  I'll drop them - something which does less reorganisation in the
headers is needed.

