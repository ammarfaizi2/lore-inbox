Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287602AbSAHDKY>; Mon, 7 Jan 2002 22:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287604AbSAHDKP>; Mon, 7 Jan 2002 22:10:15 -0500
Received: from ns2.auctionwatch.com ([64.14.24.2]:55300 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S287602AbSAHDKG>; Mon, 7 Jan 2002 22:10:06 -0500
Date: Mon, 7 Jan 2002 19:10:01 -0800
From: Petro <petro@auctionwatch.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: andihartmann@freenet.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108031001.GA7019@auctionwatch.com>
In-Reply-To: <20020107202927.GC1227@auctionwatch.com> <200201080143.CAA19970@webserver.ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201080143.CAA19970@webserver.ithnet.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 02:43:42AM +0100, Stephan von Krawczynski wrote:
> > On Mon, Jan 07, 2002 at 03:33:48PM +0100, Stephan von Krawczynski   
> wrote:                                                                
> > > mysql question: is this a binary from some distro or              
> self-compiled? If                                                     
> > > self-compiled can you show your ./configure paras, please?        
> >                                                                     
> >     It's the binary from mysql.com.                                 
>                                                                       
> Beta or stable release?                                               

    Stable. 

> > > more efficient in low mem conditions and this may well be the case you are                                                               
> > > running into. This means 2.4.17 standard + patch.                 
> >      Is there a reasonable chance that martins patch will get mainlined                                                             
> >      in the near future?                                            
>                                                                       
> I really can't know. But to me the results look interesting enough to 
> give it a try on certain problem situations (like yours) to find out  
> if it is any better than the stock version. If you and others can     
> confirm that things get better then I have no real doubts that Marcelo
> can pick it up. 

    Out of ignorance and laziness, where is it again that I can get this
    kernel? 

> > One of the big reasons I chose to upgrade to a                      
> >      later kernel version (from 2.4.8ac<something>+LVMpatches+...)  
> was                                                                   
> >      to get away from having to apply patches (and document which   
> >      patches and where to get them etc).                            
>                                                                       
> Well, there is really nothing wrong with upgrading mainline kernels,

    Funny, I went from a working 2.4.8-ac<x> to a non-working
    2.4.13+patches when I started getting these crashes. At first I
    thought they were Mysql, so I called them. They said "Re-install
    windows", er, I mean upgrade my kernel to 2.4.16, which would "fix
    the problem", so I did, and it didn't. So they said to go to
    2.4.17rc2 as that would fix my problem, only it didn't. 


> as the are getting better with every release, so I would always       
> suggest to take the releases up lets say a week after being out. Only 

    Yeah, and build a debian package, distribute it to (looks behind me)
    100+ linux servers, including 6 mission critical heavily loaded DB
    machines. 

    Not to be a complete asswipe, but no. While I like playing with
    computers and all that, I don't have enough hours in the day to be
    rolling out new kernels every couple weeks and still have time left
    over to see my wife, shoot my guns, ride my motorcycles and drink my
    scotch. 

> your situation maybe can help to improve more, if you input some of   
> your experiences in LKML with a patch like Martins. Feedback _is_     
> required to find a solution to an existing problem.                   

    I understand completely, I'm just trying to figure out a way to test
    this that doesn't impact my site as drastically. See, we've only got
    two databases that will cause this fault, and of course they are the
    two most important ones, and the only way we can generate this fault
    is to put them live and wait for them to crash. 

> >      If this is the route I have to go, I'll do it but, well, I'm   
> not                                                                   
> >      that comfortable with it.                                      
>                                                                       
> Well, my suggestions: don't patch around too much, but try single     
> patches on stock kernel and evaluate them here.                       

    There are 2 other patches I need to apply, the first is the LVM
    1.0.1 patch, and the second is the VFS-lock patch. We need these to
    do snapshots. Which isn't bad, but I'm about the only one still here 
    who can do it (violates hit-by-a-bus rule).

-- 
Share and Enjoy. 
