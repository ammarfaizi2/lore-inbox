Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbSJOSsl>; Tue, 15 Oct 2002 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSJOSsl>; Tue, 15 Oct 2002 14:48:41 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62862 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264754AbSJOSsk>; Tue, 15 Oct 2002 14:48:40 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 12:02:41 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DAC5C11.4060507@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0210151201300.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Shailabh Nagar wrote:

> Davide Libenzi wrote:
> > On Tue, 15 Oct 2002, Benjamin LaHaise wrote:
> >
> >
> >>On Tue, Oct 15, 2002 at 01:38:53PM -0400, Shailabh Nagar wrote:
> >>
> >>>So I guess the question would now be: whats keeping /dev/epoll from
> >>>being included in the kernel given the time left before the feature freeze ?
> >>
> >>We don't need yet another event reporting mechanism as /dev/epoll presents.
> >>I was thinking it should just be its own syscall but report its events in
> >>the same way as aio.
> >
> >
> > Yes, Linus ( like myself ) hates magic inodes inside /dev. At that time it
> > was the fastest way to have a kernel interface exposed w/out having to beg
> > for a syscall. I'm all for a new syscall obviously, and IMHO /dev/epoll
> > might be a nice complement to AIO for specific applications.
>
>
> So what would the syscall look like ? Could you give a few more details on the interface ?

Since i guess that w/out having the bility to add fds to the monitores set
would make the API useless ...

int sys_epoll_addfd(int epd, int fd);




- Davide


