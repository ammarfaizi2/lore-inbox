Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSEQMT5>; Fri, 17 May 2002 08:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSEQMT4>; Fri, 17 May 2002 08:19:56 -0400
Received: from slip-202-135-75-243.ca.au.prserv.net ([202.135.75.243]:10121
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315178AbSEQMT4>; Fri, 17 May 2002 08:19:56 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@redhat.com (David S. Miller), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Fri, 17 May 2002 13:17:25 +0100."
             <E178gfl-0006Ip-00@the-village.bc.nu> 
Date: Fri, 17 May 2002 22:21:45 +1000
Message-Id: <E178gkH-0001LV-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E178gfl-0006Ip-00@the-village.bc.nu> you write:
> > > I would much rather fix these instances than add yet another
> > > interface.
> > 
> > I'll accept that if someone's volunteering to audit the kernel for
> > them every six months.
> > 
> > Sorry I wasn't clear: I'm saying *replace*, not add,
> 
> Replace requires you audit every single use, and then work out how to
> handle those that do care about the length and the point it faulted.

Read my original post.  I have done this.

> From what I've seen of the stuff that has been fixed we have a mix
> of the following
> 
> 1.	Misports of ancient verify_* code - eg the serial ones
> 2.	Not checking the return code - 100% legal and standards compliant

No, the 400+ are all of form:

	/* of course this returns 0 or -EFAULT! */
	return copy_from_user(xxx);

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
