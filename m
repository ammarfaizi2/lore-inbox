Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVGFU2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVGFU2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVGFUYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:24:09 -0400
Received: from ccerelrim01.cce.hp.com ([161.114.21.22]:58060 "EHLO
	ccerelrim01.cce.hp.com") by vger.kernel.org with ESMTP
	id S261718AbVGFUUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:20:23 -0400
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050706195740.A28758@flint.arm.linux.org.uk>
References: <42CA96FC.9000708@arcom.com>
	 <20050706195740.A28758@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 06 Jul 2005 14:20:31 -0600
Message-Id: <1120681231.14959.3.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.0.137324, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.6.25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 19:57 +0100, Russell King wrote:
> On Tue, Jul 05, 2005 at 03:19:40PM +0100, David Vrabel wrote:
> > The 8250 serial driver detects the Exar XR16L2551 as a 16550A.  The
> > XR16L2551 has an EFR register and sleep capabilities (UART_CAP_FIFO |
> > UART_CAP_EFR | UART_CAP_SLEEP).  However, broken_efr() thinks it's a
> > buggy Exar ST16C255x.
> 
> Grumble!

Double grumble...

> > Perhaps it's okay for the ST16C255x to be detected as something with
> > UART_CAP_EFR | UART_CAP_SLEEP even if it doesn't work? i.e., by removing
> > broken_efr().
> 
> I don't know - maybe Alex Williamson can try your patch out.

   I can, but not till next week when I can get into the office and dig
up the box with the broken A2 rev UARTs.  Let me know if you need an
answer before then.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

