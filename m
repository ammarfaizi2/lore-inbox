Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286147AbRLJCrD>; Sun, 9 Dec 2001 21:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286148AbRLJCqy>; Sun, 9 Dec 2001 21:46:54 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:16659 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286147AbRLJCqp>;
	Sun, 9 Dec 2001 21:46:45 -0500
Date: Mon, 10 Dec 2001 00:46:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Robert Love <rml@tech9.net>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Anthony DeRobertis <asd@suespammers.org>, root <r6144@263.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make highly niced processes run only when idle
In-Reply-To: <1007944229.878.21.camel@phantasy>
Message-ID: <Pine.LNX.4.33L.0112100045460.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Dec 2001, Robert Love wrote:

> Hmm, what if we only boosted it based on something like this:
>
> 	if (p->policy == SCHED_IDLE) {
> 		weight = p->counter;
> 		if (p->lock_depth >= 0 || signal_pending(p))
> 			/* boost somehow ... */
> 	}

Now what if the process is holding an inode or superblock
semaphore ?

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

