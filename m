Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSH1Qp3>; Wed, 28 Aug 2002 12:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSH1Qp3>; Wed, 28 Aug 2002 12:45:29 -0400
Received: from [195.185.133.146] ([195.185.133.146]:61451 "HELO
	gateway.hottinger.de") by vger.kernel.org with SMTP
	id <S318035AbSH1Qp2>; Wed, 28 Aug 2002 12:45:28 -0400
Message-ID: <D3524C0FFDC6A54F9D7B6BBEECD341D5D56FE2@HBMNTX0.da.hbm.com>
From: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: AW: interrupt latency
Date: Wed, 28 Aug 2002 18:49:41 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

> Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] wrote:
> 
> I would expect port 0x378 on any modern PC to be on the X-bus 
> not on ISA

Right, so it is fast enough for a quick test.


Actually I don't know where this thread has lead us. Was it really me who
typed the reference line? Anyhow. :->


When I was talking about interrupt latency, I ment this:

I do a hardware interrupt, use it as trigger on an oscilloscope, then
measure how long it takes until the printer port showbit shows up. (Ha! An
oscilloscope is fine for timing measurements!) The printer port is handled
first in the irq_function of my driver. That kind of "latency" I was talking
about. The jitter I get (because of NMI functions and more) I can guess by
changing the persistance of the oscilloscope.

And to those who think that the printer port might be to slow for that kind
of measurement, I did the same with a showbit I set on a PCI device (a PLD I
know the inside). That one is nanoseconds fast, so no relevant delay.

Okay, the kernel takes at least 8 microseconds time to "tell" the kernel
driver function that an interrupt is there. So my question still is: How
should I trace thru the kernel source after a hardware interrupt is there?

(I am running a Pentium-like ETX with 266 MHz CPU clock. Single CPU.)

But thanks for all helps, hints and interesting discusses!


Siegfried Wessler.

BTW: You can get down to 1ms jiffies without RT Linux easily ;-)
