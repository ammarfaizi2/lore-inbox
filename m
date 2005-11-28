Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVK1WMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVK1WMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVK1WMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:12:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8459 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751332AbVK1WMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:12:35 -0500
Date: Mon, 28 Nov 2005 22:12:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: Fix matching of MMIO ports
Message-ID: <20051128221229.GF14557@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1133212269.7768.220.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133212269.7768.220.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 08:11:08AM +1100, Benjamin Herrenschmidt wrote:
> The function uart_match_port() incorrectly compares the ioremap'd
> virtual addresses of ports instead of the physical address to find
> duplicate ports for MMIO based UARTs. This fixes it.

I'd like this to go in -mm for a bit before we put it into mainline,
just in case there's any undesirable side effects.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
