Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbTLFHCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 02:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbTLFHC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 02:02:29 -0500
Received: from p-nya.swiftel.com.au ([202.154.106.98]:5760 "EHLO
	war.coesta.com") by vger.kernel.org with ESMTP id S264958AbTLFHC2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 02:02:28 -0500
Message-ID: <3704.192.168.1.3.1070694142.squirrel@www.coesta.com>
In-Reply-To: <20031206030755.GI8039@holomorphy.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
    <20031206024251.GG8039@holomorphy.com>
    <3FD14396.5070205@cyberone.com.au>
    <20031206030755.GI8039@holomorphy.com>
Date: Sat, 6 Dec 2003 15:02:22 +0800 (WST)
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
From: "Colin Coe" <colin@coesta.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: colin@coesta.com
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the delay.

Booted with noirqbalance.

[root@host root]# cat /proc/interrupts
           CPU0       CPU1
  0:    7411777    5971987    IO-APIC-edge  timer
  1:          7          4    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:         16         42    IO-APIC-edge  serial
  5:       4915       4820   IO-APIC-level  eth1
 10:         67         69   IO-APIC-level  aic7xxx
 11:        325        266   IO-APIC-level  eth0
 12:         47        109    IO-APIC-edge  i8042
 14:          0          0   IO-APIC-level  CS46XX
 15:       6398       6401   IO-APIC-level  megaraid
NMI:          0          0
LOC:   13383659   13383658
ERR:          0
MIS:          0

That looks a lot better...

Thanks!

--
"Obnoxious frog..." Spike, 2071AD

William Lee Irwin III said:
> On Sat, Dec 06, 2003 at 01:48:54PM +1100, Nick Piggin wrote:
>> Although in this case Colin has 2 PPro 200s.
>> Colin - process load should be evenly distributed between CPUs, and this
>> is generally the most important thing. Big networking loads (most
>> commonly)
>> can put a lot of time into processing interrupts though.
>
> That is rather busted, then.
>
> Colin, could you try booting with noirqbalance on the kernel command
> line?
>
>
> -- wli
>

