Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUGZI33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUGZI33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGZI33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:29:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:40855 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265040AbUGZI31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:29:27 -0400
Subject: Re: preempt-timing-2.6.8-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040726082330.GA22764@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com>
	 <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu>
Content-Type: text/plain
Message-Id: <1090830574.6936.96.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 04:29:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 04:23, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here is another one:
> > 
> > Jul 25 18:46:18 mindpipe kernel: 11ms non-preemptible critical section violated 1 ms preempt threshold starting at kmap_atomic+0x10/0x60 and ending at kunmap_atomic+0x8/0x20
> 
> > Jul 25 18:46:18 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
> > Jul 25 18:46:18 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
> > Jul 25 18:46:18 mindpipe kernel:  [get_user_pages+288/944] get_user_pages+0x120/0x3b0
> > Jul 25 18:46:18 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
> > Jul 25 18:46:18 mindpipe kernel:  [do_mmap_pgoff+998/1568] do_mmap_pgoff+0x3e6/0x620
> > Jul 25 18:46:18 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
> > Jul 25 18:46:18 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> 
> is this an mmap(MAP_LOCKED) instance [or a process doing an mmap() after
> having done an mlockall()]? I'll take a look.
> 

Yes, jackd does exactly this, mlockall then opens the ALSA driver with
mmap.

Lee

