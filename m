Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSE0WTC>; Mon, 27 May 2002 18:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316772AbSE0WTB>; Mon, 27 May 2002 18:19:01 -0400
Received: from mark.mielke.cc ([216.209.85.42]:64008 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316770AbSE0WTB>;
	Mon, 27 May 2002 18:19:01 -0400
Date: Mon, 27 May 2002 18:12:27 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: Robert Schwebel <robert@schwebel.de>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020527181227.A8465@mark.mielke.cc>
In-Reply-To: <20020526011620.C598@schwebel.de> <Pine.LNX.4.33L2.0205270125220.24180-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 01:28:13AM -0400, Calin A. Culianu wrote:
> > Robert
> > ¹ There are surely small things which cannot be implemented in
> >   another way - try to write a counting loop in another way than
> >   for (i=0; i<N; i++) {printf(i);}
> void loopie(int N)
> {
> 	if (N) loopie(N-1);
> 	printf("%d ",N);
> }

" ... cannot be [sensibly] implemented in another way ... "

As somebody else pointed out, a good optimizer should be able to
unroll most types of loops / functions. With sufficient capabilities,
an optimizer should turn both of the above into the same object code
(potentially a faster executing version, or a tighter set of
instructions, than either of the above, unoptimized).

But then again... this whole thread-line is a little off-topic... we
all know it is the better lawyer who wins, not the developer who can
deduce the potential origin of a piece of code... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

