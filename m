Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274292AbRJEWv0>; Fri, 5 Oct 2001 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274287AbRJEWvQ>; Fri, 5 Oct 2001 18:51:16 -0400
Received: from [208.129.208.52] ([208.129.208.52]:5380 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274236AbRJEWvE>;
	Fri, 5 Oct 2001 18:51:04 -0400
Date: Fri, 5 Oct 2001 15:56:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: george anzinger <george@mvista.com>, Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <E15pdSv-0007qX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0110051553220.1523-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Alan Cox wrote:

> > Let me see if I have this right.  Task priority goes to max on any (?)
> > sleep regardless of how long.  And to min if it doesn't sleep for some
> > period of time.  Where does the time slice counter come into this, if at
> > all?
> >
> > For what its worth I am currently updating the MontaVista scheduler so,
> > I am open to ideas.
>
> The time slice counter is the limit on the amount of time you can execute,
> the priority determines who runs first.
>
> So if you used your cpu quota you will get run reluctantly. If you slept
> you will get run early and as you use time slice count you will drop
> priority bands, but without pre-emption until you cross a band and there
> is another task with higher priority.
>
> This damps down task thrashing a bit, and for the cpu hogs it gets the
> desired behaviour - which is that the all run their full quantum in the
> background one after another instead of thrashing back and forth

What if we give to  prev  a priority boost P=F(T) where T is the time
prev  is ran before the current schedule ?



- Davide


