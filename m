Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290213AbSAWXrM>; Wed, 23 Jan 2002 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290215AbSAWXrD>; Wed, 23 Jan 2002 18:47:03 -0500
Received: from ns.ithnet.com ([217.64.64.10]:14859 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290213AbSAWXq5>;
	Wed, 23 Jan 2002 18:46:57 -0500
Message-Id: <200201232346.AAA12999@webserver.ithnet.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Date: Thu, 24 Jan 2002 00:46:45 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva>
Content-Transfer-Encoding: 7BIT
Subject: Re: Linux 2.4.18-pre7: compile error
To: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                     
> Hi,                                                                 
>                                                                     
> So here goes pre7.                                                  
>                                                                     
> pre7:                                                               
>                                                                     
> - Make ext2/minix/sysvfs actually operate                           
>   synchronously on directories when using                           
>   the sync mount option				(Andrew Morton)                          
> - AFFS update					(Roman Zippel)                                    
> - Fix 3dfx fb crash with high pixelclock 	(Jurriaan on Alpha)       
> - PATH_MAX POSIX compliance			(Rusty Russell)                       
> - Really apply AMD Elan patch			(me)                                
> - Don't drop IP packets with less than 8 bytes                      
>   of payload 					(David S. Miller)                                 
> - Netfilter update 				(Netfilter team)                             
> - Backport 2.5 sb_bread() changes		(Alexander Viro)                 
> - Fix AF_UNIX fd leak				(David S. Miller)                          
> - Add Audigy Gameport PCI ID	 		(Daniel Bertrand)                   
> - Sync with ia64 arch independant parts		(Keith Owens)              
> - APM fixes					(Stephen Rothwell)                                  
> - fs/super.c cleanups				(Alexander Viro)                           
                                                                      
"I am sorry, Dave. I'm afraid I can't do that":                       
                                                                      
gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-pre7/include -Wall           
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer           
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2   
-march=i686 -DMODULE  -DKBUILD_BASENAME=ipfwadm_core  -c -o           
ipfwadm_core.o ipfwadm_core.c                                         
ipfwadm_core.c: In function `free_fw_chain':                          
ipfwadm_core.c:691: called object is not a function                   
ipfwadm_core.c: In function `insert_in_chain':                        
ipfwadm_core.c:735: called object is not a function                   
ipfwadm_core.c: In function `append_to_chain':                        
ipfwadm_core.c:786: called object is not a function                   
ipfwadm_core.c: In function `del_from_chain':                         
ipfwadm_core.c:861: called object is not a function                   
make[2]: *** [ipfwadm_core.o] Error 1                                 
make[2]: Leaving directory                                            
`/usr/src/linux-2.4.18-pre7/net/ipv4/netfilter'                       
make[1]: *** [_modsubdir_ipv4/netfilter] Error 2                      
make[1]: Leaving directory `/usr/src/linux-2.4.18-pre7/net'           
make: *** [_mod_net] Error 2                                          
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
