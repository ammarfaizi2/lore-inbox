Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLHD57>; Thu, 7 Dec 2000 22:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQLHD5t>; Thu, 7 Dec 2000 22:57:49 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:54159 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S129429AbQLHD5e>; Thu, 7 Dec 2000 22:57:34 -0500
Date: Fri, 8 Dec 2000 03:25:33 +0000 (GMT)
From: davej@suse.de
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Rainer Mager <rmager@vgkk.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <3A3051C0.F3F909C1@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0012080321180.13163-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Jeff V. Merkey wrote:

> I think there may be a case when a process forks, that the MMU or some
> other subsystem is either not setting the page bits correctly, or
> mapping in a bad page.  It's a LEVEL I bug in 2.4 is this is the case,
> BTW.  In core dumps (I've looked at 2 of them from SSH) it barfs right
> after executing fork() or one of the exec functions and at some places
> in the code where there's not any obvious coding bugs.  Looks like some
> type of mapping problem.  I reported it three months ago, but it was
> pretty much ignored.
> 
> Linus needs to add this one to the pre-12 list -- looks like some type
> of mapping bug.

Now that you mention it, every app that has bombed has been the type
that forks a lot. MpegTV, gtv, and make spring to mind. All apps drive
the CPU load up quite a lot, which was why I initially suspected
overheating. I don't see it on my other 2.4 boxes though which is
suspicious. But they don't get as much of a beating as this, which was
up until last week my main workstation.

regards,

Dave.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
