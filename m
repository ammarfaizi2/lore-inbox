Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTASUce>; Sun, 19 Jan 2003 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbTASUce>; Sun, 19 Jan 2003 15:32:34 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:21400 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264925AbTASUcd>;
	Sun, 19 Jan 2003 15:32:33 -0500
Message-ID: <3E2B0D71.5030800@colorfullife.com>
Date: Sun, 19 Jan 2003 21:41:22 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Lambrechts <hans.lambrechts@skynet.be>
CC: linux-kernel@vger.kernel.org
Subject: Re:  2.4.21pre3 smp_affinity, very strange
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans wrote:

>pc:~ # cat /proc/interrupts
>           CPU0       CPU1
>  0:      39836          0    IO-APIC-edge  timer
>  1:        574          0    IO-APIC-edge  keyboard
>  2:          0          0          XT-PIC  cascade
>  8:          2          0    IO-APIC-edge  rtc
>  9:          0          0    IO-APIC-edge  acpi
> 12:      20362          0    IO-APIC-edge  PS/2 Mouse
> 14:          7          0    IO-APIC-edge  ide0
> 16:       8906          0   IO-APIC-level  aic7xxx
> 18:        789          0   IO-APIC-level  eth0
>NMI:          0          0
>LOC:      39741      39740
>ERR:          0
>MIS:          0
>  
>
Could you add a few details about your system? E.g. the dmesg log.
What happens if you manually distribute interrupts?
    echo 2 > /proc/irq/12/smp_affinity
    echo 1 > /proc/irq/16/smp_affinity

--
    Manfred

