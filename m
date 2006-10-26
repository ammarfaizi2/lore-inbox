Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161445AbWJZW34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161445AbWJZW34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161448AbWJZW34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:29:56 -0400
Received: from c60.cesmail.net ([216.154.195.49]:50109 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S1161445AbWJZW3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:29:55 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Pavel Roskin <proski@gnu.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061026214600.GL27968@stusta.de>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <1161859199.12781.7.camel@localhost.localdomain>
	 <1161890340.9087.28.camel@dv>  <20061026214600.GL27968@stusta.de>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 18:29:53 -0400
Message-Id: <1161901793.9087.110.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 23:46 +0200, Adrian Bunk wrote:
> On Thu, Oct 26, 2006 at 03:19:00PM -0400, Pavel Roskin wrote:
> >...
> > 
> > This means that ndiswrapper would be considered as a derived work of
> > Linux.  Since ndiswrapper is under GPL, it would suffer unfairly if the
> > meaning of EXPORT_SYMBOL_GPL is extended to restrict GPLed modules
> > capable of loading proprietary code into the kernel.
> >...
> 
> You could always write a tiny GPL-ed wrapper module with the sole 
> purpose of offering all EXPORT_SYMBOL_GPL'ed functions through 
> EXPORT_SYMBOL'ed wrapper functions.

Yes, but it's irrelevant.  The kernel should not dictate how ndiswrapper
or any other driver should be structured.

I think such module would be quite inelegant.  It would be a useless
layer of indirection created to compensate for a kernel bug.

> You are using a gnu.org address for publically stating that trying to 
> prevent such kinds of wrapping was unfair?

I didn't even consider this trick.  I was talking about a more
reasonable split of the code loader from the bus-specific code.  Neither
did I suggest that it would be unfair to block any wrapping.  I said it
would be hard and technically infeasible.

I'm using the same e-mail address for all free software work.  I don't
represent Free Software Foundation, although I consider it a honor to
have an account with them.

> It's not even clear that any modules containing non-GPL'ed code were 
> legal.

I'm not a lawyer, but I think one cannot classify software as legal or
illegal.  The law governs what people do.  Running such mix may be legal
even if distribution is not.

Anyway, I don't think it's relevant to ndiswrapper.

> EXPORT_SYMBOL_GPL shows a pretty clear intention, and offering 
> functionality provided throug h EXPORT_SYMBOL_GPL'ed symbols to 
> proprietary code sounds very fishy.

Last time I checked, EXPORT_SYMBOL_GPL was an indication that a code
using it will be considered as a work derived from Linux.  This way,
ndiswrapper, which is free software, can be considered a derived work.

NDIS drivers don't know about any Linux API, therefore they cannot use
it directly.  The purpose of ndiswrapper is not to remove limitations
from the Linux API, but to present a completely different API.

Non-free code does not contains any code derived from Linux because it
wasn't even written for Linux.

-- 
Regards,
Pavel Roskin

