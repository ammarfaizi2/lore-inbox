Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWBGUAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWBGUAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWBGUAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:00:16 -0500
Received: from web60221.mail.yahoo.com ([209.73.178.109]:51063 "HELO
	web60221.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932416AbWBGUAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:00:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NAqZKMXyen832hKFnvzKLBo1sG2jJUMbyjKkcnGWfM+1Zxt7vsqzqXWAE3by+4lFXiQKO9wvP9HI3puvTgi8pF2ylzgkSEFKKiv7m9eh4sGAOJbpKwHdeicAKwrz3DmnOKxIOUQrT+XlM8l5Z/P3Vp1ChTwAFpDySTnzE/OPlrk=  ;
Message-ID: <20060207200013.30703.qmail@web60221.mail.yahoo.com>
Date: Tue, 7 Feb 2006 12:00:13 -0800 (PST)
From: anil dahiya <ak_ait@yahoo.com>
Subject: Badness in sleep_on_timeout on kernel 2.6.9-1.667 ( fedora core 3)
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello 
I am creating kernel thread on fedora core 4
(2.6.9-1.667)and my getting oops something like

 Badness in sleep_on_timeout at kernel/sched.c:3022
 [<02302bc3>] sleep_on_timeout+0x5d/0x23a
 [<0211b919>] default_wake_function+0x0/0xc

can any suggest how i can avoid this oops.
Regards,
Anil 

--- anil dahiya <ak_ait@yahoo.com> wrote:

> Hi Sam
> Thanks fop your help ..but my problem is not solved
> it
> ...i putting my real problem here below.
> 
> 1>my fist need is to make  module1.ko made using
> a1/a1.c , a1/a11.c & a2/a2.c a2/a22.c and all .c
> file
> use /home/include/a.h 
> 
>  
> 2>Now my 2nd need is to make module2.ko using
> module1.ko and b/b1.c & b/b11.c (these both .c files
> use /home/include/a.h and /home/module2/include/b.h)
> 
> 
> In short my directory  structure is as:
>   
> /home/------
>               |_ include _
>               |           |
>               |           a.h 
>               | 
>               |___module1_
>               |           |__ a1 ____________
>               |           |          |       |
>               |           |         a1.c   a11.c
>               |           |
>                           |__ a2 ___________
>               |           |           |     |
>               |           |         a2.c   a22.c
>               |
>               |___ moudule2_
>               |             |             
>               |             |__include _
>               |             |           |
>               |             |           b.h 
>               |             |___b1________
>               |                     |     |
>               |                   b1.c   b11.c
>          
>                                     
> Looking forward for ur reply 
> thanks in advance
>  ---- Anil 
> 
> 
> --- anil dahiya <ak_ait@yahoo.com> wrote:
> 
> > hello 
> > I want to make kernel module dummy.ko using
> multiple
> > .c and .h files. In short i am telling .c and .h
> > files
> > with directory structure
> > 
> > 1> dummy.ko should made be using module1.ko and
> > module2.o (i.e 
> >    module2.o uses module1.ko to make dummy.ko)
> > 
> > 2> module1.ko made using a1/a1.c & a2/a2.c and 
> both
> > .c file   
> >    use /home/include/a.h 
> > 3> module2.o should made using b/b1.c which use   
> >    use /home/module2/include/b.h 
> > 
> > Suggest me tht should make i make module2.o or
> > module2.ko and then combine it with module1.o to
> > make
> > dummy.ko 
> > 
> > 
> > /home/------
> >              |_ include _
> >              |           |
> >              |           a.h 
> >              | 
> >              |___module1_
> >              |           |__ a1 ____
> >              |           |          | 
> >              |           |         a1.c 
> >              |           |
> >                          |__ a2 ____
> >              |           |           | 
> >              |           |         a2.c 
> >              |
> >              |___ moudule2_
> >              |             |             
> >              |             |__include _
> >              |             |           |
> >              |             |           b.h 
> >              |             |___b1__
> >              |                     | 
> >              |                   b1.c 
> >         
> >                                    
> > Looking forward for ur reply 
> > thanks in advance
> > ---- Anil 
> > 
> > 
> > 		
> > __________________________________________ 
> > Yahoo! DSL – Something to write home about. 
> > Just $16.99/mo. or less. 
> > dsl.yahoo.com 
> > 
> > 
> > --
> > Kernelnewbies: Help each other learn about the
> Linux
> > kernel.
> > Archive:      
> > http://mail.nl.linux.org/kernelnewbies/
> > FAQ:           http://kernelnewbies.org/faq/
> > 
> > 
> 
> 
> 
> 		
> __________________________________________ 
> Yahoo! DSL – Something to write home about. 
> Just $16.99/mo. or less. 
> dsl.yahoo.com 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
