Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280305AbRKSW1p>; Mon, 19 Nov 2001 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280755AbRKSW1e>; Mon, 19 Nov 2001 17:27:34 -0500
Received: from kokako.CS.Berkeley.EDU ([128.32.247.165]:7808 "EHLO
	kokako.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id <S280305AbRKSW1U>; Mon, 19 Nov 2001 17:27:20 -0500
Date: Mon, 19 Nov 2001 14:27:18 -0800
From: Tachio Terauchi <tachio@cs.berkeley.edu>
To: linux-kernel@vger.kernel.org
Subject: calling sleeping functions with interrupts disabled
Message-ID: <20011119142718.B1084@kokako.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're trying to run a program analysis tool on the kernel source to
check for sleeping functions being called while interrupts are
disabled.  This will be similar to what people at Stanford did, but
we'll be using a different technique.

Here's my question:

I noticed that sleep_on() disables interrupts before it calls
schedule().  This puzzles me because my understanding was that
schedule() must not be called with interrupts disabled (if there are
no more threads to run then the system would deadlock).  Does
schedule() re-enable interrupts (it looks like it does)?  If so, why
is it bad to call sleeping functions with interrupts disabled?

Sorry if this is a silly question...

-Tachio
