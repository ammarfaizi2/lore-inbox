Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSFNWBO>; Fri, 14 Jun 2002 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSFNWBN>; Fri, 14 Jun 2002 18:01:13 -0400
Received: from mx1.afara.com ([63.113.218.20]:51525 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S314500AbSFNWBN>;
	Fri, 14 Jun 2002 18:01:13 -0400
User-Agent: Pan/0.11.3 (Unix)
From: "Thomas Duffy" <Thomas.Duffy.99@alumni.brown.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
Date: Fri, 14 Jun 2002 15:00:03 -0700
In-Reply-To: <1023996118.4800.75.camel@sinai> <20020613.212528.08026527.davem@redhat.com>
Reply-To: linux-kernel@vger.kernel.org
Message-ID: <AFARA-EXi6YEFmsQSkt00002356@afara-ex.afara.com>
X-OriginalArrivalTime: 14 Jun 2002 22:01:08.0635 (UTC) FILETIME=[FCED4EB0:01C213EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin  David S. Miller quotation on Thu, 13 Jun 2002 21:32:11 -0700:

>    From: Robert Love <rml@mvista.com>
>    Date: 13 Jun 2002 12:21:58 -0700
>    
>    Patch is against 2.4.19-pre10-ac2, please apply.
>    
> Ummm what is with all of those switch_mm() hacks?  Is this an attempt to
> work around the locking problems?  Please don't do that as it is going
> to kill performance and having ifdef sparc64 sched.c changes is ugly to
> say the least.
> 
> Ingo posted the correct fix to the locking problem with the patch he
> posted the other day, that is what should go into the -ac patches.

This part of the patch (the change to kernel/sched.c) can be safely	
removed without making o1 stop working.

This hack (conservatively) fixes an issue where on bootup, the machine
would get into a page fault loop and hang.  This only happens a very
small percentage of the time.  I will investigate whether the patch
Ingo put out fixes this issue.

-tduffy

-- 
He who receives an idea from me, receives instruction himself without
lessening mine; as he who lights his taper at mine, receives light
without darkening me.                      -- Thomas Jefferson
