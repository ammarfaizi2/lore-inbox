Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWGKS4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWGKS4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWGKS4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:56:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35342 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751180AbWGKS4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:56:37 -0400
Date: Tue, 11 Jul 2006 19:56:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.18-rc1-mm1 - bad serial port count messages
Message-ID: <20060711185630.GA1240@flint.arm.linux.org.uk>
Mail-Followup-To: John Stoffel <john@stoffel.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <17587.42397.168635.821696@stoffel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17587.42397.168635.821696@stoffel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 09:20:29AM -0400, John Stoffel wrote:
> I'm getting the following messages in dmesg:
> 
>   uart_close: bad serial port count; tty->count is 1, state->count is 0
>   uart_close: bad serial port count for ttyS0: -1
>   uart_close: bad serial port count for ttyS0: -1

I assume that it's 100% reproducable, and doesn't happen with mainline?

I'm not aware of any serial core patches in -mm which would produce this
type of breakage - maybe there's something funny with the tty layer in
that it's trying to close the port more times than it's been opened...
Hmm.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
