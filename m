Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279005AbRKRL6B>; Sun, 18 Nov 2001 06:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279035AbRKRL5m>; Sun, 18 Nov 2001 06:57:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19460 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279005AbRKRL5W>; Sun, 18 Nov 2001 06:57:22 -0500
Subject: Re: VM-related Oops: 2.4.15pre1
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 18 Nov 2001 12:05:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9t7o43$1am$1@penguin.transmeta.com> from "Linus Torvalds" at Nov 18, 2001 07:31:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165QhG-00035D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No. It would be a _gcc_ bug if gcc did things to "page->flags" that the
> code did not ask it to do. And that is _regardless_ of any notions of
> "strictly conforming C code". The fact is, that if gcc were to clear a
> bit that the code never clears, that is a HUGE AND GAPING GCC BUG.

Why is it a compiler bug. You've not declared that variable to be volatile
therefore it is only touched in the code flow the compiler is analysing.

> signals. See "sig_atomic_t" and friends - the compiler simply _has_ to
> guarantee that the semantics you write in C code are actually upheld.

Most programmers get signal handling wrong, they call stdio functions in
the handlers and far far worse. Nothing new there, even the BSD mail program
was broken.

Alan
