Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263690AbTDTUHl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 16:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTDTUHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 16:07:41 -0400
Received: from [66.212.224.118] ([66.212.224.118]:32518 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S263690AbTDTUHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 16:07:40 -0400
Date: Sun, 20 Apr 2003 16:11:52 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq balancing; kernel vs. userspace
In-Reply-To: <6uwuhpl2u5.fsf@zork.zork.net>
Message-ID: <Pine.LNX.4.50.0304201605360.17265-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
 <6uwuhpl2u5.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, Sean Neakums wrote:

> I thought I'd play with the userspace IRQ-balancer, but booting with
> noirqbalance seems not to not balance.  Possibly I misunderstand how
> this all fits together.
> 
> $ uname -a
> Linux peng-33 2.5.68 #1 SMP Sun Apr 20 13:06:57 IST 2003 i686 unknown unknown GNU/Linux
> $ cat /proc/cmdline
> auto BOOT_IMAGE=default ro root=801 noirqbalance
> $ cat /proc/interrupts 
>            CPU0       CPU1       
>   0:     853487     854900    IO-APIC-edge  timer
>   1:          9          4    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   4:      15548      15161    IO-APIC-edge  serial
>   8:          2          1    IO-APIC-edge  rtc
>   9:          3          2   IO-APIC-level  eth1
>  10:       1784       1805   IO-APIC-level  via82cxxx, eth0
>  11:      10939      10860   IO-APIC-level  aic7xxx
>  12:         39         21    IO-APIC-edge  i8042
> NMI:          0          0 
> LOC:    1708150    1708149 
> ERR:          0
> MIS:          0

Local APICs before P4 by default arbitrated for interrupt handling, via a 
round robin type scheme, this doesn't seem to be the case with P4 since the 
Arbitration ID register is also gone now.

	Zwane
-- 
function.linuxpower.ca
