Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290302AbSAPAhH>; Tue, 15 Jan 2002 19:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290301AbSAPAg6>; Tue, 15 Jan 2002 19:36:58 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:27149 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S290300AbSAPAgk>; Tue, 15 Jan 2002 19:36:40 -0500
Date: Tue, 15 Jan 2002 21:23:47 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre4
In-Reply-To: <200201160029.BAA06423@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.21.0201152122350.27220-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jan 2002, Stephan von Krawczynski wrote:

> >                                                                     
> > So here goes pre4.                                                  
>                                                                       
> aehm, did I spoil it myself, or is it someone else:                   
>                                                                       
> compiling .... and then:                                              
>                                                                       
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} 
> pcmcia                                                                
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map             
> 2.4.18-pre4; fi                                                       
> depmod: *** Unresolved symbols in                                     
> /lib/modules/2.4.18-pre4/kernel/fs/minix/minix.o                      
> depmod:         waitfor_one_page                                      
>                                                                       
> ..config was taken over from 2.4.17, where it was working.             
>                                                                       
> ??                                                                    

My mistake. Add "EXPORT_SYMBOL(waitfor_one_page);" to kernel/ksyms.c.

Already fixed in my tree.

Thanks.


