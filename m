Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUKIOrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUKIOrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKIOrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:47:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16133 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261530AbUKIOr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:47:27 -0500
Date: Tue, 9 Nov 2004 14:47:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line status changes.
Message-ID: <20041109144723.C15570@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1099659997.20469.71.camel@localhost.localdomain> <20041109012212.463009c7.akpm@osdl.org> <1099998437.6081.68.camel@localhost.localdomain> <1099998926.15462.21.camel@localhost.localdomain> <20041109132810.A15570@flint.arm.linux.org.uk> <1100006241.15742.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1100006241.15742.6.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 09, 2004 at 01:17:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 01:17:22PM +0000, Alan Cox wrote:
> So its broken, totally and utterly. Its the kind of undefined,
> unserialized crap that I'm trying to get _OUT_ of the serial layer.

I think you mean the tty layer here - the tty layer is where most of
the serialisation problems remain, and the locking in the serial
layer is mostly there to work around the tty layers deficiencies.

I would have liked to have rewritten the tty layer along the lines
that Ted was suggesting, but that would've been far too much work
for me to do alone.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
