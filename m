Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVA2Uxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVA2Uxw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVA2Uxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:53:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8465 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261558AbVA2Uxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:53:50 -0500
Date: Sat, 29 Jan 2005 20:53:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mike Cumings <mcumings@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Yenta CardBus IRQ storm disabling interrupt
Message-ID: <20050129205345.A14428@flint.arm.linux.org.uk>
Mail-Followup-To: Mike Cumings <mcumings@gmail.com>,
	linux-kernel@vger.kernel.org
References: <1295c7b005012912423352cd9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1295c7b005012912423352cd9d@mail.gmail.com>; from mcumings@gmail.com on Sat, Jan 29, 2005 at 12:42:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 12:42:17PM -0800, Mike Cumings wrote:
> In my Googling, I encountered a thread on January 10th of this year entitled
> "yenta_socket rapid fires interrupts" (between Dick Hollenbeck, Linus,
> and others)

Out of interest, is it the same cardbus card you're inserting into
the socket as the problem mentioned above?

I think what is suspected is that the Cardbus card is holding its
interrupt output active.  This normally shares the same interrupt
as the yenta socket status change interrupt, and, since we're
listening for interrupts from the card, it causes this problem.

A thought: can you reproduce this problem with 2.4?  Has this cardbus
card been used with other Linux kernels?  On other machines?

I suspect what you'll find is that any Linux kernel on any machine
with this card will exhibit this problem - which would prove my
theory.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
