Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312942AbSD2RRA>; Mon, 29 Apr 2002 13:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312944AbSD2RRA>; Mon, 29 Apr 2002 13:17:00 -0400
Received: from [62.98.18.61] ([62.98.18.61]:20228 "EHLO
	slackware.alcatrazz.org") by vger.kernel.org with ESMTP
	id <S312942AbSD2RQ6>; Mon, 29 Apr 2002 13:16:58 -0400
Date: Mon, 29 Apr 2002 19:15:41 +0200
From: blitzkrieg <blitzkrieg@sitoverde.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.11 SMP, APIC, build breaks
Message-ID: <20020429191540.A12574@slackware.alcatrazz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Programming-Style-QOTD: Use debugging compilers.
X-Peace: kill -9 `pidof war`
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
I was trying to compile 2.5.11, I noticed that if 
# CONFIG_SMP is not set

	and
	
# CONFIG_X86_LOCAL_APIC is not set
# CONFIG_X86_IO_APIC is not set

the build breaks with the following errors

arch/i386/kernel/kernel.o: In function `intel_thermal_interrupt':
arch/i386/kernel/kernel.o(.text+0x7271): undefined reference to `ack_APIC_irq'
arch/i386/kernel/kernel.o: In function `intel_init_thermal':
arch/i386/kernel/kernel.o(.text.init+0x2ad2): undefined reference to `apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2b12): undefined reference to `apic_write_around'
arch/i386/kernel/kernel.o(.text.init+0x2b31): undefined reference to `apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2b41): undefined reference to `apic_write_around'
make: *** [vmlinux] Error 1

moreover, all works fine if

CONFIG_SMP= y

	or 
	
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

I have a single processor machine (Celeron (Mendocino)) and, yes, I
did 'make mrproper'

bye bye
-b

-- 
head --lines=4 $HOME/.signature
