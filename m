Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVAGO1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVAGO1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVAGO1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:27:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261433AbVAGO11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:27:27 -0500
Date: Fri, 7 Jan 2005 15:26:37 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107142637.GB20398@devserv.devel.redhat.com>
References: <20050107130407.GA8119@infradead.org> <200501071416.j07EGoa4018080@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071416.j07EGoa4018080@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:16:50AM -0500, Paul Davis wrote:
> >On Fri, Jan 07, 2005 at 07:56:02AM -0500, Paul Davis wrote:
> >> 2) this is *not* only about scheduling. Realtime tasks need
> >> mlockall() and/or mlock as well. even the man page for mlock
> >> recognizes this, yet almost all the discussion here has focused on
> >> scheduling. 
> >
> >RLIMIT_MEMLOCK is your friend.
> 
> rlimit_memlock limits the *amount* of memory that mlock() can be used
> on, not whether mlock can be used. at least, thats my understanding of
> the POSIX design for this. the man page and the source code for mlock
> support make that reasonably clear.

eh no. It defaults to zero, but if you increase it for a specific user, that
user is allowed to mlock more.

> 
> Fine, we'll continue to tell people to use "realtime" LSM for audio
> work. The people this really affects probably won't use vanilla
> kernels anyway. 

that is so not a constructive way to make progress. 
The realtime LSM is the wrong concept. It's a hack to work around other
design issues with linux. *THAT* is what makes it wrong. Not the fact that
it wouldn't work (I believe it works, I don't think anyone doubts that
much). If you are unwilling to even discuss fixing the underlying design
issues then I'm scared that this issue will never come to any workable
solution.
