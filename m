Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbSJ2Pfr>; Tue, 29 Oct 2002 10:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSJ2Pfr>; Tue, 29 Oct 2002 10:35:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37585 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261850AbSJ2Pfp>;
	Tue, 29 Oct 2002 10:35:45 -0500
Message-ID: <3DBEA982.8010309@watson.ibm.com>
Date: Tue, 29 Oct 2002 10:30:10 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: Hanna Linder <hannal@us.ibm.com>, torvalds@transmeta.com,
       Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, ahu@ds9a.nl
Subject: Re: [Lse-tech] Re: [PATCH] Updated sys_epoll now with man pages
References: <Pine.LNX.4.44.0210281844040.966-100000@blue1.dev.mcafeelabs.com> <144220000.1035864069@w-hlinder> <3DBE1824.B3D84E9F@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Hanna Linder wrote:
> 
>>   sys_epoll-2.5.44-last.diff
> 
> 
> Folks,
> 
> when I took a 15-minute look at this code last week I found several
> bugs, some of which were grave.  It's a terrible thing to say, but
> a sensible person would expect that a closer inspection would turn
> up more problems.
> 
> Now, adding bugs to existing code is fine and traditional - people
> find them quickly and they get fixed up.
> 
> But for *new* code, problems will take months to discover.  The only
> practical way to get this code vetted for inclusion is a close review.
> 
> And that is a sizeable task.  The core implementation file is
> 1,600 lines.  And I wonder how many people have counted the
> number of comments in there?
> 
> Well, I'll make it easy: zero.  Nil.  Nada.
> 
> (Well, OK, a copyright header, and something which got cut-n-pasted
> from inode.c)
> 
> In my wildly unconventional opinion this alone makes epoll just a hack,
> of insufficient quality for inclusion in Linux.  We *have* to stop doing
> this to ourselves!
> 
> 
> epoll seems to be a good and desirable thing.  To move forward I
> believe we need to get this code reviewed, and documented.
> 
> I can do that if you like; it will take me several weeks to get onto
> it.  But until that is completed I would oppose inclusion of this
> code.


Andrew,

It would be very helpful if you could point out what were the bugs you found
objectionable enough to withold your approval for the patch's inclusion.

It appears that the lack of comments in the code is one major concern. That alone
being a reason to dismiss the sys_epoll patch seems unreasonable. Consider
- there are another 3-4 months before the stable kernel will be out. In the
interim, Davide with assistance from some of us IBMers can put in the desired
level of comments in the code. Our committment to having a fully understood patch
should be evident from the release of man pages and a detailed web page listing
performance results alongwith the patch itself.
- this patch is the ONLY available scalable alternative to poll() and does far
better. To make an example out of this patch for not conforming to commenting
standards is a little extreme.

That being said, if there are bugs (small or large) that make the patch
questionable, I would understand why it can't be included. But we do need to
know what the bugs are. Davide had been very responsive to your last set of
comments and included all of them in his patch.

Please do find the time to list out atleast some of the bugs that you found.

Thanks,
-- Shailabh

