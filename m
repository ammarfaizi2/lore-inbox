Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUHOOCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUHOOCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUHOOCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:02:00 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:11559 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266689AbUHOOBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:01:46 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20040815115649.GA26259@elte.hu>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu>  <20040815115649.GA26259@elte.hu>
Content-Type: multipart/mixed; boundary="=-NUhqEMj5SThh8MvqyHR2"
Date: Sun, 15 Aug 2004 16:01:42 +0200
Message-Id: <1092578502.6543.4.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NUhqEMj5SThh8MvqyHR2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-08-15 at 13:56 +0200, Ingo Molnar wrote:
> i've uploaded the -P0 patch:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P0
> 
> those who had APIC (and USB, under SMP) problems under previous
> versions, are the problems still present in -P0?
>  
> Changes:
> 
>  - make redirected softirqs and hardirqs preemptible by default. I
>    reviewed a number of softirq users and it appears to be safe. 
>    Process-level enable/disable_bh still disables preemption, but the
>    handlers themselves run in a preemptible way. This preemptability
>    should fix e.g. the IDE latencies. It could also fix some of the 
>    /dev/random related latencies.
> 
>  - fixed a bug in hardirq redirection - we didnt re-disable interrupts
> 
>  - updated the IO-APIC changes - hopefully it's more robust now
> 
> 	Ingo

Hi Ingo,

It still locks up hard for me when voluntary-preempt=3, however it does
finish the boot; dmesg attached. The lockup occurs several minutes into
use; usually by by the time I've started X, launched evolution and
selected my first imap folder the machine's dead.

If you need more information or want me to try some patches, just let me
know.

BTW, do you intent on keeping the preempt-smp patch alive?

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

--=-NUhqEMj5SThh8MvqyHR2
Content-Disposition: attachment; filename=dmesg.2.6.8.1-P0.gz
Content-Type: application/x-gzip; name=dmesg.2.6.8.1-P0.gz
Content-Transfer-Encoding: base64

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
yzhPAAA=


--=-NUhqEMj5SThh8MvqyHR2--

