Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSKEJMd>; Tue, 5 Nov 2002 04:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbSKEJMc>; Tue, 5 Nov 2002 04:12:32 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:11020
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262813AbSKEJMb>; Tue, 5 Nov 2002 04:12:31 -0500
Date: Tue, 5 Nov 2002 04:20:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in
In-Reply-To: <20021105090256.A17931@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211050414410.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Russell King wrote:

> a) have to rely on interrupts running

Not really ;) If i'm successful i may get this working albeit only for 
specific boxes. Although we'd need an IDT at least, but interrupts may 
remain masked...

> b) have to buffer the data somewhere, which may possibly fill up and
>    then what do we do with the printk message
> 
> Bear in mind that dropping random printk messages because we've filled
> a buffer isn't acceptable.  Also note that the behaviour in this area
> hasn't changed since 2.4 times.
> 
> Obviously, the way to reduce the time spent writing console messages to
> the serial port is to increase the baud rate. 8)

I'm runnning 115200 :P It looks like a race however because i don't always 
trigger it, but when i do the trace is always the same. However i'm not 
going to make you run circles for my potentially dodgy code.

Cheers,
	Zwane
-- 
function.linuxpower.ca

