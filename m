Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSJVSFu>; Tue, 22 Oct 2002 14:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264845AbSJVSDj>; Tue, 22 Oct 2002 14:03:39 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:58520 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262006AbSJVSDY>; Tue, 22 Oct 2002 14:03:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Oct 2002 11:18:20 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Mielke <mark@mark.mielke.cc>,
       "Charles 'Buck' Krasic" <krasic@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <1035310415.31873.120.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210221113390.1563-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Oct 2002, Alan Cox wrote:

> On Tue, 2002-10-22 at 18:47, Davide Libenzi wrote:
> > Since the sys_epoll ( and /dev/epoll ) fd support standard polling, you
> > can mix sys_epoll handling with other methods like poll() and the AIO's
> > POLL function when it'll be ready. For example, for devices that sys_epoll
> > intentionally does not support, you can use a method like :
>
> The more important question is why do you need epoll. asynchronous I/O
> completions setting a list of futexes can already be made to do the job
> and is much more flexible.

Alan, could you provide a code snipped to show how easy it is and how well
it fits a 1:N ( one task/thread , N connections ) architecture ? And
looking at Ben's presentation about benchmarks ( and for pipe's ), you'll
discover that both poll() and AIO are "a little bit slower" than
sys_epoll. Anyway I do not want anything superflous added to the kernel
w/out reason, that's why, beside the Ben's presentation, there're curretly
people benchmarking existing solutions.




- Davide


