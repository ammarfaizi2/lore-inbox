Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWHOS0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWHOS0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHOS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:26:47 -0400
Received: from 1wt.eu ([62.212.114.60]:20239 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1030442AbWHOS0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:26:46 -0400
Date: Tue, 15 Aug 2006 20:22:19 +0200
From: Willy Tarreau <w@1wt.eu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Maximum number of processes in Linux
Message-ID: <20060815182219.GL8776@1wt.eu>
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com> <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:22:02PM -0400, linux-os (Dick Johnson) wrote:
> 
> On Tue, 15 Aug 2006, Irfan Habib wrote:
> 
> > Hi,
> >
> > What is the maximum number of process which can run simultaneously in
> > linux? I need to create an application which requires 40,000 threads.
> > I was testing with far fewer numbers than that, I was getting
> > exceptions in pthread_create
> >
> > Regards
> > Irfan
> 
> #include <stdio.h>
> int main(){
>      unsigned long i;
       ^^^^^^^^^^^^^^^^

>      while(fork() != -1)
>          i++;
>      printf("%u\n", i);
>      return 0;
> }
> $ gcc -o xxx xxx.c
> $ ./xxx
> 
> 1251392833         <<---- At least this number

Dick, would you please initialize your local variables when you send
examples like this ? You should have been amazed by one billion processes
on your box, at least.

> 1251392834
> 1251392834
> 1251392834
> 1251392834
> 1251392833
> 1251392833
> 1251392834
> 1251392834
> 1251392834
> ^C
> $ killall xxx
> 
> BYW 40,000 threads? 40,000 tasks all sharing the same address space?
> Hopefully this is just a training exercise to see if it's possible.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
> New book: http://www.AbominableFirebug.com/

Regards,
Willy
