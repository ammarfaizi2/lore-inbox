Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSHMQ3J>; Tue, 13 Aug 2002 12:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSHMQ3I>; Tue, 13 Aug 2002 12:29:08 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:56021 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318222AbSHMQ3I>;
	Tue, 13 Aug 2002 12:29:08 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.13490.713278.815154@napali.hpl.hp.com>
Date: Tue, 13 Aug 2002 09:32:50 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: Erik Andersen <andersen@codepoet.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <20020813171138.A12546@infradead.org>
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>
	<20020813164415.A11554@infradead.org>
	<20020813160924.GA3821@codepoet.org>
	<20020813171138.A12546@infradead.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 13 Aug 2002 17:11:38 +0100, Christoph Hellwig <hch@infradead.org> said:

  Chris> On Tue, Aug 13, 2002 at 10:09:24AM -0600, Erik Andersen
  Chris> wrote:
  >> > First the name souns horrible.  What about spawn_thread or
  >> create_thread > instead?  it's not our good old clone and not a
  >> lookalike, it's some > pthreadish monster..
  >>
  >> How about "clone2"?

  Chris> Already used by ia64 for a hybrid between the good old clone
  Chris> and the new monster :)

The original clone() system call was misdesigned.  Even if you chose
to ignore ia64, clone() cannot be used by portable applications to
specify a stack (think "stack-growth direction").

clone() should have specified a stack memory *area* from the
beginning.  (UNIX got this right from the beginning, see, e.g.,
sigaltstack()).

	--david
