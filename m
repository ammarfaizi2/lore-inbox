Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265353AbUF2Dqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUF2Dqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 23:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUF2Dqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 23:46:50 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:38047 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S265353AbUF2Dqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 23:46:43 -0400
Date: Mon, 28 Jun 2004 20:46:40 -0700
Message-Id: <200406290346.i5T3keo1022764@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: Linus Torvalds's message of  Monday, 28 June 2004 20:42:35 -0700 <Pine.LNX.4.58.0406282039200.28764@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Windows: foiled again.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I refuse to make the fast-path slower just because of this. 

You are talking about the int $0x80 system call path here?
That is the only non-exception path touched by my changes.

> Not only has Linux always worked like this, as far as I know all other
> x86 OS's also tend to just do the Intel behaviour thing.

The only other one I have at hand to test is NetBSD 1.6.1, which does
indeed behave the same way for its int $0x80 system calls.


Thanks,
Roland
