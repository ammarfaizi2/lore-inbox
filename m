Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSDBLZT>; Tue, 2 Apr 2002 06:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSDBLZA>; Tue, 2 Apr 2002 06:25:00 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:13712 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S293119AbSDBLYv>;
	Tue, 2 Apr 2002 06:24:51 -0500
Date: Tue, 2 Apr 2002 12:24:28 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Tim Kay <timk@advfn.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: What am I losing with noapic
In-Reply-To: <200204021051.g32Ap6s12049@mail.advfn.com>
Message-ID: <Pine.LNX.4.33.0204021222220.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you pass "noapic" the IO-APIC IRQ routing entries are not used. This
is useful if the way MP table is prepared by firmware is not good.

What is most noticeable in this case is that all interrupts will be
handled by the first cpu.

On Tue, 2 Apr 2002, Tim Kay wrote:

> Hi all,
> 	Does anyone know what I'm actually losing with having to set noapic on
> bootup? I mean in real terms how much harder / slower is an SMP machine
> working when it's doing standard multi-bus xt polling compared to when it's
> in APIC poll state. I appreciate that there can be a reduction in interrupt
> response latency using the damn thing but is this a measurable amount given a
> machine processing about 1200 interrupts/sec? (this figure is a sum rather
> than per processor). As an added complication how do I get around interrupt
> routing conflicts in noapic mode and do the 'routing conflict for xx:xx:xx
> have X want Y' messages make any difference to this performance?
>
> 	A useful URL (I couldn't find any) or reference would suffice if this is too
> invloved or boring a topic to explain easily.
>
> TIA
>
> Tim
>
>

