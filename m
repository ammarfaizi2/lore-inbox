Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272693AbRIPTEb>; Sun, 16 Sep 2001 15:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272681AbRIPTEV>; Sun, 16 Sep 2001 15:04:21 -0400
Received: from ns.caldera.de ([212.34.180.1]:45477 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S272679AbRIPTEJ>;
	Sun, 16 Sep 2001 15:04:09 -0400
Date: Sun, 16 Sep 2001 21:04:21 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010916210421.A32343@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010910210607.C715@athlon.random> <Pine.LNX.4.33L.0109161359040.9536-100000@imladris.rielhome.conectiva> <20010916192316.A13248@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010916192316.A13248@athlon.random>; from andrea@suse.de on Sun, Sep 16, 2001 at 07:23:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 07:23:16PM +0200, Andrea Arcangeli wrote:
> > I can't quite remember if it was Linus or Larry who said:
> > 
> > "Threads are for people who don't understand state machines"
> > 
> > 
> > If you cannot make your code clean without adding another
> > thread, it's probably a bad sign ;)
> 
> Ask yourself why libaio in glibc uses threads.

Because glibc always uses the more bloated appropeach if there is a choice?

/me runs

> When there's no async-io
> hook you have no choice. Adding the hook is an advantage if you're going
> to use it during production, much better than
> rescheduling/creating/destroying various threads during production, but
> if you only need to register the hook once per day you'd waste time all
> the production time checking if somebody is registered in the hook.

I'd really like to see Ben's worktodo's in 2.4 - they are usefull even
without his whole asynchio framework and don't need big kernel changes..

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
