Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270827AbRHSWaV>; Sun, 19 Aug 2001 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270825AbRHSWaB>; Sun, 19 Aug 2001 18:30:01 -0400
Received: from mail.webmaster.com ([216.152.64.131]:57280 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S270823AbRHSWaA>; Sun, 19 Aug 2001 18:30:00 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>
Cc: "Oliver Xymoron" <oxymoron@waste.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Date: Sun, 19 Aug 2001 15:30:13 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMEEOCDEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <481261630.998262525@[169.254.45.213]>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> $ cat /proc/interrupts
>            CPU0
>   0: 1116302985          XT-PIC  timer
>   1:          2          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>   9:   28980016          XT-PIC  usb-uhci, eth0
>  14:  698146587          XT-PIC  ide0
>  15:          5          XT-PIC  ide1
> NMI:          0
> ERR:          0
>
> Shock horror - I can continually poll this and spot
> when an IRQ occurs.

	To what level of accuracy do you think you can measure when interrupts
occur? From my tests, you can (if you max the processor and do no math on
the results) read /proc/interrupts about once every 30,000 instruction
cycles. This would still leave about 14 bits of entropy in each interrupt.

	Overall, you're just making the system busier.

	DS

