Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268923AbUHMBQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268923AbUHMBQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUHMBQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:16:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39398 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268923AbUHMBQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:16:28 -0400
Subject: Re: [Jackit-devel] Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <20040813025546.1372fbc6@mango.fruits.de>
References: <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
	 <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu>
	 <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu>
	 <20040811141649.447f112f@mango.fruits.de> <20040811124342.GA17017@elte.hu>
	 <1092268536.1090.7.camel@mindpipe> <20040812072127.GA20386@elte.hu>
	 <1092347654.11134.10.camel@mindpipe> <1092355488.1304.52.camel@mindpipe>
	 <1092356877.1304.58.camel@mindpipe>
	 <20040813025546.1372fbc6@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092359820.1304.70.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 21:17:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 20:55, Florian Schmidt wrote:
> I think many of the jackd xruns are really jacks business. But maybe i
> misinterpret the symptom.
> 

I also get this one with apt-get dist-upgrade:

(dpkg/11902): 444us [0 jiffy] non-preemptible critical section violated
300 us preempt threshold starting at copy_mm+0x31b/0x3f0 and ending at
copy_page_range+0x144/0x290
 [<c0106497>] dump_stack+0x17/0x20
 [<c0113dc2>] touch_preempt_timing+0x32/0x40
 [<c013b7b4>] copy_page_range+0x144/0x290
 [<c0114922>] copy_mm+0x362/0x3f0
 [<c0115243>] copy_process+0x3d3/0xb60
 [<c0115a11>] do_fork+0x41/0x1b3
 [<c01049b9>] sys_clone+0x29/0x30
 [<c0105e57>] syscall_call+0x7/0xb

Shouldn't fork()'ing a dpkg process be a lot faster than that, with
copy-on-write etc?

Lee

