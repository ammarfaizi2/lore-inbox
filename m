Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVAQL0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVAQL0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 06:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVAQL0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 06:26:38 -0500
Received: from mail.suse.de ([195.135.220.2]:20387 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262769AbVAQL0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 06:26:35 -0500
Date: Mon, 17 Jan 2005 12:26:11 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x8664_ksyms.c: unexport register_die_notifier
Message-ID: <20050117112611.GK29270@wotan.suse.de>
References: <20050116074649.GW4274@stusta.de> <20050117092654.GB29270@wotan.suse.de> <1105955659.6304.62.camel@laptopd505.fenrus.org> <20050117101318.GF29270@wotan.suse.de> <1105960768.6304.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105960768.6304.69.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 12:19:28PM +0100, Arjan van de Ven wrote:
> On Mon, 2005-01-17 at 11:13 +0100, Andi Kleen wrote:
> > On Mon, Jan 17, 2005 at 10:54:18AM +0100, Arjan van de Ven wrote:
> > > On Mon, 2005-01-17 at 10:26 +0100, Andi Kleen wrote:
> > > > On Sun, Jan 16, 2005 at 08:46:49AM +0100, Adrian Bunk wrote:
> > > > > The only user of register_die_notifier (kernel/kprobes.c) can't be 
> > > > > built modular. Therefore, it's the EXPORT_SYMBOL is superfluous.
> > > > 
> > > > Please don't apply this, it was especially intended for modular debuggers.
> > > > There is already a hacvked kdb around that uses it.
> > > 
> > > eh didn't Tigran just mail lkml claiming that kdb and x86-64 really
> > > don't mix ??
> > 
> > It cannot display function arguments and uses imprecise backtrace right now
> > (like normal oopses), other than that it works just fine. 
> 
> does it need any other kernel patches? Because if it does it might as
> well patch this export in for it's specialist use

The modular kdb needs other patches right now yes, but I would still
like to keep it for other debuggers. Previously we always had tons of 
ugly patchkit comming with every debugging add on and the exception 
notifiers were exactly designed to provide a clean interface for 
everybody for this.  I definitely don't want to go back to the old 
"own patch for everbody" mess again on x86-64.

-Andi
> 
