Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTDSAkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 20:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTDSAkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 20:40:46 -0400
Received: from [12.47.58.203] ([12.47.58.203]:34456 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263328AbTDSAkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 20:40:45 -0400
Date: Fri, 18 Apr 2003 17:51:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4 & IRQ balancing
Message-Id: <20030418175116.75c8aa7b.akpm@digeo.com>
In-Reply-To: <20030419015836.6acbaeb6.philippe.gramoulle@mmania.com>
References: <20030419015836.6acbaeb6.philippe.gramoulle@mmania.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 19 Apr 2003 00:52:36.0338 (UTC) FILETIME=[F81B3520:01C3060D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Gramoullé  <philippe.gramoulle@mmania.com> wrote:
>
> 
> Hello,
> 
> It may be not related to -mm4 only but as i hadn't checked before ( with 2.5.x kernels),
> I just wonder about /proc/interrupts output:
> 
> $ cat /proc/interrupts 
>            CPU0       CPU1       
>   0:   47851610          0    IO-APIC-edge  timer
>   1:      51789          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:        171          0    IO-APIC-edge  serial
>   8:     772066          0    IO-APIC-edge  rtc
>  12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
>  15:         58          1    IO-APIC-edge  ide1
>  16:      47047          0   IO-APIC-level  ohci1394
>  18:     391753          0   IO-APIC-level  EMU10K1
>  19:     911863          0   IO-APIC-level  uhci-hcd
>  20:     261806          0   IO-APIC-level  eth0
>  22:     273648          0   IO-APIC-level  aic7xxx

It is supposed to do that.

You might as well beat the rush; boot with the `noirqbalance' option and
run http://people.redhat.com/arjanv/irqbalance/.  We want to pull the
irq balancer out of the kernel altogether.


