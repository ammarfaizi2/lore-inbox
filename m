Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286127AbRLJBEf>; Sun, 9 Dec 2001 20:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286128AbRLJBEZ>; Sun, 9 Dec 2001 20:04:25 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:54541 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286127AbRLJBEK>; Sun, 9 Dec 2001 20:04:10 -0500
Date: Sun, 9 Dec 2001 17:06:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
In-Reply-To: <E16DEfs-0008UJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112091701000.996-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Alan Cox wrote:

> > So we can have simply two queues ( per CPU ), one that stores I/O bound (
> > counter > K for example ) and RT tasks that is walked entirely searching
> > for the better tasks, the other queue will store CPU bound tasks that are
> > executed in a FIFO policy.
>
> Oh as an aside btw - there are many real world workloads where we have a lot
> of non cpu hog processes running. A lot of messaging systems have high task
> switch rates but very few cpu hogs. So you still need to handle the non hogs
> carefully to avoid degenerating back into Linus scheduler.

In my experience, if you've I/O bound tasks that lead to a long run queue,
that means that you're suffering major kernel latency problems ( other than the
scheduler ).




- Davide


