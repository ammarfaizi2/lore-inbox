Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272882AbRIPV7g>; Sun, 16 Sep 2001 17:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272859AbRIPV71>; Sun, 16 Sep 2001 17:59:27 -0400
Received: from ns.ithnet.com ([217.64.64.10]:50700 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272886AbRIPV7Q>;
	Sun, 16 Sep 2001 17:59:16 -0400
Message-Id: <200109162159.XAA11989@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andreas Steinmetz <ast@domdv.de>, <linux-kernel@vger.kernel.org>
Date: Sun, 16 Sep 2001 23:59:33 +0100
Content-Transfer-Encoding: 7BIT
Subject: Re: broken VM in 2.4.10-pre9
To: Linus Torvalds <torvalds@transmeta.com>
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0109161415340.22182-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [...]                                                               
> Anybody willing to test the simple used-once cleanups? No           
guarantees, but                                                       
> at least they make sense (some of the old interactions certainly do 
not).                                                                 
                                                                      
Very willing. Just send it to me, please.                             
                                                                      
> (The new code is a simple state machine:                            
>                                                                     
>  - touch non-referenced page: set the reference bit                 
>                                                                     
>  - touch already referenced page: move it to next list "upwards" (ie
the                                                                   
>    active list)                                                     
>                                                                     
>  - age a non-referenced page on a list: move to "next" list         
downwards (ie                                                         
>    free if already inactive, move to inactive if currently active)  
>                                                                     
>  - age a referenced page on a list: clear ref bit and move to       
beginning of                                                          
>    same list.                                                       
                                                                      
Are you sure about the _beginning_? You are aging out _all_ non-ref   
pages in the next step?                                               
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
