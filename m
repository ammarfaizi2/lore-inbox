Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268857AbRHFQgI>; Mon, 6 Aug 2001 12:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbRHFQf7>; Mon, 6 Aug 2001 12:35:59 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:40459 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S268857AbRHFQfq>; Mon, 6 Aug 2001 12:35:46 -0400
Message-ID: <02a101c11e96$45db1d40$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: "Stephen Satchell" <satch@fluent-access.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <007801c11c67$87d55980$b6562341@cfl.rr.com> <4.3.2.7.2.20010803225855.00bc2a60@mail.fluent-access.com>
Subject: Re: Ongoing 2.4 VM suckage
Date: Mon, 6 Aug 2001 11:37:53 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Stephen Satchell" <satch@fluent-access.com>
> At 07:08 PM 8/3/01 -0300, you wrote:
> >On Fri, 3 Aug 2001, Mike Black wrote:
> >
> > > Couldn't kswapd just gracefully back-off when it doesn't make any
> > > progress? In my case (with ext3/raid5 and a tiobench test) kswapd
> > > NEVER actually swaps anything out. It just chews CPU time.
> >
> > > So...if kswapd just said "didn't make any progress...*2 last sleep" so
> > > it would degrade itself.
> >
> >It wouldn't just degrade itself.
> >
> >It would also prevent other programs in the system
> >from allocating memory, effectively halting anybody
> >wanting to allocate memory.
Big snip...

> To the rest of the kernel list:  apologies for taking up so much space
with
> a userland issue.  The thing is, in the months I've seen the VM problem
> discussed, and the "zillionth person to complain about it," I haven't seen
> any pointer to any discussion about how userland programs can insulate
> themselves from being killed when they try to use up too much
> RAM.  Commercial quality programs, and programs wanting to use as much of
> the resources as possible to minimize run times, need to monitor what they
> are doing to the system and pull back when they tread toward suicide.
>
> Put another way, people should NOT use safety nets as the only means of
> breaking a fall.
    AIX, also allows something similar to linux's over commit. Right before
its OOM killer fires it sends the target process(es) a non standard signal
(can't remember what its called) which indicates that if the process
continues to allocate memory it runs the risk of being killed.

I'm not advocating this idea, only presenting it as a solution other people
have implemented to work around broken VM issues.



    jlinton


