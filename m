Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUHQXNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUHQXNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268512AbUHQXNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:13:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40657 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268511AbUHQXL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:11:28 -0400
Date: Wed, 18 Aug 2004 01:11:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Len Brown <len.brown@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Message-ID: <20040817231119.GB1387@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <200408121550.15892.bjorn.helgaas@hp.com> <1092350580.7765.190.camel@dhcppc4> <200408131515.56322.bjorn.helgaas@hp.com> <20040813235515.GB28687@fs.tum.de> <1092450142.5028.232.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092450142.5028.232.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 10:22:22PM -0400, Len Brown wrote:
>...
> Also, it would be helpful to see the lines with LNKD
> in the dmesg for floppy enabled and floppy disabled cases --
> a 2.6.7 vintage kernel should work fine:
> 
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
>         ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6

I've used 2.6.8.1, and in both cases I got the following (in the enabled 
case, no floppy was actually present):

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
...
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6


> If you can also run acpidmp in both those scenarios
> (any kernel version, ACPI enabled or disabled should do)
> and send me the two output files, that would be great.
> 
> thanks,
> -Len
> 
> ps. you can get acpidmp in /usr/sbin/ or from pmtools here
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

It didn't compile for me:

<--  snip  -->

...
gcc -Wall -fno-strength-reduce -fomit-frame-pointer -D__KERNEL__ 
-DMODULE -I/usr/src/linux/include -Wall -Wno-unused -Wno-multichar   -c 
-o pmtest.o pmtest.c
In file included from /usr/include/asm/system.h:5,
                 from /usr/include/asm/processor.h:18,
                 from /usr/include/asm/thread_info.h:13,
                 from /usr/include/linux/thread_info.h:21,
                 from /usr/include/linux/spinlock.h:19,
                 from /usr/include/linux/capability.h:45,
                 from /usr/include/linux/sched.h:7,
                 from /usr/include/linux/module.h:10,
                 from pmtest.c:21:
/usr/include/linux/kernel.h:72: error: parse error before "size_t"
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

