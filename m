Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266658AbSKHALr>; Thu, 7 Nov 2002 19:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266671AbSKHALr>; Thu, 7 Nov 2002 19:11:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33541 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266658AbSKHALq>; Thu, 7 Nov 2002 19:11:46 -0500
Date: Fri, 8 Nov 2002 00:18:22 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Martin Diehl <lists@mdiehl.de>
Subject: Re: [Serial 2.5]: packet drop problem (FE ?)
Message-ID: <20021108001822.E11437@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Martin Diehl <lists@mdiehl.de>
References: <20021107224750.GA699@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021107224750.GA699@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Thu, Nov 07, 2002 at 02:47:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 02:47:50PM -0800, Jean Tourrilhes wrote:
> 	I tried swapping the IrDA dongles themselves, and this didn't
> make any difference. No other device/driver is using irq4. I also try
> using a FIR as a sender, and I still see this packet dropped in Rx in
> 2.5.X. And this used to work properly way back when I had 2.4.X on
> this box.
> 	I'm kind of suspicious about the "fe" number above. Could
> anybody tell me a bit more about what "fe" means ?

FE = framing error, which is an error which is solely detected by the
hardware when the stop bit(s) are not the mark value.  They can appear
when the wrong parity setting, number of stop bits, or baud rate is
programmed.

If you were overruning the serial port FIFOs, then you would see "oe"
errors.

What baud rate are you trying to run the link at?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

