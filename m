Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSJVTfB>; Tue, 22 Oct 2002 15:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbSJVTfA>; Tue, 22 Oct 2002 15:35:00 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:48027 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264859AbSJVTe4>; Tue, 22 Oct 2002 15:34:56 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Oct 2002 12:49:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <20021022143708.F20957@redhat.com>
Message-ID: <Pine.LNX.4.44.0210221245050.1563-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Benjamin LaHaise wrote:

> On Tue, Oct 22, 2002 at 11:18:20AM -0700, Davide Libenzi wrote:
> > Alan, could you provide a code snipped to show how easy it is and how well
> > it fits a 1:N ( one task/thread , N connections ) architecture ? And
> > looking at Ben's presentation about benchmarks ( and for pipe's ), you'll
> > discover that both poll() and AIO are "a little bit slower" than
> > sys_epoll. Anyway I do not want anything superflous added to the kernel
> > w/out reason, that's why, beside the Ben's presentation, there're curretly
> > people benchmarking existing solutions.
>
> That's why I was hoping async poll would get fixed to have the same
> performance characteristics as /dev/epoll.  But.... :-/

Yep, like I wrote you yesterday ( and you did not answer ) is that I was
trying to add supprt for AIO into the test HTTP server I use to do
benchmark tests ( http://www.xmailserver.org/linux-patches/ephttpd-0.1.tar.gz )
but since there's no support for AIO POLL, it is impossible ( at least to
my knowledge ) to compare sys_epoll and AIO on a "real HTTP load"
networking test.




- Davide


