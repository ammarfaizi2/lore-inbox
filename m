Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbUB0NYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbUB0NYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:24:37 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:59319 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262843AbUB0NYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:24:34 -0500
Date: Fri, 27 Feb 2004 21:24:25 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Etienne Lorrain" <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
References: <20040227113725.12307.qmail@web11808.mail.yahoo.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr3056zq14evsfm@smtp.pacific.net.th>
In-Reply-To: <20040227113725.12307.qmail@web11808.mail.yahoo.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 12:37:25 +0100 (CET), Etienne Lorrain <etienne_lorrain@yahoo.fr> wrote:

> Russell King wrote:
>> Michael Frank wrote:
>> > Is this to imply that edge triggered shared interrupts
>> > are used anywhere?
>>
>> It is (or used to be) rather common with serial ports.  Remember that
>> COM1 and COM3 were both defined to use IRQ4 and COM2 and COM4 to use
>> IRQ3.
>
>   Some unusual hardware could handle two ports on the same IRQ (the
>  same card mixing itself the IRQ of the two COM port present on the
>  same ISA card) but the mixing could not be reliably handled at the
>  ISA level. Using a resistor and/or a diode instead of a jumper to
>  select the IRQ could also do the trick. So the software was ready
>  to handle two interrupts from two UART on the same IRQ - but you
>  had to have special hardware.

I used those cheapy 8 Channel 8250 serial cards and modified them
by oring 8 interrupts to irq 3.

The IRQ was set to level triggered and on an IRQ one polled the
status regs of all 8 channels. That was _just_ OK on a 8MHz 286
at 9600 baud in a custom designed low latency application
(no FIFOS here).

>
>   Some people had success having a modem on COM1 and a serial _mouse_
>  on COM3 (or the other way around) because the COM1/modem was winning
>  the control of the ISA IRQ  and the COM3/modem was loosing but because
>  of 1200 bauds transmission speed the timer interrupt was recovering the
>  char received. So they could not tell the difference and did not know
>  why inverting the two serial plug did not work.

:-(

Regards
Michael
