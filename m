Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSEVCBI>; Tue, 21 May 2002 22:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316827AbSEVCBH>; Tue, 21 May 2002 22:01:07 -0400
Received: from web14203.mail.yahoo.com ([216.136.172.145]:18861 "HELO
	web14203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316826AbSEVCBG>; Tue, 21 May 2002 22:01:06 -0400
Message-ID: <20020522020106.96508.qmail@web14203.mail.yahoo.com>
Date: Tue, 21 May 2002 19:01:06 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Re: Kernel BUG 2.4.19-pre8-ac1 + preempt
To: linux-kernel@vger.kernel.org
In-Reply-To: <1022027112.967.86.camel@sinai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And now for another data point.  Upon atempting to reboot after this, the raid5
array (software) was unable to be stopped.  Got as far as the lines....

Rebooting.
Stoping array md0

or something like that, and then hung....otherwise everything else worked fine
up between the bug and then.  Trying to reproduce without premept at the
moment.


--- Robert Love <rml@tech9.net> wrote:
> On Tue, 2002-05-21 at 12:43, Erik McKee wrote:
> > Hello
> > 
> > This output...
> > <snip>
> 
> I don't think this has anything to do with preempt.  The current task
> was not preemptible (hence the error notice on exit - is that why you
> blame preempt?).  There is also no preempt_schedule call in your back
> trace.
> 
> Looks to me like you died coming off an IDE interrupt and a resulting
> read - you ran out of free pages and bit the dust there.  Dunno why,
> though.  I don't have an mm_inline.h:78 in my tree, but I do have a
> DEBUG_LRU near it ...
> 
> 	Robert Love
> 


__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
