Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317348AbSGIRYs>; Tue, 9 Jul 2002 13:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSGIRYr>; Tue, 9 Jul 2002 13:24:47 -0400
Received: from 205-158-62-91.outblaze.com ([205.158.62.91]:16525 "HELO
	ws3-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317348AbSGIRYp>; Tue, 9 Jul 2002 13:24:45 -0400
Message-ID: <20020709172723.18529.qmail@email.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: haveblue@us.ibm.com
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Tue, 09 Jul 2002 12:27:23 -0500
Subject: Re: lock_kernel check...
X-Originating-Ip: 166.90.46.99
X-Originating-Server: ws3-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 09 Jul 2002 02:08:18 -0700 
To: dan carpenter <error27@email.com>
Subject: Re: lock_kernel check...

> cc'ing LKML 'cause this is interesting...
> 
> dan carpenter wrote:
>  > As you can see, the attached script is dead simple.  It prints an
>  > error every time you call return while lock_kernel is held.  On
>  > your computer you will want to comment out print_url() and
>  > uncomment the regular print statement.
> 
> I am continually amazed at all the simple, useful, cool stuff that 
> people come up with.  I like!
> 

Glad you liked it.  :) 

Smatch.pm is from the smatch.sf.net scripts page.  Smatch is a really unfinished code checker that I've been working on.  It is based on reading the papers about the Stanford checker.   

Unfortunately, after a night of sleep I realize that my script is broken for 2 reasons.  
1)  Smatch.pm is meant to track state changes down different code paths.  But unfortunately it wasn't doing that in this case; it was just going down the code without taking into consideration any if_stmts  etc.  I'm extremely embarassed about that.  Sorry.  
2)  What the Stanford checker does is print an error if one return_stmt is called while the kernel is locked and one is called while the kernel is unlocked.  This seems reasonable.

I will fix both mistakes later on this week.  Unfortunately I'm in the process of moving and looking for a job etc so I might not get to it for a bit.

regards,
dan carpenter

PS.  If you liked this script, try out my kmalloc script.  I don't think anyone besides me has successfully installed it yet, so if you have any questions I'd be glad to help.  :P  My phone number until tomorrow evening is (510) 835-7695.

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8

