Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317369AbSGIST3>; Tue, 9 Jul 2002 14:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSGIST2>; Tue, 9 Jul 2002 14:19:28 -0400
Received: from 205-158-62-93.outblaze.com ([205.158.62.93]:30864 "HELO
	ws3-3.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317369AbSGIST1>; Tue, 9 Jul 2002 14:19:27 -0400
Message-ID: <20020709182205.27952.qmail@email.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: haveblue@us.ibm.com
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Tue, 09 Jul 2002 13:22:05 -0500
Subject: Re: lock_kernel check...
X-Originating-Ip: 166.90.33.109
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 09 Jul 2002 10:41:01 -0700 
To: dan carpenter <error27@email.com>
Subject: Re: lock_kernel check...

> dan carpenter wrote:
>  > Smatch.pm is from the smatch.sf.net scripts page.  Smatch is a
>  > really unfinished code checker that I've been working on.  It is
>  > based on reading the papers about the Stanford checker.
> 
> There was a time when I was thinking about the same thing.  It kept 
> scaring me the more I thought about it.
> 

True.  But someone is going to write a checker at some point.  It's only a couple days work if you know what you are doing.  There doesn't seem to be much advantage in waiting a year or two.

>  > Unfortunately, after a night of sleep I realize that my script is
>  > broken for 2 reasons. 1)  Smatch.pm is meant to track state changes
>  > down different code paths.  But unfortunately it wasn't doing that
>  > in this case; it was just going down the code without taking into
>  > consideration any if_stmts  etc.  I'm extremely embarassed about
>  > that.  Sorry.
> 
> Don't be sorry.  The script is smarter than the people who caused the 
> errors.  (once again, probably me)
> 
>  > 2)  What the Stanford checker does is print an error
>  > if one return_stmt is called while the kernel is locked and one is
>  > called while the kernel is unlocked.  This seems reasonable.
> 
> Could you clarify that a bit?
> 

If someone made a mistake where they always returned under a kernel_lock() they would find the mistake themselves.  

Why would they return under kernel_lock() on error, for example, but not on success?  That would be confusing.  There would still be some false positives but the number of cases is really small.

regards,
dan carpenter


-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8

