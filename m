Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263712AbUCXOE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbUCXOE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:04:58 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:44428 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263712AbUCXOEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:04:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.38232.821416.157613@gargle.gargle.HOWL>
Date: Wed, 24 Mar 2004 09:04:08 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/i386/Kconfig: CONFIG_IRQBALANCE Description
In-Reply-To: <c3qa94$qhi$1@news.cistron.nl>
References: <1079996577.6595.19.camel@bach>
	<16480.28882.388997.71072@gargle.gargle.HOWL>
	<c3qa94$qhi$1@news.cistron.nl>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Miquel" == Miquel van Smoorenburg <miquels@cistron.nl> writes:

Miquel> In article <16480.28882.388997.71072@gargle.gargle.HOWL>,
Miquel> John Stoffel <stoffel@lucent.com> wrote:
>> 
>> And hey, under 2.6.5-rc2-mm1, it doens't seem to do anything:
>> 
>> > zcat /proc/config.gz | grep IRQ
>> CONFIG_IRQBALANCE=y
>> CONFIG_IDEPCI_SHARE_IRQ=y
>> 
>> > cat /proc/interrupts 
>> CPU0       CPU1       
>> 0:   46272316        487    IO-APIC-edge  timer
>> 1:        376          0    IO-APIC-edge  i8042
>> 16:      46770          3   IO-APIC-level  ide2, ide3, ehci_hcd
>> 17:     307832          1   IO-APIC-level  eth0
>> 18:     118258          1   IO-APIC-level  aic7xxx, aic7xxx, ohci_hcd
>> LOC:   46279245   46279281 

Miquel> Is that real SMP, or hyperthreading? If it's hyperthreading,
Miquel> then it makes sense that the IRQs are not balanced.

It's dual Xeon PIII 550mhz, in a Dell Precision 610MT workstation.
Intel GX chipset.  None of that fancy HT stuff here!

> cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 547.343
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1077.24

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 547.343
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1093.63

