Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVGWPj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVGWPj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 11:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVGWPhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 11:37:24 -0400
Received: from fsmlabs.com ([168.103.115.128]:23480 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261773AbVGWPgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 11:36:53 -0400
Date: Sat, 23 Jul 2005 09:41:46 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: fix suspend/resume irq request free for yenta..
In-Reply-To: <20050723084049.A7921@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0507230941280.16055@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0507222331580.15287@skynet>
 <200507221816.19424.dtor_core@ameritech.net> <20050723002924.GA1988@elf.ucw.cz>
 <20050723084049.A7921@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2005, Russell King wrote:

> On Sat, Jul 23, 2005 at 02:29:24AM +0200, Pavel Machek wrote:
> > > Is it necessary to do free_irq for suspend? Shouldn't disable_irq
> > > be enough?
> > 
> > Due to recent changes in ACPI, yes, it is neccessary.
> 
> What if some other driver is sharing the IRQ, and requires IRQs to be
> enabled for the resume to complete?

This certainly is the case on many laptops.
