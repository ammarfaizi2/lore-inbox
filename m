Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278247AbRJMCkn>; Fri, 12 Oct 2001 22:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278248AbRJMCkZ>; Fri, 12 Oct 2001 22:40:25 -0400
Received: from [208.129.208.52] ([208.129.208.52]:36113 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278247AbRJMCkH>;
	Fri, 12 Oct 2001 22:40:07 -0400
Date: Fri, 12 Oct 2001 19:46:14 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Paul Mackerras <paulus@samba.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <Pine.LNX.4.40.0110121921240.1505-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.40.0110121945180.1505-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Davide Libenzi wrote:

> On Fri, 12 Oct 2001, Linus Torvalds wrote:
>
> >
> > On Fri, 12 Oct 2001, Davide Libenzi wrote:
> > >
> > > The problem is that even if cpu1 schedule the load of  p  before the
> > > load of  *p  and cpu2 does  a = 1; wmb(); p = &a; , it could happen that
> > > even if from cpu2 the invalidation stream exit in order, cpu1 could see
> > > the value of  p  before the value of  *p  due a reordering done by the
> > > cache controller delivering the stream to cpu1.
> >
> > Umm - if that happens, your cache controller isn't honouring the wmb(),
> > and you have problems quite regardless of any load ordering on _any_ CPU.
> >
> > Ehh?
>
> I'm searching the hp-parisc doc about it but it seems that even Paul
> McKenney pointed out this.

ops, alpha



- Davide


