Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313460AbSC2Pqz>; Fri, 29 Mar 2002 10:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313462AbSC2Pqr>; Fri, 29 Mar 2002 10:46:47 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31947 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313460AbSC2Pqd>;
	Fri, 29 Mar 2002 10:46:33 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15524.35903.821173.784043@napali.hpl.hp.com>
Date: Fri, 29 Mar 2002 07:46:07 -0800
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: <20020329152314.A22333@phoenix.infradead.org>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 29 Mar 2002 15:23:14 +0000, Christoph Hellwig <hch@infradead.org> said:

  Christoph> This patch adds a prototype for show_stack to sched.h and
  Christoph> exports it.  Andrea's VM updates want this, as does Tux
  Christoph> and I think it's a facility we want to proive genericly.

  Christoph> Note that some architectures (e.g. ia64) have a
  Christoph> conflicting prototype and some (e.g. sparc) don't have
  Christoph> show_stack at all, but I think -pre5 is early enough in
  Christoph> the 2.4.19 cycle to let the maintainers fix it.

  Christoph> Could you apply the patch to your tree?

Please don't.  The patch is broken.

Christoph, why do you think the prototype for ia64 is different?  It's
because it *has to be*.  In general, you can't do a backtrace without
having the full (preserved) state of the CPU at the point of which the
backtrace begins.

	--david
