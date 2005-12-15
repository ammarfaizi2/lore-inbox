Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbVLOEfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVLOEfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbVLOEfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:35:54 -0500
Received: from mini.brewt.org ([216.18.5.212]:4363 "HELO mini.brewt.org")
	by vger.kernel.org with SMTP id S1161042AbVLOEfx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:35:53 -0500
Date: Wed, 14 Dec 2005 20:35:52 -0800
From: "Adrian Yee" <brewt-linux-kernel@brewt.org>
Subject: Re: tsc clock issues with dual core and question about irq balancing
To: Jeff Carr <jcarr@linuxmachines.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <GMail.1134621352.21575767.16756771447@brewt.org>
In-Reply-To: <43A0AF15.7020705@linuxmachines.com>
Mime-Version: 1.0
References: <GMail.1134458797.49013860.4106109506@brewt.org>
 <43A0AF15.7020705@linuxmachines.com>
X-Gmail-Account: brewt@brewt.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

>> My other question is about irq balancing - I turned it on, but it
>> doesn't seem to be working properly:
>>
>>            CPU0       CPU1
>>   0:     109208        975    IO-APIC-edge  timer
>>   1:       1226         10    IO-APIC-edge  i8042
>>   8:     275272          1    IO-APIC-edge  rtc
>>   9:          0          0   IO-APIC-level  acpi
>>  12:       4133          4    IO-APIC-edge  i8042
>>  14:       5135          8    IO-APIC-edge  ide0
>>  15:         17          8    IO-APIC-edge  ide1
>>  16:      25084          1   IO-APIC-level  eth0
>>  17:      43597          1   IO-APIC-level  eth1
>>  18:        185          5   IO-APIC-level  libata
>>  19:          0          0   IO-APIC-level  libata
>>  20:      11525          1   IO-APIC-level  EMU10K1
>>  21:      24870          1   IO-APIC-level  nvidia
>> NMI:          0          0
>> LOC:     110119     110118
>> ERR:          0
>> MIS:          0
>
> I think there is an irqbalance userspace daemon.

According to debian's package description for the irq balance package:

"Daemon to balance irq's across multiple CPUs on systems with the 2.4 or
2.6 kernel. This can lead to better performance and IO balance on SMP
systems. Useful mostly just for 2.4 kernels, or 2.6 kernels with
CONFIG_IRQBALANCE turned off."

I have the CONFIG_IRQBALANCE option turned on, so it should be balancing
the irq's itself; is it not?  Would there even be any benefit from
balancing the irq's with a single dual core processor?  Thanks.

Adrian
