Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWBGWYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWBGWYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWBGWYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:24:00 -0500
Received: from khc.piap.pl ([195.187.100.11]:13322 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030206AbWBGWX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:23:59 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
	<1138844838.5557.17.camel@localhost.localdomain>
	<43E2B8D6.1070707@aarnet.edu.au>
	<20060203094042.GB30738@flint.arm.linux.org.uk>
	<20060206202654.GC2470@ucw.cz>
	<20060206205459.GB9388@flint.arm.linux.org.uk>
	<20060207091804.GA1840@elf.ucw.cz>
	<20060207174307.GA26558@flint.arm.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 07 Feb 2006 23:23:54 +0100
In-Reply-To: <20060207174307.GA26558@flint.arm.linux.org.uk> (Russell King's message of "Tue, 7 Feb 2006 17:43:07 +0000")
Message-ID: <m364nqn6yt.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> In that case the problem is unsolvable.  What if I named a process
>
> \n+++ATH0\n
>
> ?  Oh dear, your modem just hung up.  Or maybe:
>
> \n+++AT&C0\n
>
> and now your modem always sets DCD active, so even with detection of DCD
> in the kernel, I can now talk to it via process names after I've forced
> it to disconnect.
>
> And yes, there's modems out there which accept that and act on the '+++'
> immediately - no pause after '+++' required.

Correct, but the escape character can usually be disabled with ATS2=128
or something like that.

The problem was common some time ago with people putting X-header: +++ATH\n
(or was that +++ATH\r ?) in mail headers.
-- 
Krzysztof Halasa
