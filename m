Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317993AbSFSUKP>; Wed, 19 Jun 2002 16:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317994AbSFSUKO>; Wed, 19 Jun 2002 16:10:14 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:22280 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317993AbSFSUKN>; Wed, 19 Jun 2002 16:10:13 -0400
Date: Wed, 19 Jun 2002 13:09:23 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH] (2/2) reverse mappings for current 2.5.23 VM
In-Reply-To: <E17Kiio-0000sO-00@starship>
Message-ID: <Pine.LNX.4.44.0206191248190.4292-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Daniel Phillips wrote:

> You might conclude from the above that the lru+rmap is superior to 
> aging+rmap: while they show the same wall-clock time, lru+rmap consumes 
> considerably less disk bandwidth.  

I wouldn't draw _any_ conclusions about either patch yet, because as you 
said, it's only one type of load.  And it was a single tick in vmstat 
where page_launder() was aggressive that made the difference between the 
two.  In a different test, where I had actually *used* more of the 
application pages instead of simply closing most of the applications 
(save one, the memory hog), the results are likely to have been very 
different.  

I think that Rik's right: this simply points out that page_launder(), at 
least in its interaction with 2.5, needs some tuning.  I think both 
approaches look very promising, but each for different reasons.  

-Craig

