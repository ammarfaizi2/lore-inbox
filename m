Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289354AbSAOB4Q>; Mon, 14 Jan 2002 20:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289355AbSAOB4G>; Mon, 14 Jan 2002 20:56:06 -0500
Received: from ns.ithnet.com ([217.64.64.10]:58374 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289354AbSAOBz5>;
	Mon, 14 Jan 2002 20:55:57 -0500
Message-Id: <200201150155.CAA24369@webserver.ithnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Date: Tue, 15 Jan 2002 02:55:15 +0100
Subject: Re: Memory problem with bttv driver
To: Hugh Dickins <hugh@veritas.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <Pine.LNX.4.21.0201142245040.2118-100000@localhost.localdomain>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 14 Jan 2002, Stephan von Krawczynski wrote:                 
> >                                                                   
> > Ok. So what do we do about it? I mean there are possibly some more
people out                                                            
> > there with such a problem, or - to my prediction - there will be  
more in the                                                           
> > future. I see to possibilities:                                   
> > 1) simply increase it overall. I have not the slightest idea what 
the drawbacks                                                         
> > are. 2) make it configurable (looks like general setup to me).    
> >                                                                   
> > I could provide a patch for either. Do we want that?              
>                                                                     
> I was waiting for hpa to jump on you for suggesting that!  but since
> he hasn't yet done so (publicly), here's his mail when I suggested  
it                                                                    
> a month ago (as a temporary aid while tracking down a similar       
problem).                                                             
>                                                                     
> That problem was from NTFS overusing vmalloc (and I think Anton has 
> now posted the fix), but NTFS wasn't in your list, and I assume you 
> didn't have it in statically.                                       
                                                                      
Nope, no ntfs involved here.                                          
I read the former thread. It was in my mind when trying the increased 
VMALLOC_RESERVE, and voila, it worked again. I must admit in your case
I was very much thinking that ntfs should be fixed, and I am pleased  
the maintainer thought the same :-)                                   
Unfortunately I do not have a good idea about what to do in days where
the graphics cards have more ram onboard than my last workstation had 
in total. If I understood Alans' opinion, he thinks basically the     
same, what the heck can you do about such monster cards? I don't know,
other than adjusting the RESERVE-area. I have not really thought about
it right now, but I suspect it would be rather impossible to make a   
somehow runtime-scalable area working, which would of course be the   
complete solution to the underlying problem.                          
                                                                      
So, what's left? At least configurable? Anybody with a better idea?   
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
>                                                                     
