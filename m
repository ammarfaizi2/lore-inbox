Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSHMQMQ>; Tue, 13 Aug 2002 12:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSHMQMP>; Tue, 13 Aug 2002 12:12:15 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:7435 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318208AbSHMQMO>; Tue, 13 Aug 2002 12:12:14 -0400
Date: Tue, 13 Aug 2002 17:16:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kwaitd, 2.5.31-A1
Message-ID: <20020813171603.A12621@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208131755090.31234-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208131755090.31234-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Aug 13, 2002 at 06:01:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 06:01:48PM +0200, Ingo Molnar wrote:
> the reaping of the thread is thus not done by the parent (or init), but by
> per-CPU [kwaitd] kernel threads. The exiting thread queues itself always
> to the CPU-local kwaitd queue, to maintain locality of reference and cheap
> switching to kwaitd.

Is there a reason you don't use kevent for this?  Especially when going to
the per-CPU kevent as part of aio?

