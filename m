Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVF1HcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVF1HcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVF1H3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:29:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4052 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262005AbVF1H1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:27:40 -0400
Date: Tue, 28 Jun 2005 09:27:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-git8 Voluntary preempt hangs at boot
Message-ID: <20050628072718.GA3755@elte.hu>
References: <20050627161405.60490ec3.thatistosayiseenem@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627161405.60490ec3.thatistosayiseenem@gawab.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ash Milsted <thatistosayiseenem@gawab.com> wrote:

> Just tried out VP on 2.6.12-git8 on my UP x86 system - it hangs just 
> after configuring the cpu, i.e. enabling fast FPU restore, etc.  
> Disabling ACPI and the local APIC makes no difference. Here's my 
> current config, which *does* work - I only need to enable VP to break 
> it. Btw, it also breaks without the CFQv3 and inotify patches.

i forgot about a dependency, -VP also needs this patch:

 http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/sched-tweak-idle-thread-setup-semantics.patch

could you check that this patch ontop of -git8 indeed fixes the boot 
problem for you?

	Ingo
