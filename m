Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUGZIWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUGZIWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUGZIWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:22:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46307 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265031AbUGZIWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:22:13 -0400
Date: Mon, 26 Jul 2004 10:23:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040726082330.GA22764@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090795742.719.4.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here is another one:
> 
> Jul 25 18:46:18 mindpipe kernel: 11ms non-preemptible critical section violated 1 ms preempt threshold starting at kmap_atomic+0x10/0x60 and ending at kunmap_atomic+0x8/0x20

> Jul 25 18:46:18 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
> Jul 25 18:46:18 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
> Jul 25 18:46:18 mindpipe kernel:  [get_user_pages+288/944] get_user_pages+0x120/0x3b0
> Jul 25 18:46:18 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
> Jul 25 18:46:18 mindpipe kernel:  [do_mmap_pgoff+998/1568] do_mmap_pgoff+0x3e6/0x620
> Jul 25 18:46:18 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
> Jul 25 18:46:18 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

is this an mmap(MAP_LOCKED) instance [or a process doing an mmap() after
having done an mlockall()]? I'll take a look.

	Ingo
