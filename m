Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUBOW3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUBOW3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:29:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:56478 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265233AbUBOW3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:29:21 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Osterlund <petero2@telia.com>
Cc: earny@net4u.de, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <m28yj42jcm.fsf@p4.localdomain>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <m2znbk4s8j.fsf@p4.localdomain> <200402152052.50596.earny@net4u.de>
	 <m28yj42jcm.fsf@p4.localdomain>
Content-Type: text/plain
Message-Id: <1076884077.6957.103.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 09:27:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 07:11, Peter Osterlund wrote:
> Ernst Herzberg <earny@net4u.de> writes:
> 
> > Compile warnings with new driver:
> > 
> > [...]
> > drivers/video/aty/radeon_base.c: In function `radeon_probe_pll_params':
> > drivers/video/aty/radeon_base.c:474: warning: `xtal' might be used uninitialized in this function
> 
> This looks like a real bug. I guess the patch below fixes it, but I
> can't test it because that code is not executed on my hardware. (And I
> doubt it will fix your problem.)

That code is buggy and isn't executed on HW were the BIOS if properly
found that is almost all HW at this point.

Thanks for the fix though. I wonder why I didn't get any gcc warning
on this one.

Ben.


