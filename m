Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBWPkX>; Fri, 23 Feb 2001 10:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129190AbRBWPkO>; Fri, 23 Feb 2001 10:40:14 -0500
Received: from mta04.mail.au.uu.net ([203.2.192.84]:4502 "EHLO
	mta04.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S129104AbRBWPkD>; Fri, 23 Feb 2001 10:40:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Matt Johnston <mlkm@caifex.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID generation
Date: Fri, 23 Feb 2001 23:40:37 +0800
X-Mailer: KMail [version 1.2]
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F02@ftrs1.intranet.ftr.nl>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F02@ftrs1.intranet.ftr.nl>
MIME-Version: 1.0
Message-Id: <01022323403700.00325@box.caifex.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OpenBSD has a working implementation, might be worth looking at???

Cheers,
Matt Johnston.

On Fri, 23 Feb 2001 23:34, Heusden, Folkert van wrote:
> >> My code runs trough the whole task_list to see if a chosen pid is
> >> already
> >>
> >> in use or not.
> >
> > But it doesn't check for a recently used PID. Lets say your system is
> > exhausting 1000 PIDs/second, and that there is a window of 20ms between
>
> you
>
> > determining which PID to send to, and the recipient process receiving it.
>
> Ah, I get your point. Good point :o)
>
> I was thinking: I could split the PIDs up in 2...16383 and 16384-32767 and
> then
> switch between them when a process ends? nah, that doesn't help it.
> hmmm.
> I think random increments (instead of last_pid+1) would be the best thing
> to do then?
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
