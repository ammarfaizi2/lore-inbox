Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVAKKBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVAKKBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAKKBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:01:12 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:48943 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262666AbVAKKA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:00:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=U+FUReLuDyJRWIB3hptelXpM16DCNPVZW9lXUfQkvehUYn8eanb1y/UZsxkM41cpgG2fMTPhb8JYIDVnYAvblWEg9RJQIMzUvDP5dT8FAPofx6oSyiEuQjydFK5Ce8hnBM3lvKaNX2PngkU+0kqAB9Kh56pf63p2XzGrfrzjGzg=
Message-ID: <4d6522b905011102003cddca9@mail.gmail.com>
Date: Tue, 11 Jan 2005 12:00:58 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: tglx@linutronix.de
Subject: Re: User space out of memory approach
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1105435846.17853.85.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <4d6522b905011101202918f361@mail.gmail.com>
	 <1105435846.17853.85.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > > 1) ranking for the most likely culprits only starts when memory consumption
> > > >     gets close to the red zone (for example 98% or something like that).
> 
> We do the ranking only in the oom situation, so what's your point ?

The point is that kernel doesn't need to keep watching the memory space
every time a process needs memory. Only when memory is close this red zone.


> 
> > > > 2) killing just gets the first candidate from the list and kills it.
> > > > No need to calculate
> > > >     at kernel level.
> 
> So I need a userspace change in order to solve a kernel problem ?

You could see in another way. Release the kernel from calculating rating
so that better approaches of choosing the culprit can be proposed and
tested withoud mess too much the code.

> 
> > > What is the default behaviour when no userspace settings are available -
> > > Nothing ? Are you really expecting that we change every root fs in order
> > > to be able to upgrade the kernel for solving this _kernel_ problem ?
> >
> > No, I certainly don't. But, have seen the application we also posted? It is
> > a test for while, that actually starts a deamon when you boot the kernel
> > and does rate this application, i.e. an application with root rating priority
> > so it will never be killed and never lack space for itself.
> > So, the answer to your 2nd very good point.
> 
> You did not answer my question at all. I do not want to update my rootfs
> to solve a problem which exists in the kernel and must be solved in the
> kernel.

If you stick on this thought, then there is more to say, but rather send test
results soon so that you all can evaluate.

br

Edjard

-- 
"In a world without fences ... who needs Gates?"
