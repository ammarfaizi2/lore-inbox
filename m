Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSKJQzg>; Sun, 10 Nov 2002 11:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSKJQzg>; Sun, 10 Nov 2002 11:55:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4106 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264945AbSKJQzf>; Sun, 10 Nov 2002 11:55:35 -0500
Date: Sun, 10 Nov 2002 17:02:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status for 10 Nov
Message-ID: <20021110170219.A15424@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Molina <tmolina@cox.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211100834110.16968-100000@dad.molina>; from tmolina@cox.net on Sun, Nov 10, 2002 at 10:31:56AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 10:31:56AM -0600, Thomas Molina wrote:
> ------------------------------------------------------------------------
>    open   23 Oct 2002 2.5.x and 8250 UART problems
>   18. http://marc.theaimsgroup.com/?l=linux-kernel&m=103383019409525&w=2

No movement, and I don't particular see there's going to be any movement
on this one.  There are too many variables that changed around the time
that the serial code went in to allow the cause to be isolated.

> ------------------------------------------------------------------------
>    open   15 Oct 2002 oops stopping serial
>   36. http://marc.theaimsgroup.com/?l=linux-kernel&m=103470900729987&w=2

Fixed.

> ------------------------------------------------------------------------
>    open   24 Oct 2002 serial driver bug with asus motherboard
>   67. http://marc.theaimsgroup.com/?l=linux-kernel&m=103548912126308&w=2

Awaiting feedback from Andrew Walrond; the code as of 2.5.46 allows
better remote debugging of wrong/mis-detections.

> ------------------------------------------------------------------------
>    open   07 Nov 2002 odd deref in serial_in
>   84. http://marc.theaimsgroup.com/?l=linux-kernel&m=103647077515688&w=2

Not my problem - it looks like something else is trampling on %ebx,
although Zwane/myself are at a loss to locate the cause of that.
(%ebx = "up" pointer, which must have been valid a few instructions
previous to even get to this point in the code.  Could it be a compiler
bug?)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

