Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVF3Jow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVF3Jow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVF3Jov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:44:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26634 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262912AbVF3Jot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:44:49 -0400
Date: Thu, 30 Jun 2005 10:44:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: vda@ilport.com.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
Message-ID: <20050630104445.C13407@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, vda@ilport.com.ua,
	linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua> <20050630095246.A13407@flint.arm.linux.org.uk> <20050630021111.35aaf45f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050630021111.35aaf45f.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 30, 2005 at 02:11:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 02:11:11AM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > Rejected-by: Russell King 8)
> > 
> > The reason is that now we're unable to find out if anyone's doing
> > udelay(100000000000000000) which breaks on most architectures.
> > 
> > There are a number of compile-time checks that your patch has removed
> > which catch such things, and as such your patch is not acceptable.
> > Some architectures have a lower threshold of acceptability for the
> > maximum udelay value, so it's absolutely necessary to keep this.
> 
> I don't recall seeing anyone trigger the check, and it hardly seems worth
> adding a "few kb" to vmlinux for it?

Maybe we can have both - would the space saving be achieved by just moving
mdelay and ssleep out of linux/delay.h and not touching asm-i386/delay.h?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
