Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbVHJXmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVHJXmS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVHJXmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:42:18 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:25761 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932607AbVHJXmS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:42:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RLzohFvgk8g6Z0IvWoEEYICSkqjP71mJOLVctBxErkTF7+mrwtLdBJjv/2vZixDk8IqzyjgfwHMoAfdNwzd2Yk/G2PGq3U5o9eqHR19fiW+/kmkpHPECSpguzPoJq67DSBlY3yBV+j+fKOYk3BZgLD0O09k5Zote0Kqg1S13wv8=
Message-ID: <86802c4405081016421db9baa5@mail.gmail.com>
Date: Wed, 10 Aug 2005 16:42:16 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Cc: Mike Waychison <mikew@google.com>, YhLu <YhLu@tyan.com>,
       Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org,
       "discuss@x86-64.org" <discuss@x86-64.org>
In-Reply-To: <20050810232614.GC27628@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB>
	 <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

you can see the difference with the patch
Booting processor 1/1 rip 6000 rsp ffff810181c61f58
Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 4000.31 BogoMIPS (lpj=8000624)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 886 cycles)
Booting processor 2/2 rip 6000 rsp ffff81017ffa3f58
Initializing CPU#2
masked ExtINT on CPU#2
Calibrating delay using timer specific routine.. 4000.30 BogoMIPS (lpj=8000605)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
 stepping 0a
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 901 cycles)
Booting processor 3/3 rip 6000 rsp ffff8101fffa9f58
Initializing CPU#3
masked ExtINT on CPU#3
Calibrating delay using timer specific routine.. 4000.31 BogoMIPS (lpj=8000622)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
 stepping 0a
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -3 cycles, maxerr 1504 cycles)
Brought up 4 CPUs


without the patch
Booting processor 1/4 APIC 0x1
Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 4000.30 BogoMIPS (lpj=8000608)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
 stepping 0a
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/4 APIC 0x2
Initializing CPU#2
masked ExtINT on CPU#2
CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 893 cycles)
Calibrating delay using timer specific routine.. 4000.36 BogoMIPS (lpj=8000724)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2 -> Core 0
 stepping 0a
CPU 2: Syncing TSC to CPU 0.
Booting processor 3/4 APIC 0x3
Initializing CPU#3
masked ExtINT on CPU#3
CPU 2: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 904 cycles)
Calibrating delay using timer specific routine.. 4000.16 BogoMIPS (lpj=8000335)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3 -> Core 0
 stepping 0a
CPU 3: Syncing TSC to CPU 0.
Brought up 4 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs...<6>CPU 3: synchronized TSC with CPU 0
(last diff -18 cycles, maxerr 1504 cycles)
it isn't (no cpio magic); looks like an initrd

So my patch still can be used with Eric's, It just serialize the
TSC_SYNC between cpu.

I wonder it you can refine to make TSC_SYNC serialize that beteen CPU.
That will make
CPU X:synchronized TSC ... 
in fixed postion and timming.

YH


On 8/10/05, Andi Kleen <ak@suse.de> wrote:
> On Wed, Aug 10, 2005 at 04:14:19PM -0700, Mike Waychison wrote:
> > YhLu wrote:
> > >andi,
> > >
> > >please refer the patch, it will move cpu_set(, cpu_callin_map) from
> > >smi_callin to start_secondary.
> >
> >
> > This patch fixes an apparent race / lockup on our 2-way dual cores (when
> > applied against 2.6.12.3).  The machine was locking up after
> > "Initializing CPU#2".
> 
> The real solution for this issue is the smp_call_function_single patch from Eric
> that I reposted yesterday. Yh's patch just changed the timing slightly.
> 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
