Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288395AbSACXoK>; Thu, 3 Jan 2002 18:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288399AbSACXoD>; Thu, 3 Jan 2002 18:44:03 -0500
Received: from ns.ithnet.com ([217.64.64.10]:20241 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288395AbSACXnp>;
	Thu, 3 Jan 2002 18:43:45 -0500
Message-Id: <200201032342.AAA30005@webserver.ithnet.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <akpm@zip.com.au>, <znmeb@aracnet.com>,
        <art@lsr.nei.nih.gov>, <linux-kernel@vger.kernel.org>
Date: Fri, 04 Jan 2002 00:42:51 +0100
Subject: Re: kswapd etc hogging machine
To: Rik van Riel <riel@conectiva.com.br>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <Pine.LNX.4.33L.0201031531090.24031-100000@imladris.surriel.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 3 Jan 2002, Stephan von Krawczynski wrote:                  
> > On Thu, 3 Jan 2002 14:51:01 -0200 (BRST)                          
> > Rik van Riel <riel@conectiva.com.br> wrote:                       
> > > On Thu, 3 Jan 2002, Alan Cox wrote:                             
> > >                                                                 
> > > > 2.4.1x VM code is performing better under light loads but its 
> > > > absolutely and completely hopeless under a real paging load.  
2.4.17-aa                                                             
> > > > is somewhat better interestingly.                             
> > >                                                                 
> > > A quick 'make -j bzImage' test I did yesterday got the system   
> > > to use near 70% of its CPU time in user mode and 30% in system  
> > > mode. This was with 2.4.17-rmap-10b, btw.                       
> >                                                                   
> > And what kind of an argument is this? This is an honest question, 
> > really. If I do this make I end up around 80-90% in user mode and 
the                                                                   
> > rest in system on a standard 2.4.17 SMP box (configured with too  
less                                                                  
> > swap btw).                                                        
>                                                                     
> How much memory does that box have ?                                
>                                                                     
> In my case it was with 512 MB of RAM, the system went almost        
> 900 MB into swap.                                                   
                                                                      
I cannot back this statement. Though my machine has 1 GB RAM I did the
make in a situation where countless processes were running amongst    
them mail-client, Mozilla with several windows, seti, numerous xterms,
all in all 16 desktops full with this and that. I'd say it was a bit  
more than 600 MB free (meaning cached of course). But I have only     
256MB of swap. During the make a damn lot of paging was going on and  
swap went from 70 MB up to about 210 MB, but that was it. Load was    
around 154 at top. As the thing was over all came back to normal and  
bzImage was working.                                                  
I did not see any problem.                                            
I will drive mem down to around 400 MB tomorrow for another test.     
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
