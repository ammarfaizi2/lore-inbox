Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUGEDSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUGEDSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 23:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUGEDSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 23:18:17 -0400
Received: from web20809.mail.yahoo.com ([216.136.226.198]:23967 "HELO
	web20809.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265886AbUGEDSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 23:18:13 -0400
Message-ID: <20040705031812.4571.qmail@web20809.mail.yahoo.com>
Date: Sun, 4 Jul 2004 20:18:12 -0700 (PDT)
From: Fawad Lateef <fawad_lateef@yahoo.com>
Subject: Re: Re: Need help in creating 8GB RAMDISK
To: joelja@darkwing.uoregon.edu
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Joel 

Can you please tell me the way of using more than 4GB
of RAM in a single process or module ???? I tried to
solve that problem using threads, but it isn't working
tooo, there might be the problem in my thread
implementation but can it be done using threads ???
Please do tell me way of doing this ......... 

I also tried to make 2 different modules each for 4GB
and then made another module which is just receiving
the request changes its bh->b_rdev to the
corresponding drive and returns 1. So kernel will try
to call the request function of the module related to
bh->b_rdev. but this is also not working .!!!!

Please help me ..... I m working on Linux-2.4.23

Thanks and Regards,

Fawad Lateef




> On Sun, 4 Jul 2004, Fawad Lateef wrote:
> 
> > Hello
> > 
> > I am creating a RAMDISK of 7GB (from 1GB to 8GB).
> I
> > reserved the RAM by changing the code in
> > arch/i386/mm/init.c .......... 
> > 
> > But I am not able to access the RAM from 1GB to
> 8GB in
> > a kernel module ........ after crossing the 4GB
> RAM,
> > the system goes into standby state. But if I
> insert
> > the same module 2 times means one for 1GB to 4GB
> and
> > other for 4GB to 8GB. and mount them seprately
> both
> > works fine ............ 
> 
> on a non-64bit intel architecture you can only grab
> 4GB of ram per 
> process because that's how big the page table is.
> There are 16 4GB page 
> tables for the 64GB ram that intel machines are
> capable of addressing.
>  
> > Can any one tell me the reason behind this ??? I
> think
> > that in a single module we can't access more than
> 4GB
> > RAM ...... If this is the reason then what to do
> ??? I
> > need 7GB RAMDISK as a single drive ....
> > 
> > Thanks and Regards,
> > 
> > Fawad Lateef
> > 
> > 
> > 		
> > __________________________________
> > Do you Yahoo!?
> > Yahoo! Mail - You care about security. So do we.
> > http://promotions.yahoo.com/new_mail
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
>
--------------------------------------------------------------------------
> 
> Joel Jaeggli  	       Unix Consulting 	      
> joelja@darkwing.uoregon.edu    
> GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3
> C38B F000 35AB B67F 56B2
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
