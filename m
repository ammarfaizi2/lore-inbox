Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293749AbSCKW5p>; Mon, 11 Mar 2002 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310133AbSCKW5c>; Mon, 11 Mar 2002 17:57:32 -0500
Received: from ns.ithnet.com ([217.64.64.10]:8723 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293659AbSCKWz6>;
	Mon, 11 Mar 2002 17:55:58 -0500
Message-Id: <200203112255.XAA02708@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Date: Mon, 11 Mar 2002 23:55:23 +0100
Content-Transfer-Encoding: 7BIT
Subject: Re: Linux 2.4.19-pre3
To: Marcelo Tosatti <marcelo@conectiva.com.br>
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
MIME-Version: 1.0
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                     
> Hi,                                                                 
>                                                                     
> Here goes -pre3, with the new IDE code. It has been stable enough   
time in                                                               
> the -ac tree, in my and Alan's opinion.                             
>                                                                     
> The inclusion of the new IDE code makes me want to have a longer    
2.4.19                                                                
> release cycle, for stress-testing reasons.                          
>                                                                     
> Please stress test it with huge amounts of data ;)                  
                                                                      
Would like to, but:                                                   
                                                                      
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3/include -Wall           
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer           
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2   
-march=i686 -DMODULE  -DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c  
pppoe.c: In function `pppoe_flush_dev':                               
pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)   
pppoe.c:282: (Each undeclared identifier is reported only once        
pppoe.c:282: for each function it appears in.)                        
pppoe.c: In function `pppoe_disc_rcv':                                
pppoe.c:446: `PPPOX_ZOMBIE' undeclared (first use in this function)   
pppoe.c: In function `pppoe_ioctl':                                   
pppoe.c:730: `PPPOX_ZOMBIE' undeclared (first use in this function)   
make[2]: *** [pppoe.o] Error 1                                        
make[2]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers/net'   
make[1]: *** [_modsubdir_net] Error 2                                 
make[1]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers'       
make: *** [_mod_drivers] Error 2                                      
                                                                      
                                                                      
Regards,                                                              
Stephan                                                               
