Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVGKTD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVGKTD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVGKTBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:01:09 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:55261 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262025AbVGKS7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:59:50 -0400
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
From: Alex Williamson <alex.williamson@hp.com>
To: David Vrabel <dvrabel@arcom.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42CD2C16.1070308@arcom.com>
References: <42CA96FC.9000708@arcom.com>
	 <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 11 Jul 2005 13:00:08 -0600
Message-Id: <1121108408.28557.71.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 14:20 +0100, David Vrabel wrote:

> I've redid the patch and added a check for this.  Alex, could you test
> this version, please.

   This detects the A2 ST16C255x as an XR16550, so apparently the sleep
check doesn't work.  I contacted Exar about these two seemingly
identical UARTs, and they say that the A2 ST16C255x should be compatible
with the XR16550 so perhaps we don't need to special case the A2 UART at
all.  Unfortunately, when I use the UART for a console, I get garbled
output from the time the UART is detected until we hit userspace.  I
wonder if this has something to do with the early console registration
with a conflicting type...  I'll see if I can figure out what's going
on.  Have you used the XR16550 as a console on your system?  Perhaps
it's as simple as the baud getting reset via the has_efr check.  I'm
trying to use the system with a 115.2k baud rate.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

