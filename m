Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbRE0HNt>; Sun, 27 May 2001 03:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbRE0HNk>; Sun, 27 May 2001 03:13:40 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:20599 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S262779AbRE0HN2>; Sun, 27 May 2001 03:13:28 -0400
Message-ID: <001101c0e67c$844017e0$50a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Mike Galbraith" <mikeg@wen-online.de>
Cc: "Alan Cox" <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>,
        "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <Pine.LNX.4.33.0105270656480.603-100000@mikeg.weiden.de>
Subject: Re: Linux 2.4.4-ac17
Date: Sun, 27 May 2001 00:13:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mike,

"Mike Galbraith" <mikeg@wen-online.de> wrote :

>
> Exactly.  Nothing but ram and it's mostly unfreeable.  That makes
> life pretty tough for the vm.
>

This is not a good concept at all , why linux is wasting precious RAM
unnecassarily, if not required .

Then what will happen for Embedded system (like in my case), which do not
have any Hard disk , only things they have Flash or Ram.

> Does it hang if you are doing other things than creating/destroying
> tiny files (with unique names) as rapidly as possible?.. ie did you
> start doing that to troubleshoot because it was hanging over a long
> period of time?
>

If i create and delete files with same name , inode_cache & dentry_cache
increases only one time , there is no problem .
If i create and delete files with different name , inode_cache &
dentry_cache increases continously and will eat my whole RAM and crash
system.

And if i create and delete my file after long lapse , inode_cache &
dentry_cache are restore after some time , their is no problem .
But if i create and delete files very frequently , inode_cache &
dentry_cache get no time for restore and eat my whole RAM and crash system.

If i donot create and delete files files frequently with different name ,
their is no problem at all.

> You snipped my suggestion.. did you try it?  If not, please do.  In
> fact, go a bit further.  Make unconditional calls to kmem_cache_reap()
> and shrink_icache_memory() as well.. prior to calling page_launder().
> It's a long shot, but it might help.  If it does help, that will
> tell developers what they need to know.  It costs you five minutes.
>
> Another option is to build 2.4.5-pre6 and add the patch Rik posted.
> If my thinker is working right, that _will_ help (if not cure).
>
> Another option which virtually guarantees successful identification
> of the problem (but costs more than five minutes) is for you to grab
> a copy of IKD from your favorite kernel mirror and give memleak a try
> locally.  It can be found in /pub/linux/kernel/people/andrea/ikd. If
> you choose this option and have any trouble, drop me a note offline.
>

Thank you very much for your suggestions , i was getting this problem in my
ARM target machine and right now i am working on SH target machines , and i
am quite busy with my SH target machines now , i have to do lot of setups to
change my target machines , i am sorry right now i am not in position to
test your suggestions , but as soon as my SH target machine work is over , i
will test all your suggestions and options.

BTW, i am getting Ramdisk intialization problem in SH target machine.

Thank you,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.




