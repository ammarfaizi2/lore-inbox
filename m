Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269551AbRHCSnP>; Fri, 3 Aug 2001 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269558AbRHCSnF>; Fri, 3 Aug 2001 14:43:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7440 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269570AbRHCSm5>;
	Fri, 3 Aug 2001 14:42:57 -0400
Date: Fri, 3 Aug 2001 19:43:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Frank Torres <frank@ingecom.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
Message-ID: <20010803194300.A1609@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.3.95.1010803085542.16919A-100000@chaos.analogic.com> <018201c11c24$cd2af730$66011ec0@frank>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <018201c11c24$cd2af730$66011ec0@frank>; from frank@ingecom.net on Fri, Aug 03, 2001 at 04:01:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 04:01:28PM +0200, Frank Torres wrote:
> > This is not valid. You cannot reasonably have parity and 8 bits. One
> > of them has to go. Either use 8 bits and no parity or 7 bits with
> > parity.

All standard 16550 family ports support 8 bits _and_ parity.  Ancient
serial ports did have a restriction, but that restriction is no more.

> All showed wrong or no characters in the display. It only worked with 8,
> parity on, parity odd, stop b. (also with no stop b.)

You actually mean 2 stop bits.  (There is _always_ one stop bit).

I read your first mail, but couldn't really grasp the details of your
problem.

Are you trying to direct console _output_ to ttyS2 and the VGA card, yet
still accept input from the PS/2 keyboard?  And then when you try to set
this up, you get garbled characters via ttyS2?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

