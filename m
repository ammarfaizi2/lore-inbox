Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262697AbSKDUGB>; Mon, 4 Nov 2002 15:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbSKDUGB>; Mon, 4 Nov 2002 15:06:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262697AbSKDUGA>;
	Mon, 4 Nov 2002 15:06:00 -0500
Subject: Re: [PATCH] performance counters 3.1 for 2.5.45 [4/4]: kernel
	changes
From: Stephen Hemminger <shemminger@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210312310.AAA07615@kim.it.uu.se>
References: <200210312310.AAA07615@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 12:12:19 -0800
Message-Id: <1036440740.18668.5.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 15:10, Mikael Pettersson wrote:
> This is part 4 of 4 of perfctr-3.1 for the 2.5.45 kernel:
> kernel changes to integrate the low and high-level drivers.
> 
> /Mikael
> 
>  CREDITS                              |    1 +
>  MAINTAINERS                          |    6 ++++++
>  arch/i386/Kconfig                    |    1 +
>  arch/i386/kernel/entry.S             |   11 +++++++++++
>  arch/i386/kernel/i8259.c             |    3 +++
>  arch/i386/kernel/process.c           |    9 +++++++++
>  arch/i386/mach-generic/irq_vectors.h |    5 +++--
>  drivers/Makefile                     |    1 +
>  include/asm-i386/apic.h              |    3 +++
>  include/asm-i386/processor.h         |    2 ++
>  include/asm-i386/unistd.h            |    1 +
>  kernel/timer.c                       |    2 ++
>  12 files changed, 43 insertions(+), 2 deletions(-)

Rather than adding yet another system call, shouldn't this be done by
extending the cpu part of sysfs (or /proc)?

It looks like the operations in sys_vperfctr could be easily mapped to a
RAM based file system.  As it stands it reminds me of one of the old DEC
graphic libraries with one API entry for all the operations, and 65
different flag values.



