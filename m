Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUGKClB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUGKClB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUGKClB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:41:01 -0400
Received: from fmr11.intel.com ([192.55.52.31]:13539 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S266486AbUGKCk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:40:58 -0400
Subject: Re: [2.6.7] Ehci controller interrupts like crazy on nforce2
From: Len Brown <len.brown@intel.com>
To: Jonathan Filiatrault <lintuxicated@yahoo.ca>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFA43@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFA43@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089513649.32038.55.camel@dhcppc2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jul 2004 22:40:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-08 at 21:16, Jonathan Filiatrault wrote:
> Here it is: another nforce2 hardware bug. The ehci controller seems to
> send a massive number of interrupts to the kernel (264379 per second).
> This uses about 5 to 10% of the cpu. This shows up in top in the
> "hi"(hard interrupts) indicator. Nothing unusual shows up in the
> kernel
> log. My system has an Asus A7N8X Nforce2 Board with an Athlon XP 2800+
> mounted on it.
> 
> [joe@omega3:~]$ cat /proc/interrupts ; sleep 1; cat /proc/interrupts
>            CPU0
>   0:     583513          XT-PIC  timer

Please boot with "acpi_skip_timer_override" to fix your IRQ0.
Yes, this workaround should be invoked automatically for you.
No, it probably will not help your EHCI problem.

-Len


>   1:       1279    IO-APIC-edge  i8042
>   7:     137293    IO-APIC-edge  parport0
>   8:          0    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
> 14:      41463    IO-APIC-edge  ide0
> 15:         23    IO-APIC-edge  ide1
> 17:          9   IO-APIC-level  EMU10K1
> 18:      18584   IO-APIC-level  eth0
> 20:  121541873   IO-APIC-level  ehci_hcd
> 21:          0   IO-APIC-level  ohci_hcd
> 22:          0   IO-APIC-level  ohci_hcd
> NMI:          0
> LOC:     583348
> ERR:          0
> MIS:          0
>            CPU0




