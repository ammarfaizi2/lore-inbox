Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVBYXSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVBYXSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVBYXSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:18:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:25010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262797AbVBYXSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:18:07 -0500
Date: Fri, 25 Feb 2005 15:20:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-Id: <20050225152009.14cdf450.akpm@osdl.org>
In-Reply-To: <20050225230246.GI3311@stusta.de>
References: <20050224233742.GR8651@stusta.de>
	<20050224212448.367af4be.akpm@osdl.org>
	<20050225214326.GE3311@stusta.de>
	<20050225135504.7749942e.akpm@osdl.org>
	<20050225230246.GI3311@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> > +#ifdef MODULE
> > +#define __deprecated_in_modules __deprecated
> > +#else
> > +#define __deprecated_in_modules /* OK in non-modular code */
> > +#endif
> > +
> >...
> 
> Looks good.
> 
> 
> One more question:
> 
> You get a false positive if the file containing the symbol is itself a 
> module.

I don't understand what you mean.

You mean that a module is doing an EXPORT_SYMBOL of a symbol which is on
death row?

If so: err, not sure.  I guess we could just live with the warning.

> Is there any way to solve this without additional #define's and #ifdef's 
> for each symbol?

Not that I can think of.
