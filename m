Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284174AbRLKXYe>; Tue, 11 Dec 2001 18:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284175AbRLKXYY>; Tue, 11 Dec 2001 18:24:24 -0500
Received: from ns.ithnet.com ([217.64.64.10]:56848 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284174AbRLKXYD>;
	Tue, 11 Dec 2001 18:24:03 -0500
Message-Id: <200112112323.AAA23377@webserver.ithnet.com>
Date: Wed, 12 Dec 2001 00:23:53 +0100
Subject: Re: NULL pointer dereference in moxa driver
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Christian Laursen <xi@borderworlds.dk>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m37krtl6cv.fsf@borg.borderworlds.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stephan von Krawczynski <skraw@ithnet.com> writes:                  
> Seems I got somewhat closer now.                                    
>                                                                     
> After reading the documentation again, I realised that I was        
accessing                                                             
> the wrong device.                                                   
>                                                                     
> I belive I read in another file, that the second board started at   
> device 32. However device 8 is the first port on the second board.  
>                                                                     
> And actually that seems to work. (I cant confirm this 100% before   
> I get to work tomorrow and actually attach something to the port)   
                                                                      
Well, this driver does only support 32 Ports. everyone more crashes   
definitely. I haven't seen such a broken source in years. I urge you  
to delete the device nodes above 31 to overcome any chance to crash   
again.                                                                
                                                                      
Most interestingly the moxa-driver is better by far than the mxser. It
seems to me the mxser is _really_ old. If you want to help us all,    
please try to contact moxa support and tell them it is high time to   
submit a _new_ mxser.c to the kernel tree, because the old (currently 
used) one is such a mess. They can do better (proven in moxa.c).      
At least a multiboard setup is completely broken. My patch fixes this 
but this does not help the main kernel tree.                          
                                                                      
I cannot submit a patch to marcelo, because I am not the maintainer,  
and we all don't want to fork a new mxser-driver apart from the       
original.                                                             
                                                                      
Oh dear.                                                              
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
                                                                      
