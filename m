Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277605AbRJHXcc>; Mon, 8 Oct 2001 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277607AbRJHXcX>; Mon, 8 Oct 2001 19:32:23 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:30726 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277611AbRJHXcO>; Mon, 8 Oct 2001 19:32:14 -0400
Date: Tue, 9 Oct 2001 01:31:59 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: torvalds@transmeta.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <653073165.1002585197@[195.224.237.69]>
Message-ID: <Pine.LNX.3.96.1011009010928.13677A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Alex Bligh - linux-kernel wrote:

> --On Tuesday, 09 October, 2001 12:21 AM +0200 Mikulas Patocka 
> <mikulas@artax.karlin.mff.cuni.cz> wrote:
> 
> > If you have more than half of virtual space free, you can always find two
> > consecutive free pages. Period.
> 
> Now calculate the probability of not being able to do this in physical
> space, assuming even page dispersion, and many pages free. You will
> find it is very small. This may give you a clue as to what the problem
> actually is.

My patch is not providing "very small probability". It is providing _zero_
probability that fork fails. (assiming that there is more than half
vmalloc space free).

I'm just tired of this stupid flamewar. 

Linus, what do you think: is it OK if fork randomly fails with very small
probability or not?

Are you going to accept patch that maps task_struct into virtual space if
buddy allocator fails or not? 

Mikulas

