Return-Path: <linux-kernel-owner+w=401wt.eu-S1753505AbWLWLku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbWLWLku (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 06:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbWLWLku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 06:40:50 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3839 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbWLWLkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 06:40:49 -0500
Date: Sat, 23 Dec 2006 11:40:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arnaud Patard <apatard@mandriva.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>,
       Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 2.6.20-rc1 6/6] S3C2410 GPIO wrappers
Message-ID: <20061223114037.GB28306@flint.arm.linux.org.uk>
Mail-Followup-To: Arnaud Patard <apatard@mandriva.com>,
	David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Bill Gatliff <bgat@billgatliff.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Tony Lindgren <tony@atomide.com>,
	pHilipp Zabel <philipp.zabel@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net> <200612201314.19905.david-b@pacbell.net> <m3ac1h7d3s.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ac1h7d3s.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 11:33:11AM +0100, Arnaud Patard wrote:
> > +#include <asm/arch/irqs.h>
> 
> imho, this is not needed. The user who will use irq will add it in his
> code anyway.
> 
> > +#include <asm/arch/hardware.h>

This is a pet peave.  _NO_ drivers should include either of these two
headers directly.  Use asm/irq.h and asm/hardware.h instead.  Audit your
code to ensure that you're including the right headers please.

I can see that I've got to do another sweep of the entire kernel code
to fix all these again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
