Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUHOS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUHOS3v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUHOS3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 14:29:51 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:52252
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S266532AbUHOS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 14:29:49 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <1092591223.1118.27.camel@krustophenia.net>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu>  <20040815115649.GA26259@elte.hu>
	 <1092578502.6543.4.camel@twins> <1092591223.1118.27.camel@krustophenia.net>
Content-Type: text/plain
Date: Sun, 15 Aug 2004 20:29:38 +0200
Message-Id: <1092594578.6543.10.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 13:33 -0400, Lee Revell wrote:
> On Sun, 2004-08-15 at 10:01, Peter Zijlstra wrote:
> 
> > It still locks up hard for me when voluntary-preempt=3, however it does
> > finish the boot; dmesg attached. The lockup occurs several minutes into
> > use; usually by by the time I've started X, launched evolution and
> > selected my first imap folder the machine's dead.
> > 
> > If you need more information or want me to try some patches, just let me
> > know.
> 
> These look a bit worrisome:
> 
> Aug 15 15:24:11 twins kernel: Total of 2 processors activated (5537.79 BogoMIPS).
> Aug 15 15:24:11 twins kernel: WARNING: This combination of AMD processors is not suitable for SMP.
> Aug 15 15:24:11 twins kernel: ENABLING IO-APIC IRQs
> 
> Aug 15 15:24:11 twins kernel: I/O APIC: AMD Errata #22 may be present. In the event of instability try
> Aug 15 15:24:11 twins kernel:         : booting with the "noapic" option.
> 

Yeah, true. I run with 2 Thunderbirds, not Athlon MPs; AMD does not like
that, the CPUs don't share that inclination.

As for the AMD Errata #22, all other kernels run rock solid without
noapic, so I don't see why these should differ. I did try noapic though,
not on P0 but on one of the later Os.


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

