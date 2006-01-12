Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWALReY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWALReY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWALReX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:34:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29200 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932430AbWALReW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:34:22 -0500
Date: Thu, 12 Jan 2006 17:34:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Vrabel <dvrabel@arcom.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, oliver@neukum.org
Subject: Re: [linux-usb-devel] Re: need for packed attribute
Message-ID: <20060112173413.GD9288@flint.arm.linux.org.uk>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net, oliver@neukum.org
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se> <20060112134729.GB5700@flint.arm.linux.org.uk> <17350.33811.433595.750615@alkaid.it.uu.se> <20060112164621.GA9288@flint.arm.linux.org.uk> <43C69067.9040206@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C69067.9040206@arcom.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:22:47PM +0000, David Vrabel wrote:
> Russell King wrote:
> > BTW, it's worth noting that the new EABI stuff has it's own set of
> > problems.  We have r0 to r6 to pass 32-bit or 64-bit arguments.
> > With EABI, 64-bit arguments will be aligned to an _even_ numbered
> > register.
> 
> Is there a reason for this alignment requirement?

I think it comes from the 64-bit accessing instructions (ldrd/strd)
having the restriction that they only take an even numbered 32-bit
register.  The immediately consecutive higher numbered 32-bit 
egister is used as the other half of the number.

Think about it as the x86 32-bit eax register being made up of
16-bit ah and al registers.  Only we call then r0, r1 etc not
eax, ah and al (and they're twice the size.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
