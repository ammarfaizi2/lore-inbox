Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVAQKNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVAQKNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVAQKNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:13:24 -0500
Received: from news.suse.de ([195.135.220.2]:41418 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262191AbVAQKNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:13:19 -0500
Date: Mon, 17 Jan 2005 11:13:18 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x8664_ksyms.c: unexport register_die_notifier
Message-ID: <20050117101318.GF29270@wotan.suse.de>
References: <20050116074649.GW4274@stusta.de> <20050117092654.GB29270@wotan.suse.de> <1105955659.6304.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105955659.6304.62.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 10:54:18AM +0100, Arjan van de Ven wrote:
> On Mon, 2005-01-17 at 10:26 +0100, Andi Kleen wrote:
> > On Sun, Jan 16, 2005 at 08:46:49AM +0100, Adrian Bunk wrote:
> > > The only user of register_die_notifier (kernel/kprobes.c) can't be 
> > > built modular. Therefore, it's the EXPORT_SYMBOL is superfluous.
> > 
> > Please don't apply this, it was especially intended for modular debuggers.
> > There is already a hacvked kdb around that uses it.
> 
> eh didn't Tigran just mail lkml claiming that kdb and x86-64 really
> don't mix ??

It cannot display function arguments and uses imprecise backtrace right now
(like normal oopses), other than that it works just fine. 

-Andi
