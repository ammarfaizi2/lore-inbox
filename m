Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280524AbRKBDCF>; Thu, 1 Nov 2001 22:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280529AbRKBDBz>; Thu, 1 Nov 2001 22:01:55 -0500
Received: from ns.ithnet.com ([217.64.64.10]:55044 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S280524AbRKBDBm>;
	Thu, 1 Nov 2001 22:01:42 -0500
Message-Id: <200111020301.EAA30696@webserver.ithnet.com>
Date: Fri, 02 Nov 2001 04:01:27 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
To: Ed Tomlinson <tomlins@cam.org>
In-Reply-To: <20011102023711.EC03D93E4D@oscar.casa.dyndns.org>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,                                                                 
>                                                                     
> shrink_caches can end up lying.  shrink_dcache_memory and friends do
not tell                                                              
> shrink_caches how many pages they free so nr_pages can be bogus...  
Is it worth                                                           
> fixing?  The simpliest, harmlessly racey and not too pretty, code   
follows.  It                                                          
> would also not be hard to change the shrink_ calls to return the    
number of pages                                                       
> shrunk, but this would hit more code...                             
>                                                                     
> Comments?                                                           
                                                                      
I believe the idea of having a more precise nr_pages value can make a 
difference. We are trying to estimate if swapping is needed, which is 
pretty expensive. If we can avoid it by more accurately knowing what  
is really going on (without _too_ much costs) we can only win.        
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
