Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTI0KUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 06:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTI0KUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 06:20:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262419AbTI0KUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 06:20:13 -0400
Date: Sat, 27 Sep 2003 11:20:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Ejecting a CardBus device
Message-ID: <20030927112010.G3440@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <1064628015.1393.5.camel@teapot.felipe-alfaro.com> <20030927082806.A681@flint.arm.linux.org.uk> <1064657889.1381.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064657889.1381.1.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Sat, Sep 27, 2003 at 12:18:09PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 12:18:09PM +0200, Felipe Alfaro Solana wrote:
> On Sat, 2003-09-27 at 09:28, Russell King wrote:
> > On Sat, Sep 27, 2003 at 04:00:16AM +0200, Felipe Alfaro Solana wrote:
> > > How can I tell the CardBus subsystem to eject my CardBus NIC by software
> > > with 2.6.0 kernels? In 2.4 I could use "cardctl eject", but I don't know
> > > how to do the same on 2.6.0-test5-mm4.
> > 
> > The same works with 2.6.0-test5.
> 
> I doesn't seem to work: "cardctl eject" complains that no pcmcia driver
> appears in /proc/devices. Any ideas?

That'll be because ds got unloaded.  Although ds isn't required for
cardbus cards, it does provide the interface to cardctl.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
