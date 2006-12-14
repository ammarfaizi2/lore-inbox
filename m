Return-Path: <linux-kernel-owner+w=401wt.eu-S932582AbWLNLZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWLNLZG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWLNLZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:25:06 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38463 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932582AbWLNLZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:25:05 -0500
Date: Thu, 14 Dec 2006 11:33:11 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: tglx@linutronix.de
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061214113311.24ba9b7f@localhost.localdomain>
In-Reply-To: <1166087742.29505.79.camel@localhost.localdomain>
References: <20061213195226.GA6736@kroah.com>
	<Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	<1166044471.11914.195.camel@localhost.localdomain>
	<Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	<1166048081.11914.208.camel@localhost.localdomain>
	<1166049055.29505.47.camel@localhost.localdomain>
	<20061213235601.2a565229@localhost.localdomain>
	<1166087742.29505.79.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IRQ is shared with the disk driver, box dead.
> 
> Err ? 
> 
> IRQ happens
> 
> IRQ is disabled by the generic handling code
> 
> Handler is invoked and checks, whether the irq is from the device or
> not. 
>  - If not, it returns IRQ_NONE, so the next driver (e.g. disk) is
> invoked.
>  - If yes, it masks the chip on the device, which disables the chip
> interrupt line and returns IRQ_HANDLED.
> 
> In both cases the IRQ gets reenabled from the generic irq handling code
> on return, so why is the box dead ?

I wrote this before your "generic" layer was in fact explained further to
not be generic at all and involve a new driver for each device. Your
original explanation was not clear.

Alan
