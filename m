Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSJZSyW>; Sat, 26 Oct 2002 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSJZSyW>; Sat, 26 Oct 2002 14:54:22 -0400
Received: from franka.aracnet.com ([216.99.193.44]:57556 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261427AbSJZSyV>; Sat, 26 Oct 2002 14:54:21 -0400
Date: Sat, 26 Oct 2002 11:58:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       landley@trommello.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Message-ID: <3021989731.1035633481@[10.10.2.3]>
In-Reply-To: <200210251015.46388.efocht@ess.nec.de>
References: <200210251015.46388.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I still haven't been able to get your scheduler to boot for about
>> the last month without crashing the system. Andrew says he has it
>> booting somehow on 2.5.44-mm4, so I'll steal his kernel tommorow and
>> see how it looks. If the numbers look good for doing boring things
>> like kernel compile, SDET, etc, I'm happy.
> 
> I thought this problem is well understood! For some reasons independent of
> my patch you have to boot your machines with the "notsc" option. This
> leaves the cache_decay_ticks variable initialized to zero which my patch
> doesn't like. I'm trying to deal with this inside the patch but there is
> still a small window when the variable is zero. In my opinion this needs
> to be fixed somewhere in arch/i386/kernel/smpboot.c. Booting a machine
> with cache_decay_ticks=0 is pure nonsense, as it switches off cache
> affinity which you absolutely need! So even if "notsc" is a legal option,
> it should be fixed such that it doesn't leave your machine without cache
> affinity. That would anyway give you a falsified behavior of the O(1)
> scheduler.

Oh, not sure if I ever replied to this or not. I don't *have* to boot
with notsc, I just usually do. And it crashed either way, so it's a
different problem (changing versions of gcc seems to perturb it too).
BUT ... your new patches 1 and 2 don't have this problem. See followup
email in a second.

M.

