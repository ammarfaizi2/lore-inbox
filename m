Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbSIWB7o>; Sun, 22 Sep 2002 21:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSIWB7n>; Sun, 22 Sep 2002 21:59:43 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:48769 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S264717AbSIWB7n>; Sun, 22 Sep 2002 21:59:43 -0400
Date: Sun, 22 Sep 2002 19:04:51 -0700
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: first NPT vs. NGPT vs. LinuxThreads benchmark results
Message-ID: <20020923020451.GA3446@gnuppy.monkey.org>
References: <3D8DB040.7060402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8DB040.7060402@redhat.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 04:57:52AM -0700, Ulrich Drepper wrote:
> The results of this test series are:
> 
> - - LinuxThreads indeed had several problems
> 
> - - NGPT indeed run much faster (twice the performance)
> 
> - - NPTL runs four times faster than NGPT in a benchmark which by all
>   means should favor an M-on-N implementation.

Which could mean that they, NGPT, have slower thread allocation algorithms
for many reason. Some M:N systems will red zone protect a page of the thread
stack adding overhead to creation and deletion (FreeBSD'c -current does
this), the memory allocation algorithms might not be able to take advantage
of short term stack recycling and other things. It's not clear that these
benchmarks are meaningful without outlining the conditions that surround it.

Not to take the show away from you folks, but it's definitely something
that I immediately though about once I saw the graphs.

> We will soon have more benchmarks showing the thread libraries in
> other real-world situations, such as IO-intensive workloads.

bill

