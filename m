Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTKUIUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTKUIUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:20:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8460 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264319AbTKUIUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:20:33 -0500
Date: Fri, 21 Nov 2003 08:20:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Russell Coker <russell@coker.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test9 and HDD LED
Message-ID: <20031121082027.A5090@flint.arm.linux.org.uk>
Mail-Followup-To: Russell Coker <russell@coker.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200311211327.00522.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200311211327.00522.russell@coker.com.au>; from russell@coker.com.au on Fri, Nov 21, 2003 at 01:27:00PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21, 2003 at 01:27:00PM +1100, Russell Coker wrote:
> When running 2.4.0-test9 on my Thinkpad T20 the HDD LED usually stays on all
> the time.  It seems random, some boots the LED will operate normally, but
> most boots the LED will go on continually.

Is the HDD led separate from the floppy LED?  On my thinkpad, they're
one of the same.

If yes, I'd guess that you've built a kernel without floppy support
built in.  The kernel used to turn the floppy motor off itself even
without floppy support, but this has been removed.  IIRC it is now
the responsibility of the boot loader to do this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
