Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310332AbSCLBua>; Mon, 11 Mar 2002 20:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310330AbSCLBuY>; Mon, 11 Mar 2002 20:50:24 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37874
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310120AbSCLBuM>; Mon, 11 Mar 2002 20:50:12 -0500
Date: Mon, 11 Mar 2002 17:50:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020312015059.GA711@matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva> <200203112255.XAA02708@webserver.ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203112255.XAA02708@webserver.ithnet.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 11:55:23PM +0100, Stephan von Krawczynski wrote:
> >                                                                     
> > Hi,                                                                 
> >                                                                     
> > Here goes -pre3, with the new IDE code. It has been stable enough   
> time in                                                               
> > the -ac tree, in my and Alan's opinion.                             
> >                                                                     
> > The inclusion of the new IDE code makes me want to have a longer    
> 2.4.19                                                                
> > release cycle, for stress-testing reasons.                          
> >                                                                     
> > Please stress test it with huge amounts of data ;)                  
>                                                                       
> Would like to, but:                                                   
>                                                                       
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3/include -Wall           
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer           
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2   
> -march=i686 -DMODULE  -DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c  
> pppoe.c: In function `pppoe_flush_dev':                               
> pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)   
> pppoe.c:282: (Each undeclared identifier is reported only once        
> pppoe.c:282: for each function it appears in.)                        
> pppoe.c: In function `pppoe_disc_rcv':                                
> pppoe.c:446: `PPPOX_ZOMBIE' undeclared (first use in this function)   
> pppoe.c: In function `pppoe_ioctl':                                   
> pppoe.c:730: `PPPOX_ZOMBIE' undeclared (first use in this function)   
> make[2]: *** [pppoe.o] Error 1                                        
> make[2]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers/net'   
> make[1]: *** [_modsubdir_net] Error 2                                 
> make[1]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers'       
> make: *** [_mod_drivers] Error 2                                      

same here, with gcc 2.95.4 (debian -woody).

What is your compiler version (in case it's 3.x)?
