Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316583AbSFDSor>; Tue, 4 Jun 2002 14:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316488AbSFDSoq>; Tue, 4 Jun 2002 14:44:46 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:28683 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S316538AbSFDSoM>; Tue, 4 Jun 2002 14:44:12 -0400
Date: Tue, 4 Jun 2002 19:44:07 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Nick Popoff <lkml@tre.bloodletting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question regarding do_munmap
Message-ID: <20020604184407.GA63233@compsoc.man.ac.uk>
In-Reply-To: <153.25.1023215073895@tre.bloodletting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 11:24:33AM -0700, Nick Popoff wrote:

> (Generic 2.4.18 include/linux/mm.h) 
> extern int do_munmap(struct mm_struct *, unsigned long, size_t); 
>  
> (RH 7.3/AC patched 2.4.18-3 include/linux/mm.h) 
> extern int do_munmap(struct mm_struct *, unsigned long, size_t, int 
> acct); 
>  
> My question is what is the recommended way for module developers to 
> handle changes to this API so that end users don't have to edit 
> makefiles to build for their particular kernel?  Is there a way to 

Add some tests in a ./configure script that finds out which one
is being used in the kernel headers.

> how to handle this besides grep'ing source in my installer? :-) 

It's roughly similar to this though. API creep is one of the facts of
external module development on Linux, I'm afraid.

regards
john

-- 
"Do you mean to tell me that "The Prince" is not the set textbook for CS1072
Professional Issues ? What on earth do you learn in that course ?"
	- David Lester
