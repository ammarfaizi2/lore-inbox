Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbTARDP5>; Fri, 17 Jan 2003 22:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTARDP5>; Fri, 17 Jan 2003 22:15:57 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:26572 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262266AbTARDP4>;
	Fri, 17 Jan 2003 22:15:56 -0500
Date: Sat, 18 Jan 2003 03:24:50 +0000
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>
Subject: Question about threads and signals
Message-ID: <20030118032450.GA18282@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear POSIX thread experts (i.e. Ingo and Ulrich),

I have a teensy question.  Using the new Linux 2.5 threads + glibc/NPTL:

1. If a signal is delivered to a thread, is it masked for the duration of
   the handler in (a) just that thread or (b) all threads?

   In other words, if I have 3 threads and SIGIO is not blocked in any
   of them, is it possible for my SIGIO handler to be called up to 3
   times concurrently?  Or is the blocked mask somehow shared?

   Is the same thing true of SIGCHLD?  SIGSEGV?

2. Is this true of POSIX threads in general, or just Linux?

Thanks,
-- Jamie




