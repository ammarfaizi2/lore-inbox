Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264087AbRFET1q>; Tue, 5 Jun 2001 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264088AbRFET1g>; Tue, 5 Jun 2001 15:27:36 -0400
Received: from kanga.kvack.org ([216.129.200.3]:5905 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S264087AbRFET1Z>;
	Tue, 5 Jun 2001 15:27:25 -0400
Date: Tue, 5 Jun 2001 15:21:16 -0400 (EDT)
From: "Benjamin C.R. LaHaise" <blah@kvack.org>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Zlatko Calusic <zlatko.calusic@iskon.hr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <Pine.LNX.4.33.0106051140270.1227-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.3.96.1010605151500.25725C-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Mike Galbraith wrote:

> Yes.  If we start writing out sooner, we aren't stuck with pushing a
> ton of IO all at once and can use prudent limits.  Not only because of
> potential allocation problems, but because our situation is changing
> rapidly so small corrections done often is more precise than whopping
> big ones can be.

Hold on there big boy, writing out sooner is not better.  What if the
memory shortage is because real data is being written out to disk?
Swapping early causes many more problems than swapping late as extraneous
seeks to the swap partiton severely degrade performance.

		-ben

