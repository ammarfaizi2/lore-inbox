Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318206AbSHMQBg>; Tue, 13 Aug 2002 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSHMQBg>; Tue, 13 Aug 2002 12:01:36 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:64778 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318206AbSHMQBe>; Tue, 13 Aug 2002 12:01:34 -0400
Date: Tue, 13 Aug 2002 17:05:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Message-ID: <20020813170522.A12224@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20020813164415.A11554@infradead.org> <Pine.LNX.4.44.0208130852450.7291-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208130852450.7291-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Aug 13, 2002 at 09:01:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 09:01:56AM -0700, Linus Torvalds wrote:
> > First the name souns horrible.  What about spawn_thread or create_thread
> > instead?  it's not our good old clone and not a lookalike, it's some
> > pthreadish monster..
> 
> This one definitely isn't a pthread-specific problem. The old UNIX fork()  
> semantics for <pid> returning really are fairly broken, since the notion
> of returning the pid in a local register is inherently racy for _anything_
> that wants to maintain a list of its children and needs to access the list 
> in the SIGCHLD handler.

The TLS setting makes it pretty pthread-specific, though (or at least
thread-specific).  Also the fn parameter makes it very different from
both clone and fork.  What about spawn() if you dislike a thread in the name?

