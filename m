Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268486AbRGXV6A>; Tue, 24 Jul 2001 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268487AbRGXV5u>; Tue, 24 Jul 2001 17:57:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34829 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268486AbRGXV5p>; Tue, 24 Jul 2001 17:57:45 -0400
Date: Tue, 24 Jul 2001 17:27:31 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <01072405473005.00301@starship>
Message-ID: <Pine.LNX.4.21.0107241722310.2263-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 24 Jul 2001, Daniel Phillips wrote:

> Today's patch tackles the use-once problem, that is, the problem of
> how to identify and discard pages containing data likely to be used 
> only once in a long time, while retaining pages that are used more 
> often.
> 
> I'll try to explain not only what I did, but the process I went
> through to arrive at this particular approach.  This requires some 
> background.

Well, as I see the patch should remove the problem where drop_behind()
deactivates pages of a readahead window even if some of those pages are
not "used-once" pages, right ? 

I just want to make sure the performance improvements you're seeing caused
by the fix of this _particular_ problem.

If we knew the amount of non-used-once pages which drop_behind() is
deactivating under _your_ tests, we could make absolute sure about the
problem. 



