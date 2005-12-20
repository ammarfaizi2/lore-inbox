Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVLTOha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVLTOha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVLTOha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:37:30 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:47573 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751080AbVLTOh3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:37:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OrqgC57IWIS9x31hMUAF0X0d3NFVJ2rrL3JYsrAyl2RvwfBlaC+xQaqQ+p697JQ1Niy6LiQBMy9Om/jji1CFDZkGRZExf8p6ExcIGBoAWL6HB8jEetTE0sYul9uL5lkWFCpUCZECOZxTSD9/3mxNUKxodnPgbgTHuVdAIbf4FXA=
Message-ID: <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
Date: Tue, 20 Dec 2005 09:37:28 -0500
From: Mike Snitzer <snitzer@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: About 4k kernel stack size....
Cc: Mark Lord <lkml@rtr.ca>, "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, nel@vger.kernel.org,
       mpm@selenic.com
In-Reply-To: <20051220133729.GC6789@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051218231401.6ded8de2@werewolf.auna.net>
	 <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Dec 19, 2005 at 09:52:53PM -0500, Mark Lord wrote:
> >...
> > The mainline code paths are undoubtedly fine with 4K stacks.
> > It's the *error paths* that are most likely to go deeper on the stack,
> > and those are rarely exercised by anyone.  And those are the paths
> > that we *really* need to be reliable.
>
> "most likely" is a strong sentence, especially considering that the
> automatic analysis of all possible call chains can and has already
> identified several such problems (which have now been fixed many months
> ago).
>
> We might not getting 100% security against stack overflows, but that's
> not fundamentally different from the current situation with 6 kB stacks.

Given this last statement, why is it that Matt Mackall's suggestion in
the "Light-weight dynamically extended stacks" thread didn't get any
_real_ discussion from the big 4K stack advocates?  For all intents
and purposes, Matt was dismissed with the same Bunk: "Ever since
neilb's patch there are 0 bugs.. blah blah".  4K, 8K (aka "6 kB")
aside; having more stack safety in the Linux kernel is a "good thing"
no?  Aren't dynamic stacks a viable means to imposing 4K (but doing so
with real safety)?

Mike
