Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVLREWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVLREWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 23:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVLREWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 23:22:32 -0500
Received: from quelen.inf.utfsm.cl ([200.1.19.194]:15822 "EHLO
	quelen.inf.utfsm.cl") by vger.kernel.org with ESMTP id S965076AbVLREWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 23:22:31 -0500
Message-Id: <200512170016.jBH0GQE3004715@quelen.inf.utfsm.cl>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Lee Revell <rlrevell@joe-job.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from Steven Rostedt <rostedt@goodmis.org> 
   of "Fri, 16 Dec 2005 13:55:29 CDT." <1134759329.13138.129.camel@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 16 Dec 2005 21:16:26 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 2005-12-16 at 15:42 -0300, Horst von Brand wrote:
> > linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:
> > 
> > [...]
> > 
> > > Throughout the past two years of 4k stack-wars, I never heard why
> > > such a small stack was needed (not wanted, needed). It seems that
> > > everybody "knows" that smaller is better and most everybody thinks
> > > that one page in ix86 land is "optimum". However I don't think
> > > anybody ever even tried to analyze what was better from a technical
> > > perspective. Instead it's been analyzed as religious dogma, i.e.,
> > > keep the stack small, it will prevent idiots from doing bad things.
> > 
> > OK, so here goes again...
> > 
> > The kernel stack has to be contiguous in /physical/ memory. Keep the stack
> > /one/ page, that way you can always get a new stack when needed (== each
> > fork(2) or clone(2)). If the stack is 2 (or more) pages, you'll have to
> > find (or create) a multi-page free area, and (fragmentation being what it
> > is, and Linux routinely running for months at a time) you are in a whole
> > new world of pain.

> So people should really be asking for a PAGE_SIZE = 8k option ;)

On i386 is is either 4KiB or 4MiB. Guess what I prefer...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

