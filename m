Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVCFKTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVCFKTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVCFKTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:19:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261353AbVCFKTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:19:17 -0500
Date: Sun, 6 Mar 2005 10:19:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix for 8250.c *wrongly* detecting XScale UART(s) on x86 PC
Message-ID: <20050306101912.A19558@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20050306093321.GA3040@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050306093321.GA3040@taniwha.stupidest.org>; from cw@f00f.org on Sun, Mar 06, 2005 at 01:33:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 01:33:21AM -0800, Chris Wedgwood wrote:
> Breaks my UARTS.
> 
> I'm not thrilled with this patch but 8250.c has similar warts so I
> guess it's not too bad.  Ideally we could refactor this a bit so if
> this isn't acceptable let me know and I'll do that instead.

If it breaks here (due to your ports being "embraced and extended") it
could well break elsewhere, and wrapping it in CONFIG_ARM doesn't solve
that.

I'm not sure what the solution to this is, but unless we can autodetect
the port "type", it rather screws the current direction of 8250, which
has been to move away from port types to a set of port capabilities.

I wonder if its possible to get hold of any documentation for your
misdetected serial port...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
