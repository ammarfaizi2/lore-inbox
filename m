Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWHACtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWHACtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWHACtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:49:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030408AbWHACtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:49:21 -0400
Date: Mon, 31 Jul 2006 19:49:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: ak@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 built-in command line
Message-Id: <20060731194910.6ef04be0.akpm@osdl.org>
In-Reply-To: <20060801014319.GO6908@waste.org>
References: <20060731171442.GI6908@waste.org>
	<200607312207.58999.ak@suse.de>
	<44CE6AEA.2090909@zytor.com>
	<200608010017.00826.ak@suse.de>
	<20060801014319.GO6908@waste.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 20:43:19 -0500
Matt Mackall <mpm@selenic.com> wrote:

> On Tue, Aug 01, 2006 at 12:17:00AM +0200, Andi Kleen wrote:
> > On Monday 31 July 2006 22:41, H. Peter Anvin wrote:
> > > Andi Kleen wrote:
> > > >   
> > > >> +#ifdef CONFIG_CMDLINE_BOOL
> > > >> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > > >> +#endif
> > > > 
> > > > I think I would prefer a strcat.
> > > > 
> > > > Also you should describe the exact behaviour (override/append) in Kconfig help.
> > > > 
> > > 
> > > In the i386 thread, Matt described having a firmware bootloader which 
> > > passes bogus parameters.  For that case, it would make sense to have a 
> > > non-default CONFIG option to have override rather than conjoined (and I 
> > > maintain that the built-in command line should be prepended.)
> > 
> > Is that boot loader common? What's its name? 
> > If not I would prefer that he keeps the one liner patch to deal
> > with that private.
> > 
> > For generic semantics strcat (or possible prepend) is probably better.
> 
> No, it doesn't work for numerous kernel options that can't be negated.

I think what I'm hearing is that we need three options: append, prepend or replace.
