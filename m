Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272422AbTGaHEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272423AbTGaHEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:04:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:165 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272422AbTGaHEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:04:48 -0400
Date: Thu, 31 Jul 2003 09:04:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linas@austin.ibm.com, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030730221717.GB23835@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307310902540.11798-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jul 2003, Andrea Arcangeli wrote:

> ah, finally I see how can the timer->lock can have made the kernel
> stable again!
> 
> run_all_timers can still definitely run on x86 too if the local cpu
> timer runs on top of an irq handler:

as i told you ...

i've added the TIMER_BH thing to the 2.4 patch to ensure timer-fn
single-threadedness.

this issue has been fixed in 2.6 by the removal of TIMER_BH.

	Ingo

