Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278943AbRKANrl>; Thu, 1 Nov 2001 08:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278945AbRKANrb>; Thu, 1 Nov 2001 08:47:31 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:39175 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278943AbRKANrS>; Thu, 1 Nov 2001 08:47:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>, Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: graphical swap comparison of aa and rik vm
Date: Thu, 1 Nov 2001 08:47:16 -0500
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0111011009090.2963-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0111011009090.2963-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011101134727Z278943-17409+7399@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 07:10, Rik van Riel wrote:
> On Thu, 1 Nov 2001, Mark Hahn wrote:
> > also, if you merely sum the SI and SO columns for each:
> > 		sum(SI)		sum(SO)		sum(SI+SO)
> >       Rik-VM	43564		317448		290032
> >       AA-VM	118284		171748		361012
> > to me, this looks like the same point: Rik being SO-happy,
> > Andrea having to SI a lot more.  interesting also that Andrea wins the
> > race, in spite of poorer SO choices and more swap traffic overall.
>
> I think this is because in safemode's test, the swap space
> gets exhausted.  My VM works better when there is lots of
> swap space available but degrades in the (rare) case where
> swap space is exhausted.
>
> Testing corner cases always gives interesting results ;)
>
> regards,
>
> Rik

In my previous post i mentioned something like that as to why your vm didn't 
perform as well.  The thing isn't that you use all of my available memory 
(ram + swap), it's that you allocate it all, leaving nothing for the program 
later on.  I think anything that uses almost a gig of ram outside of 
databases is going to be a corner case, but perhaps a better way to figure 
out how much memory should be allocated is needed here.   Andrea's vm seems 
to do a good job at that.  if only he could figure out a better way to swap 
out pages correctly the first time (as some people say his made more mistakes 
than yours) then i cant really find anything bad about it.  And i'm trying 
to.  

Also as others pointed out.   After the process was done. You had quite a lot 
more swap still allocated.  Why exacty?   
