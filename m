Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbTAGXDX>; Tue, 7 Jan 2003 18:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267562AbTAGXDX>; Tue, 7 Jan 2003 18:03:23 -0500
Received: from franka.aracnet.com ([216.99.193.44]:25321 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267558AbTAGXDW>; Tue, 7 Jan 2003 18:03:22 -0500
Date: Tue, 07 Jan 2003 15:11:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, Andy Pfiffer <andyp@osdl.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com, Werner Almesberger <wa@almesberger.net>
Subject: Re: [PATCH] kexec for 2.5.54
Message-ID: <29440000.1041981101@titus>
In-Reply-To: <3E1B5C44.1030302@us.ibm.com>
References: <m1smwql3av.fsf@frodo.biederman.org>	<20021231200519.A2110@in.ibm.com> <m11y3uldt9.fsf@frodo.biederman.org>	<20030103181100.A10924@in.ibm.com>  <m1fzs6j0bh.fsf_-_@frodo.biederman.org> <1041979560.12674.93.camel@andyp> <3E1B5C44.1030302@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... taking poor Linus off the cc list
> Andy Pfiffer wrote:
>> For those that have had success w/ recent vintage kernels and kexec (>
>> 2.5.48), could I get a roll-call of your machine's hardware?  Uniproc,
>> SMP, AGP, chipset, BIOS version, that kind of thing.  lspci -v,
>> /cat/proc/cpuinfo, and maybe the boot-up messages would all be
>> appreciated.
> 
> I've had it work on 2 IBM x86 boxes.
> 4/8-way SMP
> 1/4/16 GB RAM
> no AGP
> Intel Profusion Chipset and some funky IBM one
> 
> It failed on the NUMA-Q's I tried it on.  I haven't investigated any more thoroughly.
> 
> If you want more details, let me know.  But, I've never seen your "Calibrating delay loop..." problem.  The last time I saw problems there was when I broke the interrupt stack patches.  But, since those aren't in mainline, you shouldn't be seeing it.


Last time I saw calibrating delay loop problems, it just mean the other CPUs
weren't getting / acting upon IPIs. I might expect that on NUMA-Q, but the
INIT, INIT, STARTUP sequence on normal machines should kick the remote proc
pretty damned hard and reset it. You might want to add more APIC resetting
things (I think there are some in there that only NUMA-Q does right now ..
try turning those on).

M.

