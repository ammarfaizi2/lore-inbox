Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269701AbUJAFdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269701AbUJAFdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbUJAFdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:33:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:38093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269701AbUJAFdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:33:53 -0400
Date: Thu, 30 Sep 2004 22:29:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: juhl-lkml@dif.dk, clameter@sgi.com, drepper@redhat.com,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: patches inline in mail
Message-Id: <20040930222928.1d38389f.akpm@osdl.org>
In-Reply-To: <415B4FEE.2000209@mvista.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
	<4154F349.1090408@redhat.com>
	<Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
	<41550B77.1070604@redhat.com>
	<B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
	<4159B920.3040802@redhat.com>
	<Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
	<415AF4C3.1040808@mvista.com>
	<Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
	<415B0C9E.5060000@mvista.com>
	<Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
	<415B4FEE.2000209@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> We agree.  Still, I have been bitten too many times by misshandled white space 
>  to trust pure inlineing.  Likewise on picking it up one would usually past it in 
>  the mail (I suppose) where as the attachment is through the mailer and less 
>  prone to missing a character.
> 
>  The best answer, I think, is attachments that show as inline AND stay that way 
>  on the reply.
> 
>  Guild lines on how to insure this are welcome.

Send angry email to everyone@mozilla.org.  AFAICT it's impossible with
recent mailnews.

Slightly more on-topic:

+int do_posix_clock_process_gettime(struct timespec *tp);
+int do_posix_clock_process_settime(struct timespec *tp);
+int do_posix_clock_thread_gettime(struct timespec *tp);
+int do_posix_clock_thread_settime(struct timespec *tp);

These should all be given static scope.

And it would be nice to structure the code so the forward decl isn't
needed, if poss.

