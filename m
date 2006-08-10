Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbWHJKaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWHJKaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 06:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWHJKaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 06:30:15 -0400
Received: from colin.muc.de ([193.149.48.1]:17171 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1161142AbWHJKaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 06:30:13 -0400
Date: 10 Aug 2006 12:30:12 +0200
Date: Thu, 10 Aug 2006 12:30:12 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
Message-ID: <20060810103012.GA2356@muc.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <1155204603.18420.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155204603.18420.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 08:10:03PM +1000, Rusty Russell wrote:
> On Thu, 2006-08-10 at 19:35 +1000, Rusty Russell wrote:
> > This version over last version:
> > (1) Gets rid of the no_paravirt.h header and leaves native ops in place
> > (with some reshuffling to keep then under one #ifdef).
> > (2) Fixes the "X crashes with CONFIG_PARAVIRT=y" bug.
> > (3) Puts __ex_table entry in paravirt iret.
> 
> Gurp... that was old version.  This version removes the explicit "save
> flags and disable irqs" op (the binary patching patches it as one, but
> there's little point having a short-cut through the slow path).

Can you please do at least a s/__asm__/asm/g s/__volatile__/volatile/g ?

And you seem to have added some __volatiles too, that should be also 
volatile.

I would still prefer a better name that "nopara"

Some of the other cleanups are missing too, but I guess that could
be fixed later.

-Andi

