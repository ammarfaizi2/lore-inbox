Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271266AbUJVMkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271266AbUJVMkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271273AbUJVMce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:32:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45327 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271266AbUJVMZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:25:36 -0400
Date: Fri, 22 Oct 2004 13:25:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] platform_get_irq() return for no IRQ
Message-ID: <20041022132530.A3459@flint.arm.linux.org.uk>
Mail-Followup-To: Ben Dooks <ben-linux@fluff.org>,
	linux-kernel@vger.kernel.org
References: <20041020174015.GA13087@fluff.org> <20041022101018.GA17957@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041022101018.GA17957@home.fluff.org>; from ben-linux@fluff.org on Fri, Oct 22, 2004 at 11:10:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 11:10:18AM +0100, Ben Dooks wrote:
> On Wed, Oct 20, 2004 at 06:40:15PM +0100, Ben Dooks wrote:
> > in drivers/base/platform.c, platform_get_irq() returns 0 if
> > there is no IRQ found in the resources, however 0 is a valid
> > IRQ on at least some of the ARM architectures.
> > 
> > This patch changes the return code to be -ENOENT instead.
> > 
> > Signed-of-by: Ben Dooks <ben-linux@fluff.org>
> > 
> 
> I should have also pointed out that as few things are
> actually using this at the moment, it would be a good
> idea to get this changed as soon as possible.

A better solution would be to make it return NO_IRQ.  There's been some
discussions recently about having this implemented across all platforms,
and that's what stopped me submitting the version which used this macro
back when this was merged. (the fact that NO_IRQ is not defined by
everyone)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
