Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVIGSGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVIGSGX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVIGSGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:06:23 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:47372 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750756AbVIGSGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:06:22 -0400
Date: Wed, 7 Sep 2005 19:06:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: viro@ZenIV.linux.org.uk, "David S. Miller" <davem@davemloft.net>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (GEN_RTC dependencies)
In-Reply-To: <20050906174818.GB3966@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.61L.0509071853030.4591@blysk.ds.pg.gda.pl>
References: <20050906005645.GQ5155@ZenIV.linux.org.uk>
 <20050905.185141.44096788.davem@davemloft.net> <20050906022423.GT5155@ZenIV.linux.org.uk>
 <Pine.LNX.4.61L.0509061109350.6760@blysk.ds.pg.gda.pl>
 <20050906174818.GB3966@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005, Tom Rini wrote:

> >  Yep, it's an excuse for platform maintainers not to write proper drivers.
> 
> I talked with Al about this off list a bit, and pointed out it's
> different than it appears.  GEN_RTC really is a mostly-generic RTC
> driver.  There's some fakey stuff going on for UIE (all under
> GEN_RTC_X), but the real meat of the driver is common export get/set
> time and per-arch (which can abstract further, see ppc32) poke the
> hardware for the time. There's 2 (afaik) problems, one being a lack of
> alarm support, and the other being hardware access isn't (today)
> abstracted out far enough for i2c stuff to work.

 The generic problem with the generic driver is it only supports the bare 
minimum an RTC might support and no way to provide access to what more 
sophisticated hardware may implement (e.g. an IRQ).  There is simply no 
room for that in the API.  And I have seen proposals for reducing the 
MC146818 to GEN_RTC, too...

 It's certainly good enough for simple implementations of RTCs, like a 
battery backed-up 32-bit register counting milliseconds since the 
beginning of the year (a so-called TOY clock).

  Maciej
