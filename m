Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSE1DYk>; Mon, 27 May 2002 23:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSE1DYj>; Mon, 27 May 2002 23:24:39 -0400
Received: from relay1.pair.com ([209.68.1.20]:5389 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S312254AbSE1DYj>;
	Mon, 27 May 2002 23:24:39 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CF2F897.EF17FB0E@kegel.com>
Date: Mon, 27 May 2002 20:25:11 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        pwaechtler@loewe-komp.de, austin@digitalroadkill.net
Subject: Re: RT Sigio broken on 2.4.19-pre8
In-Reply-To: <3CF2D86C.8745D791@kegel.com> <3CF2DCDE.CCBB499F@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman wrote:
> > > > > > Using the Dan Kegel's Poller_bench utility I noticed that RT SIGIO is not
> > > > > > working on 2.4.19-pre8.  Basically sigtimedwait() is always returning
> > > > > > SIGIO.  Note that 2.4.18 works fine.
> > > > > > ... It seems rtsig-nr keeping rising slowly as the system runs.
> > >
> > > That sounds like the way I'm clearing the signal queue is not working.
> > > Here's a minimal test case for clearing the signal queue.  Could
> > > you try it and tell me what it says?
>
> Just tried the corrected version, still passed.

I can't reproduce the problem here.  

What version of dkftpbench are you using?  What parameters?
Can you send me your kernel .config file?

I did notice and fix an embarassing problem in Poller_bench of 
dkftpbench-0.42; it aborted when Poller_sigio sent its initial readiness
notification (it's spurious, but programs are supposed to
be able to handle that).  Fix is at 
http://www.kegel.com/dkftpbench/pb.patch

Thanks,
Dan
