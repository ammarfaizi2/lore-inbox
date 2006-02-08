Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbWBHVe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbWBHVe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWBHVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:34:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17937 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965141AbWBHVe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:34:57 -0500
Date: Wed, 8 Feb 2006 21:34:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250 serial console update uart_8250_port ier
Message-ID: <20060208213448.GA8587@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602070848060.4804-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0602070848060.4804-100000@gate.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 08:52:03AM -0600, Kumar Gala wrote:
> On some embedded PowerPC (MPC834x) systems an extra byte would some times be
> required to flush data out of the fifo. serial8250_console_write() was updating
> the IER in hardware withouth also updating the copy in uart_8250_port. This
> causes issues functions like serial8250_start_tx() and __stop_tx() to misbehave.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
