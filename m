Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWFSTpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWFSTpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWFSTpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:45:10 -0400
Received: from rtr.ca ([64.26.128.89]:45232 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964866AbWFSTpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:45:08 -0400
Message-ID: <4496FEC2.8050903@rtr.ca>
Date: Mon, 19 Jun 2006 15:45:06 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
References: <20060619180658.58945.qmail@web52908.mail.yahoo.com> <20060619184706.GH3479@flint.arm.linux.org.uk>
In-Reply-To: <20060619184706.GH3479@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>
> This seems to be an invalid situation - you appear to have an _ISA_
> NE2000 card using IRQ3, trying to share the same interrupt as a
> serial port.
> 
> ISA interrupts aren't sharable without additional hardware support
> or specific software support in the Linux kernel interrupt
> architecture.

If the drivers are written "correctly", they shouldn't grab the IRQ
until someone actually opens the device.  Which means they should be
able the share the IRQ, so long as both devices are not in use (open)
at the same time.

Cheers

