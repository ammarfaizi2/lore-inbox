Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUIBW1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUIBW1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUIBWYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:24:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:12182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268034AbUIBWXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:23:08 -0400
Date: Thu, 2 Sep 2004 15:20:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mingo@elte.hu, paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040902152046.1b34d793.akpm@osdl.org>
In-Reply-To: <20040902220301.GA18212@x30.random>
References: <20040713213847.GH974@dualathlon.random>
	<20040713145424.1217b67f.akpm@osdl.org>
	<20040713220103.GJ974@dualathlon.random>
	<20040713152532.6df4a163.akpm@osdl.org>
	<20040713223701.GM974@dualathlon.random>
	<20040713154448.4d29e004.akpm@osdl.org>
	<20040713225305.GO974@dualathlon.random>
	<20040713160628.596b96a3.akpm@osdl.org>
	<20040713231803.GP974@dualathlon.random>
	<20040719115952.GA13564@elte.hu>
	<20040902220301.GA18212@x30.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  if you're scared that there are too many cond_resched (I'm not scared
>  and people should enable them anyways if they make a difference, they
>  still should be less than the number of spin_unlocks with preempt
>  enabled), then you should add a cond_resched_costly and add a config
>  option that turns it off.

None of these approaches improves worst-case latency at all on SMP.  If
we're not going to address the SMP problem we could just make it UP-only,
in which case increased locking costs are a non-issue.

I'd prefer that we find a solution for SMP too though.
