Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269622AbUI3X5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269622AbUI3X5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269624AbUI3X5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:57:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:47276 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269622AbUI3X5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:57:05 -0400
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200409301014.00725.bjorn.helgaas@hp.com>
References: <200409301014.00725.bjorn.helgaas@hp.com>
Content-Type: text/plain
Message-Id: <1096588409.3083.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 09:53:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 02:14, Bjorn Helgaas wrote:

> This looks like a reasonable short-term fix, but I think the whole
> serial8250_isa_init_ports() should go away.  I like dwmw2's suggestion
> of an 8250_platform.c that could use register_serial() for each port
> in some platform-supplied old_serial_port[] table, which is probably
> what you mean by moving to a more dynamic allocation.

What would this file look like ? a bunch of platform #ifdef's with
different implementations each time ? 

> AFAICS, the only reason for doing serial8250_isa_init_ports() early
> is for early serial consoles, and I think those should be done along
> the lines of this:
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1034.html
> where the platform can specify a device by its MMIO or IO port address,
> and we automatically switch to the corresponding ttyS device later.

Eventually...

In the meantime, that patch would fix urgent problems for ppc now so
I'd appreciate if Russell would consider it for inclusion asap. This
is the kind of subject on which everybody comes up with a different
"better" way to do it and no code, and nothign ever gets implemented
and we end up with no progress...

Ben.


