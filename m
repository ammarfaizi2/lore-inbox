Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285056AbRLLCtX>; Tue, 11 Dec 2001 21:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbRLLCtN>; Tue, 11 Dec 2001 21:49:13 -0500
Received: from ns.ithnet.com ([217.64.64.10]:26631 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285056AbRLLCtG>;
	Tue, 11 Dec 2001 21:49:06 -0500
Message-Id: <200112120248.DAA24783@webserver.ithnet.com>
Date: Wed, 12 Dec 2001 03:48:39 +0100
Subject: Re: NULL pointer dereference in moxa driver
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Tim Hockin <thockin@hockin.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        xi@borderworlds.dk (Christian Laursen), linux-kernel@vger.kernel.org
In-Reply-To: <200112112329.fBBNTqc13889@www.hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There is no maintainer, and our code base has drifted a fair way  
from what                                                             
> > moxa originally submitted (being a 2.0 driver with the serial     
transmit race                                                         
> > bug).                                                             
> >                                                                   
> > Anyone who wants to beat the mxser driver into shape, go for it.  
>                                                                     
> I'm using it under 2.4.x, but I missed the rest of this thread -    
what are                                                              
> the issues?                                                         
                                                                      
Ok. Short summary (on mxser, moxa is different):                      
                                                                      
- multiple board support is broken                                    
- driver blows up on illegal device minor numbers opened              
- no security checks whatsoever on internal array overflows           
- Completely broken port-number setup                                 
- No visible NULL-pointer checks regarding dynamic structures         
                                                                      
It looks like original taiwanese work: it is usable, but there are so 
many dead ends in this code, you won't believe - and I did only look  
some few minutes on it.                                               
                                                                      
It desperately needs cleanup.                                         
                                                                      
Listen Tim, if you want to do it, I can help you. But keep in mind, I 
have no hardware. So I am probably not the right guy for maintenance. 
If you do not feel comfortable, I will try it.                        
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
