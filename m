Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTIVQew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbTIVQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:34:52 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:8131 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263235AbTIVQet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:34:49 -0400
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80,
	in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030922162602.GB27209@mail.jlokier.co.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
	 <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
	 <20030922162602.GB27209@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 17:33:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-22 at 17:26, Jamie Lokier wrote:
> What sort of timer chip problems do you see?  Is it something that can
> be auto-detected, so that timer chip accesses can be made faster on
> boards where that is fine?

CS5520 is one example. Also VIA VP2 seems to care but only very very
occasionally. On my 386 board its reliably borked without the delays
(not sure what chipset and its ISA so harder to tell)

> I've also seen much DOS code that didn't have extra delays for
> keyboard I/Os.  What sort of breakage did you observe with the
> keyboard?

DEC laptops hang is the well known example of that one.

I'm *for* making this change to udelay, it just has to start up with a
suitably pessimal udelay assumption until calibrated.


