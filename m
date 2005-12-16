Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVLPSw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVLPSw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVLPSw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:52:59 -0500
Received: from mail1.kontent.de ([81.88.34.36]:7886 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932364AbVLPSw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:52:58 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 19:53:28 +0100
User-Agent: KMail/1.8
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
In-Reply-To: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161953.28986.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Dezember 2005 19:42 schrieb Horst von Brand:
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

How about ignoring physical pages and going to virtual, say, 16K pages?
After all, 4K is 15 years old. Disks and RAM have grown enormously.

	Regards
		Oliver

