Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVKQTPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVKQTPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVKQTPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:15:32 -0500
Received: from xenotime.net ([66.160.160.81]:161 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964774AbVKQTPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:15:31 -0500
Date: Thu, 17 Nov 2005 11:15:30 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Dag Nygren <dag@newtech.fi>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: nanosleep with small value 
In-Reply-To: <20051117191119.15126.qmail@dag.newtech.fi>
Message-ID: <Pine.LNX.4.58.0511171114190.10946@shark.he.net>
References: <20051117191119.15126.qmail@dag.newtech.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, Dag Nygren wrote:

> > On 11/17/05, Dag Nygren <dag@newtech.fi> wrote:
>
> > > The man page for nanosleep saya that times under 2 us are implemented
> > > by a busywait and  this is why I expected it to work.
> >
> > Update your manpages. You're depending on 2.4 behavior in a 2.6 kernel.
>
> You are right. The system is one I have upgraded piece by piece and the
> manpages
> weren't upgraded.
>
> But what is the point of having a nanosleep() in that case when you could do
> just fine with usleep() ?
>
> > > OK, in that case the manpage should be changed. And an alternative
> > > has to be worked out by me ;-).
> >
> > My man-pages are quite clear on what nanosleep() does. Nothing needs
> > to be changed there.
> >
> > Alternative wise, I'm not sure, but you might want to look into the
> > HRT stuff that's going on in Ingo's -RT tree. I don't know if / what
> > changes have been made to sys_nanosleep(), but low-latency is most
> > likely to occur there.
>
> I will look into that.
> Quite annoying that software that worked just fine in 2.4 doesn't
> work in 2.6.
>
> What does POSIX say about nanosleep()?

Maybe you want to add/patch your kernel with the high-res-timer
patch from
  http://sourceforge.net/projects/high-res-timers/

-- 
~Randy
