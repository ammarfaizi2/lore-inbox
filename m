Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbUDOPKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbUDOPKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:10:12 -0400
Received: from web11410.mail.yahoo.com ([216.136.131.221]:48787 "HELO
	web11410.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264303AbUDOPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:10:01 -0400
Message-ID: <20040415150959.44584.qmail@web11410.mail.yahoo.com>
Date: Thu, 15 Apr 2004 16:09:59 +0100 (BST)
From: =?iso-8859-1?q?alan=20pearson?= <alandpearson@yahoo.com>
Subject: Re: sched_getaffinity & sched_setaffinity returning -1 (errstr = Bad address)
To: Simon Derr <simon.derr@bull.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0404151358160.7864@daphne.frec.bull.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon,

Exactly the problem. Same linux distro, but with
upgraded glibc. I also hadn't upgraded the header
files for my new glibc (doh!), and now problem solved
!

Thanks for that, makes me a *very* happy man. *Very*
happy......

AlanP


--- Simon Derr <simon.derr@bull.net> wrote: > 
> 
> On Thu, 15 Apr 2004, alan pearson wrote:
> 
> > Hi
> >
> > I've been trying to use the sched_getaffinity &
> > sched_setaffinity on
> > kernel 2.6.4 and it is working on some systems and
> not
> > others !
> > It works fine on my aged dual CPU pentium pro box,
> but
> > on the box I
> > really want it to work on, the calls return -1 !
> 
> My guess is that on your newer box you also have a
> newer Linux
> distribution with the new sched_setaffinity()
> prototype, e.g with only two
> parameters.
> 
> new libc sched.h:
> extern int sched_setaffinity (__pid_t __pid, __const
> cpu_set_t *__mask);
> 
> 	Simon.
>  


	
	
		
____________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
