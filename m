Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTBPAIU>; Sat, 15 Feb 2003 19:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBPAIU>; Sat, 15 Feb 2003 19:08:20 -0500
Received: from almesberger.net ([63.105.73.239]:786 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id <S265097AbTBPAIT>;
	Sat, 15 Feb 2003 19:08:19 -0500
Date: Sat, 15 Feb 2003 21:18:08 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215211808.K2092@almesberger.net>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <Pine.LNX.4.50.0302131215140.1869-100000@blue1.dev.mcafeelabs.com> <20030215010837.D2791@almesberger.net> <Pine.LNX.4.50.0302151359020.1891-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302151359020.1891-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Sat, Feb 15, 2003 at 02:00:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> You could do that, even if when you start having many timers things might
> get messy.

Manage a list of pending timers, schedule a signal for the next
one (or, if you wish, launch a thread), etc. All that is pretty
standard stuff that can be hidden in some library function, and
you can even steal a lot of the code from the kernel :-)

It would be useful, though, to have something like the
"overwrite" function I described later in this thread, in case
there is a single fd that can accumulate more timer expirations
between reads, than fit into the pipe/queue. (Admittedly a bit
of a fringe scenario.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
