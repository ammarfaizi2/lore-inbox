Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTBLPh7>; Wed, 12 Feb 2003 10:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBLPg0>; Wed, 12 Feb 2003 10:36:26 -0500
Received: from [66.238.160.78] ([66.238.160.78]:51462 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S267267AbTBLPgO>; Wed, 12 Feb 2003 10:36:14 -0500
Message-ID: <3E4A6BF0.1000004@didntduck.org>
Date: Wed, 12 Feb 2003 10:44:48 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for i8042?
References: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
In-Reply-To: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 2.4:
>            CPU0
>   0:    2576292          XT-PIC  timer
>   1:        661          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   3:         10          XT-PIC  serial
>   5:    1104824          XT-PIC  soundblaster
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:          7          XT-PIC  aic7xxx
>  11:      15167          XT-PIC  usb-uhci, eth0
>  14:       7554          XT-PIC  ide0
>  15:          3          XT-PIC  ide1
> 
> 2.5:
> 
>            CPU0
>   0:      36281          XT-PIC  timer
>   1:         15          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   3:        149          XT-PIC  serial
>   5:          0          XT-PIC  soundblaster
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:         20          XT-PIC  aic7xxx
>  11:        324          XT-PIC  uhci-hcd, eth0
>  12:         60          XT-PIC  i8042 <--???
>  14:        723          XT-PIC  ide0
>  15:          9          XT-PIC  ide1
> NMI:          0
> LOC:      35547
> ERR:          0
> MIS:          0
> 
> Interesting, why are we using two interrupts for the i8042 (keyboard).

IRQ12 is for the PS/2 mouse port.

--
				Brian Gerst

