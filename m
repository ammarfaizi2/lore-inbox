Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288272AbSACRdc>; Thu, 3 Jan 2002 12:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288273AbSACRdW>; Thu, 3 Jan 2002 12:33:22 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:65288 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288272AbSACRdN>; Thu, 3 Jan 2002 12:33:13 -0500
Date: Thu, 3 Jan 2002 09:36:56 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Peter Osterlund <petero2@telia.com>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scheduler fixups ...
In-Reply-To: <Pine.LNX.4.33L.0201031053460.24031-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.40.0201030930010.1489-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Rik van Riel wrote:

> On Wed, 2 Jan 2002, Davide Libenzi wrote:
> > On 2 Jan 2002, Peter Osterlund wrote:
> > > Davide Libenzi <davidel@xmailserver.org> writes:
> > >
> > > > a still lower ts
> > >
> > > This also lowers the effectiveness of nice values. In 2.5.2-pre6, if I
> > > run two cpu hogs at nice values 0 and 19 respectively, the niced task
> > > will get approximately 20% cpu time (on x86 with HZ=100) and this
> > > patch will give even more cpu time to the niced task. Isn't 20% too
> > > much?
> >
> > The problem is that with HZ == 100 you don't have enough granularity
> > to correctly scale down nice time slices. Shorter time slices helps
> > the interactive feel that's why i'm pushing for this.
>
> So don't give the niced task a new timeslice each time,
> but only once in a while.

Rik, this is part of the new architecture where tasks can spend the
virtual time they accumulated ( if any, dyn_prio > 0 ) one extra slice at
a time. This help in separating the time slice from the dynamic priority.




- Davide


