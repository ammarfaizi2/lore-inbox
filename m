Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbTBOBF6>; Fri, 14 Feb 2003 20:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbTBOBF6>; Fri, 14 Feb 2003 20:05:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56760 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268511AbTBOBFe>;
	Fri, 14 Feb 2003 20:05:34 -0500
Date: Fri, 14 Feb 2003 17:12:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: Synchronous signal delivery..
Message-Id: <20030214171227.39c493d2.rddunlap@osdl.org>
In-Reply-To: <20030215010153.GE4333@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
	<20030214024046.GA18214@bjl1.jlokier.co.uk>
	<Pine.LNX.4.50.0302141603220.988-100000@blue1.dev.mcafeelabs.com>
	<20030215010153.GE4333@bjl1.jlokier.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003 01:01:53 +0000
Jamie Lokier <jamie@shareable.org> wrote:

| Davide Libenzi wrote:
...
| > 
| > Hmm ... using read() you'll lose the timeout capability, that IMHO is
| > pretty nice.
| 
| Very good point.
| 
| Timeouts could be events too - probably a good idea as they can then
| be absolute, relative, attached to different system clocks (monotonic
| vs. timeofday).  I think the POSIX timer work is like that.

Hi Davide, Jamie-

Yep.  And there are people (plural :) who would still like to get
that patch accepted into 2.5 too....

| It seems like a good idea to be able to attach one timeout event in
| the same system call as the event_read call itself - because it is
| _so_ common to vary the expiry time every time.
| 
| Then again, it is also extremely common to write this:
| 
| 	gettimeofday(...)
| 	// calculate time until next application timer expires.
| 	// Note also race condition here, if we're preempted.
| 	read_events(..., next_app_time - timeofday)
| 	// we need to know the current time.
| 	gettimeofday(...)
| 
| So perhaps the current select/poll/epoll timeout method is not
| particularly optimal as it is?

--
~Randy
