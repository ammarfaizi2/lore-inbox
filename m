Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbSJHQvN>; Tue, 8 Oct 2002 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSJHQvN>; Tue, 8 Oct 2002 12:51:13 -0400
Received: from packet.digeo.com ([12.110.80.53]:63199 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261348AbSJHQvL>;
	Tue, 8 Oct 2002 12:51:11 -0400
Message-ID: <3DA30E4D.CADFFB4D@digeo.com>
Date: Tue, 08 Oct 2002 09:56:45 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.40-mm2
References: <Pine.LNX.4.44.0210081303090.29540-100000@localhost.localdomain> <3DA30B28.8070504@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 16:56:45.0810 (UTC) FILETIME=[AF5A5D20:01C26EEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Ingo Molnar wrote:
> > On Sun, 6 Oct 2002, Dave Hansen wrote:
> >
> >>cc'ing Ingo, because I think this might be related to the timer bh
> >>removal.
> >
> > could you try the attached patch against 2.5.41, does it help? It fixes
> > the bugs found so far plus makes del_timer_sync() a bit more robust by
> > re-checking timer pending-ness before exiting. There is one type of code
> > that might have relied on this kind of behavior of the old timer code.
> 
> Hehe.  That'll teach me to be optimistic.  This is unprocessed, but
> the EIP in tvec_bases should tell the whole story.  Something _nasty_
> is going on.
> 
> addr2line on the run_timer_tasklet call: kernel/timer.c:359
> This is with the patch that Ingo sent me about 6 hours ago.  Andrew,
> should I still test the one that you sent me this morning?

No; I think Ingo covered everything there, and more.


> Dave Hansen
> haveblue@us.ibm.com
