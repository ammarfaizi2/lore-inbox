Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWBCJYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWBCJYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWBCJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:24:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22546 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932156AbWBCJYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:24:41 -0500
Date: Fri, 3 Feb 2006 09:24:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060203092435.GA30738@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk> <20060202132726.GD24903@pazke> <20060202201734.GA17329@flint.arm.linux.org.uk> <20060203091308.GA19805@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203091308.GA19805@pazke>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:13:08PM +0300, Andrey Panin wrote:
> On 033, 02 02, 2006 at 08:17:35 +0000, Russell King wrote:
> > As I've said many a time, we need a generic way to set different hand-
> > shaking modes.  I've suggested using some spare bits in termios in the
> > past, but nothing ever came of that - folk lose interest at that point.
> 
> IMHO there is no need to userspace visible changes to support RS485 on
> these cards, because some of them are RS485 only and some have jumpers
> for individual ports.  There is nothing that userspace can configure.
> We only need to set two bits in ACR according to card type and jumper
> settings and UART will drive RS485 transiever transparently.

In this particular case you may be right, but I'm looking at the bigger
picture, where plain 16550's may be used for RS485.

There are drivers which want to implement their own private ioctl to
enable RS485 mode.  What I'm saying is that we should have one solution,
not multiple solutions to this problem.  When we have such a solution,
your RS485 card will be able to fit into that model.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
