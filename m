Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWH1KfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWH1KfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWH1KfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:35:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:21113 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964786AbWH1KfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:35:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lowpEPc8lTgl6Hn+vYB/9oJON4Jyycz5Ib8n4OxUxEJP3LLfP+mz/6p64TxBW70mdCho2JSLcNj3IHah4JjdLYFDbg0hpPekqeIKPFhlaL7OXP8RA85A8ahLOkGkk1qqm4gWa7+QH2UeIxD7Tcaigm3aQ+Et0TceGAzK93dw/PQ=
Message-ID: <9a8748490608280335w4474b489u45b3b0b05b7f2f44@mail.gmail.com>
Date: Mon, 28 Aug 2006 12:35:00 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Kasper Sandberg" <lkml@metanurb.dk>
Subject: Re: Linux v2.6.18-rc5
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Nathan Scott" <nathans@sgi.com>
In-Reply-To: <1156760869.24904.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <9a8748490608280310q65c1335cr2603b044c340a489@mail.gmail.com>
	 <1156760869.24904.1.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/06, Kasper Sandberg <lkml@metanurb.dk> wrote:
> On Mon, 2006-08-28 at 12:10 +0200, Jesper Juhl wrote:
> > On 28/08/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > >
> > > Ok,
> > >  this was delayed three weeks due to a combination of vacations and a
> > > funeral in Finland, but Greg and Andrew kept on top of things, and we were
> > > fairly late in the release cycle anyway, so it hopefully caused no real
> > > problems apart from obviously delaying the final release a tiny bit.
> > >
> > > Linux 2.6.18-rc5 is out there now, both in git form and as patches and
> > > tar-balls (the latter which I forgot for -rc4, but Greg covered for me -
> > > blush).
> > >
> > > The shortlog (appended) tells the story: various fixes all around.
> > > Powerpc, V4L, networking, SCSI..
> > >
> > > Pls test it out, and please remind all the appropriate people about any
> > > regressions you find (including any found earlier if they haven't been
> > > addressed yet).
> > >
> > Not really a regression, more like a long standing bug, but XFS has
> > issues in 2.6.18-rc* (and earlier kernels, at least post 2.6.11).
> and you are saying this issue exists in all post .11 kernels?

No, I don't know that for sure. All I know is that 2.6.17.x (with x >=
7) falls over, 2.6.18-rc[34] falls over and there's nothing in
2.6.18-rc5 that looks like a fix but I've not tested that kernel yet
(but I have tested 2.6.18-rc4 + the xfs fix that went into -rc5 and
that one doesn't solve it).
2.6.11 is simply the kernel the server I can reproduce this on was
running previously, and that kernel is stable. It's a production
machine and it takes hours to hit the problem, so I can't very well do
a binary search of all kernels between 2.6.11 and 2.6.18-rc.


> > With heavy rsync load to a machine with XFS filesystems, XFS falls
> > over and filesystems are in need of xfs_repair.
> > I'm doing all I can to gather info for Nathan so he can fix the bug,
> > but it's hard to trigger reliably.
> could you please describe whatever you have found out, im eager to take
> a look at it myself

Take a look at the thread I mention, that should describe the problem
and what we have found out so far.
Here's a link to the start of the thread: http://lkml.org/lkml/2006/8/4/97


> > My point is that perhaps it's worth delaying 2.6.18 a little longer in
> > the hope of getting that bug fixed before release. Nathan?
> > At least for me, XFS in its current state (and thus 2.6.18)  is
> > unusable in production environments.
> >
> > See the thread titled "2.6.18-rc3-git3 - XFS - BUG: unable to handle
> > kernel NULL pointer dereference at virtual address 00000078" for the
> > full story.
> >
>

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
