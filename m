Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265407AbSJaUNn>; Thu, 31 Oct 2002 15:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbSJaUNm>; Thu, 31 Oct 2002 15:13:42 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:65034 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S265407AbSJaUNk>; Thu, 31 Oct 2002 15:13:40 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200210312012.g9VKCOhU014897@wildsau.idv.uni.linz.at>
Subject: Re: need h/e/l/p:  PM -> RM in machine_real_start
In-Reply-To: <200210311952.g9VJqZs9014839@wildsau.idv.uni.linz.at> from "H.Rosmanith" at "Oct 31, 2 08:52:35 pm"
To: kernel@wildsau.idv.uni.linz.at (H.Rosmanith)
Date: Thu, 31 Oct 2002 21:12:24 +0100 (MET)
Cc: root@chaos.analogic.com, kernel@wildsau.idv.uni.linz.at,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Linux leaves the BIOS area alone, but interrupts may not be directly
> > usable because Linux loads a different IDT and reprograms the IO-APIC,
> > which is used in place of the interrupt controller if it exists.
> > 
> what I've never heard of is the IO-APIC (allthough there's a file
> named io_apic.c just in the same directory).

ah, I see ... that's an enhanced interrupt controller which is used
on SMP boards. is it correct that this one is only configured/activated
when:

.config
[...]
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

these options are set? therefore, since this options are off, the
IO-APIC is not being used, correct?

herbert

