Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbTLHRjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbTLHRjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:39:32 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:34689
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265502AbTLHRjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:39:23 -0500
Date: Mon, 8 Dec 2003 12:38:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Matthew Kanar <mkanarlists@kanar.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
In-Reply-To: <3FD4AA11.6010806@kanar.net>
Message-ID: <Pine.LNX.4.58.0312081227080.5919@montezuma.fsmlabs.com>
References: <ZAwx-88m-3@gated-at.bofh.it> <ZAGd-8ma-5@gated-at.bofh.it>
 <ZAQ7-6X-13@gated-at.bofh.it> <ZAZB-pS-11@gated-at.bofh.it>
 <ZCoI-2oz-9@gated-at.bofh.it> <ZCyh-2Bv-1@gated-at.bofh.it>
 <ZCI5-2Pv-3@gated-at.bofh.it> <ZCIb-2Pv-11@gated-at.bofh.it>
 <3FD4AA11.6010806@kanar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Matthew Kanar wrote:

> _Without_ noirqbalance -
>
> uptime:
>   10:31:51  up 4 days, 15:07, 10 users,  load average: 0.00, 0.02, 0.00
>
> /proc/interrupts:
>             CPU0       CPU1
>    0:      27505  400084866    IO-APIC-edge  timer
>    1:       1438          1    IO-APIC-edge  i8042
>    2:          0          0          XT-PIC  cascade
>    8:          1          0    IO-APIC-edge  rtc
>   12:       1837        161    IO-APIC-edge  i8042
>   14:     661467     822411    IO-APIC-edge  ide0
>   15:          1          0    IO-APIC-edge  ide1
>   16:  104949011         10   IO-APIC-level  eth0
> NMI:          0          0
> LOC:  400153184  400153183
> ERR:          0
> MIS:         10
>
>
> _With_ noirqbalance -
>
> uptime:
>   11:36:12  up  1:01,  4 users,  load average: 0.00, 0.09, 0.28
>
> /proc/interrupts:
>             CPU0       CPU1
>    0:      16726    3707690    IO-APIC-edge  timer
>    1:          3          8    IO-APIC-edge  i8042
>    2:          0          0          XT-PIC  cascade
>    8:          0          1    IO-APIC-edge  rtc
>   12:         14         36    IO-APIC-edge  i8042
>   14:      28140        659    IO-APIC-edge  ide0
>   15:          1          0    IO-APIC-edge  ide1
>   16:      12775         12   IO-APIC-level  eth0
> NMI:          0          0
> LOC:    3724639    3724638
> ERR:          0
> MIS:          0

Are you sure you're not running the userspace irq balancer (ps ax | grep
irqbalance)?
