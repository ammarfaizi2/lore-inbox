Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVCDKke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVCDKke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVCDKke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:40:34 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:58730 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262623AbVCDKkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:40:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n4gE+8g04bupwvU7tcWLXwylmMHukuPX8v+l4Pkrqnmm8iZLzm6uXiLM5Kqr2SIZCzN7GJ9/IYAQ5SuzQ3wO+3KxMY5fCZX9R6MV4tuxX+NqbhKtCTHTmoZjh8mz1RvFXV66nPNGYpHsTDybyROmho+1mTJZH+ttVCJYcO6vzJA=
Message-ID: <58cb370e0503040240314120ea@mail.gmail.com>
Date: Fri, 4 Mar 2005 11:40:08 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mike Waychison <mike@waychison.com>
Subject: Re: [2.6 patch] unexport complete_all
Cc: Adrian Bunk <bunk@stusta.de>, Linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <422817C3.2010307@waychison.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422817C3.2010307@waychison.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2005 03:09:39 -0500, Mike Waychison <mike@waychison.com> wrote:
> > I didn't find any possible modular usage in the kernel.
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> > --- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old      2005-03-04 01:04:28.000000000 +0100
> > +++ linux-2.6.11-rc5-mm1-full/kernel/sched.c  2005-03-04 01:04:34.000000000 +0100
> > @@ -3053,7 +3053,6 @@
> >                        0, 0, NULL);
> >       spin_unlock_irqrestore(&x->wait.lock, flags);
> >  }
> > -EXPORT_SYMBOL(complete_all);
> >
> >  void fastcall __sched wait_for_completion(struct completion *x)
> >  {
> > -
> 
> This is a valid piece of API that is exported for future use.

Let me guess: autofsng?

It was you who added it (through akpm):


[PATCH] export complete_all()

From: Mike Waychison <Michael.Waychison@Sun.COM>

Export complete_all for module use.


Andrew, what is the policy for adding exports for out of tree GPL code?

IMHO although it is convenient for maintainers of such code it is
inconvenient for us (ie. when making changes to code) and gives
people false assumptions about stability of *in-kernel* APIs.

Bartlomiej
