Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272450AbTHGMWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275249AbTHGMWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:22:15 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:49794 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272450AbTHGMWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:22:14 -0400
Subject: Re: TI yenta-alikes (was: ToPIC specific init for yenta_socket)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, Tim Small <tim@buttersideup.com>,
       linux-pcmcia@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807100211.A17690@flint.arm.linux.org.uk>
References: <200308062025.08861.daniel.ritz@gmx.ch>
	 <20030806194430.D16116@flint.arm.linux.org.uk>
	 <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>
	 <20030806203217.F16116@flint.arm.linux.org.uk>
	 <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com>
	 <3F317FD7.6020209@buttersideup.com>
	 <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>
	 <20030807100211.A17690@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 13:18:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 10:02, Russell King wrote:
> doing is *wrong*.  The only people who know whether the pin has been
> wired for INTA or IRQ3 are the _designers_ of the hardware, not the
> Linux kernel.

That assumes the yenta controller isnt hotplugged.

> Currently, the Linux kernel assumes a "greater than designers" approach
> to fiddling with the registers which control the function of these pins,
> and so far I've seen:
> 
> - changing the mode from serial PCI interrupts to parallel PCI interrupts
>   causes the machine to lock hard (since some cardbus controllers use the
>   same physical pins for both functions.)

Basically we got burned by changing the IRQMUX register rather than just
using it as an information source.

