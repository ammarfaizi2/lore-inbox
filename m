Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVKLV7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVKLV7L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVKLV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:59:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16136 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964803AbVKLV7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:59:10 -0500
Date: Sat, 12 Nov 2005 21:59:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-kernel@vger.kernel.org, dsaxena@plexity.net
Subject: Re: [PATCH,resend] don't disable xscale serial ports after autoconfig
Message-ID: <20051112215900.GH28987@flint.arm.linux.org.uk>
Mail-Followup-To: Lennert Buytenhek <buytenh@wantstofly.org>,
	linux-kernel@vger.kernel.org, dsaxena@plexity.net
References: <20051030134209.GD24313@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030134209.GD24313@xi.wantstofly.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 02:42:09PM +0100, Lennert Buytenhek wrote:
> xscale-type UARTs have an extra bit (UUE) in the IER register that has
> to be written as 1 to enable the UART.  At the end of autoconfig() in
> drivers/serial/8250.c, the IER register is unconditionally written as
> zero, which turns off the UART, and makes any subsequent printch() hang
> the box.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
