Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVEQC0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVEQC0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 22:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVEQC0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 22:26:54 -0400
Received: from waste.org ([216.27.176.166]:30443 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261236AbVEQC0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 22:26:52 -0400
Date: Mon, 16 May 2005 19:26:33 -0700
From: Matt Mackall <mpm@selenic.com>
To: coywolf@lovecn.org
Cc: Andrew Morton <akpm@osdl.org>, YhLu@tyan.com, linux-tiny@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: serial console
Message-ID: <20050517022633.GI5914@waste.org>
References: <3174569B9743D511922F00A0C943142309F80D9F@TYANWEB> <20050516205731.GA5914@waste.org> <20050516231508.GD5914@waste.org> <20050516163712.66a1a058.akpm@osdl.org> <20050516234757.GG5914@waste.org> <2cd57c9005051618243be2ae14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c9005051618243be2ae14@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 09:24:23AM +0800, Coywolf Qi Hunt wrote:
> On 5/17/05, Matt Mackall <mpm@selenic.com> wrote:
> > On Mon, May 16, 2005 at 04:37:12PM -0700, Andrew Morton wrote:
> > >
> > > It would be nicer if this was a static inline, so all the function call
> > > code at the callsites is removed by the compiler.
> > 
> > Better yet, a patch that's actually right. add_preferred_console is
> > setting the console used by init and so on, so it's still relevant
> > with CONFIG_PRINTK off. So I just move it out of the ifdef. Obviously
> > more correct(tm).
> > 
> > Move add_preferred_console out of CONFIG_PRINTK so serial console does
> > the right thing.
> 
> 
> What's the purpose of serial console if printk is disabled?  I suggest
> we put add_preferred_console and all its callers, console code etc
> into CONFIG_PRINTK.

Serial console is currently two things: where to write kernel
messages, and the terminal init is attached to.

-- 
Mathematics is the supreme nostalgia of our time.
