Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWJHVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWJHVpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWJHVpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:45:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52124 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751488AbWJHVpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:45:15 -0400
Subject: Re: BIOS THRM-Throttling and driver timings
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Keith Chew <keith.chew@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061008211821.GA4280@elf.ucw.cz>
References: <20f65d530610030729o42658bd6hcc204f8deac4a33e@mail.gmail.com>
	 <1159886437.2891.532.camel@laptopd505.fenrus.org>
	 <20061008211821.GA4280@elf.ucw.cz>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 08 Oct 2006 23:45:06 +0200
Message-Id: <1160343907.3000.183.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 23:18 +0200, Pavel Machek wrote:
> Hi!
> 
> > > We have a motherboard that has Thermal Throttling in the BIOS (which
> > > we cannot disable). This causes the CPU usage to go up and down when
> > > the CPU temperature reaches (and stays around) the Throttling
> > > temperature point.
> > > 
> > > What we would like to know is whether this will affect the timings in
> > > drivers, eg the wireless drivers we are using. What can we check in
> > > drivers' code that will tell us that its operations may be affected
> > > the throttling?
> > > 
> > > In the past few days, we noticed that some of the linux units we
> > > deployed freezes after deveral hours of operation, we are now trying
> > > to reproduce the problem in our test environment. Some insight on the
> > > affect of throttling will help us narrow down the search.
> 
> > in general linux should be ok with this happening. However for specific
> > cases... you'll need to provide more information; you're not
> > mentioning
> 
> Really? AFAICT P4 will happily slow down behind our backs, making at
> least udelays() with interrupts disabled sleep for too long.

it will during thermal throttle yes. but udelay() and co as API never
have  been super accurate; they mostly promise at least this much delay



