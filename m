Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbVHPLlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbVHPLlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 07:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVHPLlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 07:41:35 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:39991 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932641AbVHPLle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 07:41:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dCM0WRidFfbueA7V0F+fSOEaMH9uyFcbHPNZrKxom/CPsQ/WatKfJQo3c8A9m0YCRzYHad5mdS4MMcQ87kiXJfIOSHiehn7cOuNOlS9GGjVzI2QQMIQlzO+jSGJpCUW1AVlE6JDCxWkCfsDhctw7PhVdku2umPrZm7MX9YF/YnU=
Message-ID: <4301D0F9.4050405@gmail.com>
Date: Tue, 16 Aug 2005 21:41:45 +1000
From: Mr Machine <machinehasnoagenda@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: error compiling 2.6.13.rc6 with realtime-preempt patch -rt2 ('quirk_via_irq')
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i get this error during compile of pci drivers:

   CC      drivers/pci/access.o
   CC      drivers/pci/bus.o
   CC      drivers/pci/probe.o
   CC      drivers/pci/remove.o
   CC      drivers/pci/pci.o
   CC      drivers/pci/quirks.o
drivers/pci/quirks.c: In function ‘quirk_via_irq’:
drivers/pci/quirks.c:505: error: ‘vt8237_devfn’ undeclared (first use in 
this function)
drivers/pci/quirks.c:505: error: (Each undeclared identifier is reported 
only once
drivers/pci/quirks.c:505: error: for each function it appears in.)
drivers/pci/quirks.c:506: error: ‘quirk_via_irq_not’ undeclared (first 
use in this function)
make[2]: *** [drivers/pci/quirks.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2
[mrmachine@localhost linux-2.6.12]$


if this helps, here's the realtime configuration section from my .config 
file:

# CONFIG_LEGACY_TIMER is not set
CONFIG_HPET_TIMER=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT_DESKTOP=y
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
# CONFIG_SPINLOCK_BKL is not set
CONFIG_PREEMPT_BKL=y
# CONFIG_PREEMPT_RCU is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_ASM_SEMAPHORES=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_X86_UP_APIC is not set


and from the pci driver section:

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

Please CC me on any replies.

shayne
