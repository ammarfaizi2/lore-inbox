Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313983AbSDQA1y>; Tue, 16 Apr 2002 20:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313984AbSDQA1x>; Tue, 16 Apr 2002 20:27:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:21163 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S313983AbSDQA1x>; Tue, 16 Apr 2002 20:27:53 -0400
Date: Tue, 16 Apr 2002 20:27:52 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: Cannot compile 2.4.19-pre7 with APIC without IOAPIC
Message-ID: <Pine.LNX.4.44.0204162016010.2155-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm getting this error when compiling 2.4.19-pre7:

init/main.o: In function `smp_init':
init/main.o(.text.init+0x5e1): undefined reference to `skip_ioapic_setup'
arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x3427): undefined reference to 
`skip_ioapic_setup'

Processor is AMD K7, SMP is disabled, APIC is enabled, IOAPIC is disabled.

It turns out that skip_ioapic_setup is defined in 
arch/i386/kernel/io_apic.c, which is only compiled when CONFIG_X86_IO_APIC 
is defined, but it's used in init/main.c if SMP is disabled and APIC is 
enabled.

-- 
Regards,
Pavel Roskin

