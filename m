Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUDBJE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUDBJE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:04:29 -0500
Received: from [212.44.21.71] ([212.44.21.71]:20707 "EHLO
	femailgate.zeus.co.uk") by vger.kernel.org with ESMTP
	id S263366AbUDBJE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:04:26 -0500
Date: Fri, 2 Apr 2004 10:04:19 +0100 (BST)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: Steven Dake <sdake@mvista.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
In-Reply-To: <1080862174.9534.112.camel@persist.az.mvista.com>
Message-ID: <Pine.LNX.4.58.0404020950560.3066@stones.cam.zeus.com>
References: <Pine.LNX.4.44.0404011125510.2509-100000@bigblue.dev.mdolabs.com>
 <1080862174.9534.112.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1B9Kb5-00047B-00*3zJFgkIaXdI* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Steven Dake wrote:

> On Thu, 2004-04-01 at 12:28, Davide Libenzi wrote:
> > On Thu, 1 Apr 2004, Ben Mansell wrote:
> >
> > > > It is a feature. epoll OR user events with POLLHUP|POLLERR so that even if
> > > > the user sets the event mask to zero, it can still know when something
> > > > like those abnormal condition happened. Which problem do you see with this?
> > >
> > > What should the application do if it gets events that it didn't ask for?
> > > If you choose to ignore them, the next time epoll_wait() is called it
> > > will return instantly with these same messages, so the app will spin and
> > > eat CPU.
> >
> > Shouldn't the application handle those exceptional conditions instead of
> > ignoring them?
>
> If an exception occurs (example a socket is disconnected) the socket
> should be removed from the fd list.  There is really no point in passing
> in an excepted fd.

Is there any difference, speed-wise, between turning off all events to
listen to with EPOLL_MOD, and removing the file descriptor with
EPOLL_DEL? I had vaguely assumed that the former would be faster
(especially if you might later want to resume listening for events),
although that was just a guess.


Ben
