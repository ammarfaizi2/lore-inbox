Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317671AbSGUJFV>; Sun, 21 Jul 2002 05:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317672AbSGUJFU>; Sun, 21 Jul 2002 05:05:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5383 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317671AbSGUJFU>; Sun, 21 Jul 2002 05:05:20 -0400
Date: Sun, 21 Jul 2002 10:08:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code v3
Message-ID: <20020721100818.A22176@flint.arm.linux.org.uk>
References: <20020719011300.548d72d5.arodland@noln.com> <20020720173222.3286fcbb.arodland@noln.com> <200207211849.56076.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207211849.56076.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Sun, Jul 21, 2002 at 06:49:55PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 06:49:55PM +1000, Brad Hards wrote:
> While it will be non-trivial, it won't be hard either.
> The advantage of the input layer is that it no longer matters what
> type of keyboard is attached - you can just call input_event() and
> turn on and off the LED. The input layer abstracts out the magic
> values needed for any particular keyboard.

Hmm.  I thought the original idea for the "flash LEDs on panic" was
so you knew something had gone wrong early in the boot, at the kind
of places where you don't have a console initialised.  If you don't
have the console initialised, you sure as hell don't have the input
layer or keyboard drivers initialised.

Otherwise it becomes a "toy" feature that doesn't have much value.
What would be more useful would be to disable the console blank
timer on a panic() so it doesn't blank half-way through someone
reading the oops, leaving them with no way to read the rest of it!

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

