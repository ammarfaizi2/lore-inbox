Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318152AbSHMPk0>; Tue, 13 Aug 2002 11:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318176AbSHMPkZ>; Tue, 13 Aug 2002 11:40:25 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:57610 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318152AbSHMPkZ>; Tue, 13 Aug 2002 11:40:25 -0400
Date: Tue, 13 Aug 2002 16:44:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Message-ID: <20020813164415.A11554@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Aug 13, 2002 at 05:09:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 05:09:03PM +0200, Ingo Molnar wrote:
> 
> the attached patch implements a new syscall on x86, clone_startup().
> The parameters are:
> 
> 	clone_startup(fn, child_stack, flags, tls_desc, pid_addr)

First the name souns horrible.  What about spawn_thread or create_thread
instead?  it's not our good old clone and not a lookalike, it's some
pthreadish monster..

> with the help of this syscall glibc's next-generation pthreads code

have you discussed this code with IBM's pthread group?  I think we don't
want to add a new syscall that is only useful to glibc..

