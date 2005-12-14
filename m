Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVLNXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVLNXlY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVLNXlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:41:24 -0500
Received: from [64.71.148.162] ([64.71.148.162]:43936 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S965103AbVLNXlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:41:23 -0500
Message-ID: <43A0AF15.7020705@linuxmachines.com>
Date: Wed, 14 Dec 2005 15:47:33 -0800
From: Jeff Carr <jcarr@linuxmachines.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Yee <brewt-linux-kernel@brewt.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: tsc clock issues with dual core and question about irq balancing
References: <GMail.1134458797.49013860.4106109506@brewt.org>
In-Reply-To: <GMail.1134458797.49013860.4106109506@brewt.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/05 23:26, Adrian Yee wrote:

> My other question is about irq balancing - I turned it on, but it
> doesn't seem to be working properly:
> 
>            CPU0       CPU1       
>   0:     109208        975    IO-APIC-edge  timer
>   1:       1226         10    IO-APIC-edge  i8042
>   8:     275272          1    IO-APIC-edge  rtc
>   9:          0          0   IO-APIC-level  acpi
>  12:       4133          4    IO-APIC-edge  i8042
>  14:       5135          8    IO-APIC-edge  ide0
>  15:         17          8    IO-APIC-edge  ide1
>  16:      25084          1   IO-APIC-level  eth0
>  17:      43597          1   IO-APIC-level  eth1
>  18:        185          5   IO-APIC-level  libata
>  19:          0          0   IO-APIC-level  libata
>  20:      11525          1   IO-APIC-level  EMU10K1
>  21:      24870          1   IO-APIC-level  nvidia
> NMI:          0          0 
> LOC:     110119     110118 
> ERR:          0
> MIS:          0

I think there is an irqbalance userspace daemon.
