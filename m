Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266144AbUGMVjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUGMVjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUGMVjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:39:21 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:25798 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266144AbUGMVjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:39:13 -0400
Date: Tue, 13 Jul 2004 23:38:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040713213847.GH974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <200407130001.i6D01pkJ003489@localhost.localdomain> <20040712170844.6bd01712.akpm@osdl.org> <20040713162539.GD974@dualathlon.random> <20040713114829.705b9607.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713114829.705b9607.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 11:48:29AM -0700, Andrew Morton wrote:
> sys_sched_yield() also calls schedule() with local interrupts disabled. 
> It's a bit grubby, but saves a few cycles.  Nick and Ingo prefer it that way.

we can remove the irqs_disabled() check in might_sleep then, I'd like to
call might_sleep from cond_resched.
