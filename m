Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSHLAP2>; Sun, 11 Aug 2002 20:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSHLAP2>; Sun, 11 Aug 2002 20:15:28 -0400
Received: from web40307.mail.yahoo.com ([66.218.78.86]:7465 "HELO
	web40307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318488AbSHLAPW>; Sun, 11 Aug 2002 20:15:22 -0400
Message-ID: <20020812001904.65066.qmail@web40307.mail.yahoo.com>
Date: Sun, 11 Aug 2002 17:19:04 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: Re: kernel BUG at page_alloc.c
To: tomlins@cam.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020812000523.15F1D88BC@oscar.casa.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, I am not using Nvidia.

Can you please let me know, who can cause this BUG ,
or their is any way to trace or work around for this
BUG :-

#define DEBUG_ADD_PAGE \
if (PageActive(page) || PageInactiveDirty(page) ||
\
 PageInactiveClean(page)) BUG();

Thanks.

--- Ed Tomlinson <tomlins@cam.org> wrote:
> Have you ever loaded any propriority modules on this
> kernel?
> Nvidia is the most common cause of this sort of bug.
>  I which
> case you need to talk to them - only they have the
> source.
> 
> Ed Tomlinson
> 
> Studying MTD wrote:
> 
> > Hello all,
> > 
> > I am getting kernel BUG when i deal with big files
> :-
> > 
> > kernel BUG at page_alloc.c:203!
> > 
> > I am using 2.4.1 on SH4 and using only 32 MB RAM
> > without hard-disk, so only thing i am using is 32
> MB
> > RAM .
> > 
> > 
> > /* page_alloc.c */
> > if (BAD_RANGE(zone,page))
> > BUG();
> > DEBUG_ADD_PAGE    <--- line no 203
> > 
> > 
> > /* linux/swap.h */
> > 
> > #define DEBUG_ADD_PAGE \
> > if (PageActive(page) || PageInactiveDirty(page) ||
> \
> > PageInactiveClean(page)) BUG();
> > 
> > 
> > Can someone please guide me and let me know the
> > work-around for this kernel BUG.
> > 
> > Thanks for your help.
> > 


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
