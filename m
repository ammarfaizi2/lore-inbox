Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274405AbRJEXK4>; Fri, 5 Oct 2001 19:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274424AbRJEXKr>; Fri, 5 Oct 2001 19:10:47 -0400
Received: from [208.129.208.52] ([208.129.208.52]:7684 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274405AbRJEXKg>;
	Fri, 5 Oct 2001 19:10:36 -0400
Date: Fri, 5 Oct 2001 16:16:00 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Davide Libenzi <davidel@xmailserver.org>,
        george anzinger <george@mvista.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <E15pe0t-0007wz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0110051611310.1523-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Alan Cox wrote:

> > > This damps down task thrashing a bit, and for the cpu hogs it gets the
> > > desired behaviour - which is that the all run their full quantum in the
> > > background one after another instead of thrashing back and forth
> >
> > What if we give to  prev  a priority boost P=F(T) where T is the time
> > prev  is ran before the current schedule ?
>
> That would be the wrong key. You can argue certainly that it is maybe
> appropriate to use some function based on remaining scheduler ticks, but
> that already occurs as the scheduler ticks is the upper bound for priority
> band

No, i mean T = (Tstart - Tend) where :

Tstart = time the current ( prev ) task has been scheduled
Tend   = current time ( in schedule() )

Basically it's the total time the current ( prev ) task has had the CPU



- Davide


