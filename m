Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUAKCkK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUAKCkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:40:09 -0500
Received: from mail.aei.ca ([206.123.6.14]:39133 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265726AbUAKCj6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:39:58 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 and irq balancing
Date: Sat, 10 Jan 2004 21:39:09 -0500
User-Agent: KMail/1.5.93
Cc: Ethan Weinstein <lists@stinkfoot.org>
References: <40008745.4070109@stinkfoot.org>
In-Reply-To: <40008745.4070109@stinkfoot.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401102139.09883.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What is the load on the box when this is happening?  If its low think
this is optimal (for cache reasons).

Ed Tomlinson

On January 10, 2004 06:14 pm, Ethan Weinstein wrote:
> Greetings all,
> 
> I upgraded my server to 2.6.1, and I'm finding I'm saddled with only 
> interrupting on CPU0 again. 2.6.0 does this as well. This is the 
> Supermicro X5DPL-iGM-O (E7501 chipset), 2 Xeons@2.4ghz HT enabled. 
> /proc/cpuinfo is normal as per HT, displaying 4 cpus.
> 2.4.2(3|4) exhibited this behaviour as well, until I applied patches 
> from here: 
> http://www.hardrock.org/kernel/2.4.23/irqbalance-2.4.23-jb.patch, et al.
> 
> 
>             CPU0       CPU1       CPU2       CPU3
>    0:    1572323          0          0          0    IO-APIC-edge  timer
>    2:          0          0          0          0          XT-PIC  cascade
>    3:      23520          0          0          0    IO-APIC-edge  serial
>    8:          2          0          0          0    IO-APIC-edge  rtc
>    9:          0          0          0          0   IO-APIC-level  acpi
>   14:         10          0          0          0    IO-APIC-edge  ide0
>   16:         30          0          0          0   IO-APIC-level 
> sym53c8xx 22:       4162          0          0          0   IO-APIC-level 
> eth0 48:       7798          0          0          0   IO-APIC-level 
> aic79xx 49:       3385          0          0          0   IO-APIC-level 
> aic79xx 54:      17062          0          0          0   IO-APIC-level 
> eth1 NMI:          0          0          0          0
> LOC:    1572002    1572251    1572250    1572243
> ERR:          0
> MIS:          0
> 
> 
> THey keyboard isn't working either, but we see the i8042..
> 
> serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> 
> -Ethan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
