Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVK3Qz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVK3Qz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVK3Qz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:55:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34061 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751457AbVK3Qz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:55:56 -0500
Date: Wed, 30 Nov 2005 16:55:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Franck <vagabon.xyz@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Message-ID: <20051130165546.GD1053@flint.arm.linux.org.uk>
Mail-Followup-To: Franck <vagabon.xyz@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <cda58cb80511300821y72f3354av@mail.gmail.com> <20051130162327.GC1053@flint.arm.linux.org.uk> <cda58cb80511300845j18c81ce6p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80511300845j18c81ce6p@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 05:45:33PM +0100, Franck wrote:
> 2005/11/30, Russell King <rmk+lkml@arm.linux.org.uk>:
> > On Wed, Nov 30, 2005 at 05:21:35PM +0100, Franck wrote:
> > > Hi,
> > >
> > > What about this patch which removes ARM dependency for dm9000 ethernet
> > > controller driver ?
> > >
> > Maybe that should be (ARM || MIPS) && NET_ETHERNET ?
> >
> 
> Well, if this dependency means "it has only be tested on ARM and
> MIPS", then you're probably right. But if it means "this controller
> must be run with an ARM or MIPS cpu" then I don't see why setting such
> restriction. What do you think ?

If other CPUs use this then fine, but I find that having config options
needlessly available to all architectures is annoying - especially when
they are never used.

Eg, would you ever expect to see a DM9000 ethernet device on an x86
machine?  Probably not - there's far better PCI solutions now.

So until someone says "I want to use this on such and such arch" I
think it's better to keep it dependent on those we know are likely
to support it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
