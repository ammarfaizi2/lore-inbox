Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbRCITnX>; Fri, 9 Mar 2001 14:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130650AbRCITnN>; Fri, 9 Mar 2001 14:43:13 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:55013 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S130512AbRCITm4>; Fri, 9 Mar 2001 14:42:56 -0500
Message-ID: <3AA93124.EC22CC8A@mvista.com>
Date: Fri, 09 Mar 2001 11:38:12 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 8 Mar 2001, Boris Dragovic wrote:
> 
> > > Of course. Now we just need the code to determine when a task
> > > is holding some kernel-side lock  ;)
> >
> > couldn't it just be indicated on actual locking the resource?
> 
> It could, but I doubt we would want this overhead on the locking...
> 
> Rik

Seems like you are sneaking up on priority inherit mutexes.  The locking
over head is not so bad (same as spinlock, except in UP case, where it
is the same as the SMP case).  The unlock is, however, the same as the
lock overhead.  It is hard to beat the store of zero which is the
spin_unlock.

George
