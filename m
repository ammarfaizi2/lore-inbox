Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264183AbRFPC1u>; Fri, 15 Jun 2001 22:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbRFPC1j>; Fri, 15 Jun 2001 22:27:39 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:62214 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S264183AbRFPC10>; Fri, 15 Jun 2001 22:27:26 -0400
Date: Sat, 16 Jun 2001 11:27:53 +0900
Message-Id: <200106160227.f5G2Rrp19469@norma.kjist.ac.kr>
From: root <root@norma.kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac6 and 2.4.4-ac11 boot fails with APIC timer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> The message on the screen 
>
> calibrating APIC timer ..... 
> .... CPU clock speed is 1395.7390MHz 
> ... host bus clock speed is 0.0000 MHz 
> cpu: 0, clocks: 0, slic: 0 
>
> Then nothing. I had to push the reset button at this point. 
> ACPI and APM were disabled from the kernel config. 
>
> This boot failure messages was obtained from 
> Pentium4 board GB-450(?) from Intel, NVIDIA M64 video. 
> Sound Blaster 128 PCI. Netgear PNIC fast ethernet.... 
>   
> The same kernel was able to boot up the other Pentium 4 board from 
> Gigabyte flawlessly. So, it depends on the motherboard manufacturers. 
>
> Regards to all. 
>
> G. Hugh Song 

Replying to my own message:

When I chose "No" to "APIC support on uniprocessors", the above error
message disappeared and the machine booted up OK with 2.4.5-ac13.
Please refer to the following diff:

diff .config.old .config
63,65c63
< CONFIG_X86_UP_APIC=y
< # CONFIG_X86_UP_IOAPIC is not set
< CONFIG_X86_LOCAL_APIC=y
---
> # CONFIG_X86_UP_APIC is not set


I think that APIC thing was defined by Intel themselves.
They should have implemented it the best.  How much penalty do I pay 
by not choosing "yes" to "APIC support on uniprocessors"?

Best regards,

G. Hugh Song
