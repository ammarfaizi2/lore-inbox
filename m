Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275902AbSIULam>; Sat, 21 Sep 2002 07:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275903AbSIULam>; Sat, 21 Sep 2002 07:30:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51469 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S275902AbSIULam>; Sat, 21 Sep 2002 07:30:42 -0400
Date: Sat, 21 Sep 2002 12:35:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: udelay and nanosleep questions
Message-ID: <20020921123546.B27150@flint.arm.linux.org.uk>
References: <20020921124235.I46546-100000@toad.stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020921124235.I46546-100000@toad.stack.nl>; from josh@stack.nl on Sat, Sep 21, 2002 at 01:23:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 01:23:10PM +0200, Jos Hulzink wrote:
> 1) Can I rely on udelay(1) ? i.e. is the resolution high enough to wait at
> least 1 microsecond given it returns normally ? I know the actual
> implementation is platform / cpu dependant, so maybe I should ask: Should
> I be able to rely on udelay(1) ?

udelay() should (note: should) busy wait for at least the requested delay.
It may wait longer though.

Its behaviour in the presence of speedstep type technologies where cpufreq
is not in use is a little undefined; almost anything can happen.  However,
with cpufreq in place, we adjust the delay value appropriately so that
a udelay() always sleeps for at least the requested time.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

