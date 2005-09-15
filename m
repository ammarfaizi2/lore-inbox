Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbVIOW1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVIOW1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbVIOW1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:27:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23565 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965294AbVIOW1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:27:37 -0400
Date: Thu, 15 Sep 2005 23:27:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epca iomem annotations + several missing readw()
Message-ID: <20050915232730.D26124@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20050915192704.GC25261@ZenIV.linux.org.uk> <20050915231014.C26124@flint.arm.linux.org.uk> <20050915221914.GD19626@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050915221914.GD19626@ftp.linux.org.uk>; from viro@ftp.linux.org.uk on Thu, Sep 15, 2005 at 11:19:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 11:19:14PM +0100, Al Viro wrote:
> On Thu, Sep 15, 2005 at 11:10:14PM +0100, Russell King wrote:
> > On Thu, Sep 15, 2005 at 08:27:04PM +0100, Al Viro wrote:
> > > [originally sent to Alan, he had no problems with it]
> > > 	* iomem pointers marked as such
> > > 	* several direct dereferencings of such pointers replaced with
> > > read[bw]().
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Thanks for copying me, but I have no interest in any serial driver
> > which doesn't use the serial core interface.
> > 
> > I don't want to act as "person to review any change just because the
> > driver says serial" - that's not the role I decided to get involved
> > with.
> 
> Hey, seeing the intensity of your complaints about _not_ being Cc'd...
> Better safe than serial maintainer ;-)

My feelings as well when I get random serial bugs in bugzilla for drivers
I have zero clue about and no one to assign them to. 8/

> 	OK, so what stuff do you want to be Cc'd on?  My current approximation
> would be arch/arm/*, include/asm-arm/*,drivers/serial/*,include/linux/serial*.
> Well, and any changes of tty interfaces, if I ever get involved in such...
> Any additions/removals?

Broadly, it's:

arch/arm/*
drivers/*/arm
drivers/mfd/*		(this fits at the moment, but whether it will in
			 the future depends what else appears there.)

drivers/mmc/*
drivers/serial*		(though only the drivers in there actually using
			 serial_core - unfortunately some non-serial_core
			 drivers appear to have been placed in there.)

include/asm-arm/*
include/linux/8250*
include/linux/serial*
fs/adfs/*

but there are various drivers authored by myself which I'd obviously be
interested in CC'ed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
