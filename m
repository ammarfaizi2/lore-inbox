Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVLPS4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVLPS4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVLPS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:56:21 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:57747 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932369AbVLPS4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:56:20 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Steven Rostedt <rostedt@goodmis.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Lee Revell <rlrevell@joe-job.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
In-Reply-To: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 13:55:29 -0500
Message-Id: <1134759329.13138.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 15:42 -0300, Horst von Brand wrote:
> linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:
> 
> [...]
> 
> > Throughout the past two years of 4k stack-wars, I never heard why
> > such a small stack was needed (not wanted, needed). It seems that
> > everybody "knows" that smaller is better and most everybody thinks
> > that one page in ix86 land is "optimum". However I don't think
> > anybody ever even tried to analyze what was better from a technical
> > perspective. Instead it's been analyzed as religious dogma, i.e.,
> > keep the stack small, it will prevent idiots from doing bad things.
> 
> OK, so here goes again...
> 
> The kernel stack has to be contiguous in /physical/ memory. Keep the stack
> /one/ page, that way you can always get a new stack when needed (== each
> fork(2) or clone(2)). If the stack is 2 (or more) pages, you'll have to
> find (or create) a multi-page free area, and (fragmentation being what it
> is, and Linux routinely running for months at a time) you are in a whole
> new world of pain.

So people should really be asking for a PAGE_SIZE = 8k option ;)

Sorry,

-- Steve


