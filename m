Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUHQXvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUHQXvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHQXvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:51:23 -0400
Received: from fmr10.intel.com ([192.55.52.30]:44982 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S268526AbUHQXtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:49:19 -0400
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040817231119.GB1387@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com>
	 <200408121550.15892.bjorn.helgaas@hp.com>
	 <1092350580.7765.190.camel@dhcppc4>
	 <200408131515.56322.bjorn.helgaas@hp.com>
	 <20040813235515.GB28687@fs.tum.de> <1092450142.5028.232.camel@dhcppc4>
	 <20040817231119.GB1387@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1092786485.25902.28.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Aug 2004 19:48:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 19:11, Adrian Bunk wrote:
> On Fri, Aug 13, 2004 at 10:22:22PM -0400, Len Brown wrote:
> >...
> > Also, it would be helpful to see the lines with LNKD
> > in the dmesg for floppy enabled and floppy disabled cases --
> > a 2.6.7 vintage kernel should work fine:
> > 
> > ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
> >         ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
> 
> I've used 2.6.8.1, and in both cases I got the following (in the
> enabled 
> case, no floppy was actually present):
> 
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
> ...
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6

That's interesting, IRQ6 is being given to PCI, even when the floppy
controller is enabled.

> 
> > If you can also run acpidmp in both those scenarios
> > (any kernel version, ACPI enabled or disabled should do)
> > and send me the two output files, that would be great.
> > 
> > thanks,
> > -Len
> > 
> > ps. you can get acpidmp in /usr/sbin/ or from pmtools here
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> 
> It didn't compile for me:
> 
> <--  snip  -->
> 
> ...
> gcc -Wall -fno-strength-reduce -fomit-frame-pointer -D__KERNEL__ 
> -DMODULE -I/usr/src/linux/include -Wall -Wno-unused -Wno-multichar  
> -c 
> -o pmtest.o pmtest.c
> In file included from /usr/include/asm/system.h:5,
>                  from /usr/include/asm/processor.h:18,
>                  from /usr/include/asm/thread_info.h:13,
>                  from /usr/include/linux/thread_info.h:21,
>                  from /usr/include/linux/spinlock.h:19,
>                  from /usr/include/linux/capability.h:45,
>                  from /usr/include/linux/sched.h:7,
>                  from /usr/include/linux/module.h:10,
>                  from pmtest.c:21:
> /usr/include/linux/kernel.h:72: error: parse error before "size_t"
> ...

you don't care about pmtest, just acpidmp.

cd acpidmp
make

thanks,
-Len


