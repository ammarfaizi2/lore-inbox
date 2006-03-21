Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWCUL0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWCUL0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWCUL0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:26:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19722 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030300AbWCUL0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:26:45 -0500
Date: Tue, 21 Mar 2006 07:54:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Blackfin serial driver for kernel 2.6.16
Message-ID: <20060321075425.GB21287@flint.arm.linux.org.uk>
Mail-Followup-To: Luke Yang <luke.adi@gmail.com>,
	linux-kernel@vger.kernel.org
References: <489ecd0c0603200207i33958c66kce8f54704302e79e@mail.gmail.com> <20060320102449.GA6787@flint.arm.linux.org.uk> <489ecd0c0603202345x1e12ea64y248baabc939965e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c0603202345x1e12ea64y248baabc939965e6@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 03:45:57PM +0800, Luke Yang wrote:
> On 3/20/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Mon, Mar 20, 2006 at 06:07:44PM +0800, Luke Yang wrote:
> > > Index: git/linux-2.6/drivers/serial/bfin_serial_5xx.c
> > > ===================================================================
> > > --- /dev/null
> > > +++ linux-2.6/drivers/serial/bfin_serial_5xx.c
> >
> > Please convert this driver to use the serial_core infrastructure.  Thanks.
>    Thank you! This is a driver based on the 68328 serial driver. Do
> you mean every serial driver must follow the serial core framework? If
> so, we'll change it ASAP.  For now, my previous blackfin architecture
> patch needs this driver to get compiled.

It is preferable since it massively reduces code duplication, and fixes
various minor issues found in the original serial driver.

As a result, it improves code maintainability since a fix to the semantics
of the serial layer will fix all drivers, instead of having to apply the
same fix to multiple serial drivers (which just doesn't happen.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
