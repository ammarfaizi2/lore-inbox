Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSFYLxI>; Tue, 25 Jun 2002 07:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFYLxH>; Tue, 25 Jun 2002 07:53:07 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:13530 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315388AbSFYLxG>; Tue, 25 Jun 2002 07:53:06 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: root@chaos.analogic.com
Subject: Re: gettimeofday problem
Date: Tue, 25 Jun 2002 21:50:10 +1000
User-Agent: KMail/1.4.5
Cc: Christian Robert <xtian-test@sympatico.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020625074319.18426B-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020625074319.18426B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206252150.10271.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002 21:45, Richard B. Johnson wrote:
> On Tue, 25 Jun 2002, Brad Hards wrote:
> > On Tue, 25 Jun 2002 10:37, Christian Robert wrote:
> > >   gettimeofday (&tv, NULL);
> >
> > How about checking the return value of the function call?
> >
> > Brad
> > --
> > http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
>
> I think the only possible error returned would relate to the time-zone
> being invalid. The time-zone pointer being a NULL is valid so it isn't
> going to return EINVAL.
It was just a thought - it just seemed a reasonable thing to test for, since 
the call can fail. 

I didn't check the lib code, so I imagined that their might be some glibc 
munging of the syscall output. man gettimeofday sez, inter alia:
       EINVAL Timezone (or something else) is invalid.

       EFAULT One of tv or tz  pointed  outside  your  accessible
              address space.

As you pointed out, EINVAL doesn't seem too likely, and I can't see a pointer 
problem. So it looks like something else.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
