Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVFFO7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVFFO7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFFO7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:59:33 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:62199 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261496AbVFFO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:59:14 -0400
Date: Mon, 06 Jun 2005 10:59:12 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RT-V0.7.47-17 build fails
In-reply-to: <20050606074112.GB10387@elte.hu>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Message-id: <200506061059.12162.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200506051757.26253.gene.heskett@verizon.net>
 <20050606074112.GB10387@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 03:41, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> Greetings;
>>
>> I thought maybe I'd exersize this kernel, but a patch I thought
>> was in seems not to have been, so I believe this is the 2nd time
>> I've encountered this:
>>
>>   CC      drivers/char/ipmi/ipmi_devintf.o
>> drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
>> drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of
>>
>> which of the 'git' patches fixes this?
>
>the fix is dca79a046b93a81496bb30ca01177fb17f37ab72. I've added it
> to my tree and have uploaded the -47-18 patch.
>
> Ingo

Thanks, it builds.  And runs mostly.  With full preemption #4 in 
the make oldconfig in effect, elevator=cfq on the vmlinuz command line, 
and tvtime-9.15 in particular seems
to be haveing a problem.  No video is delivered to the blue screened 
window.  Sound is working ok though.

And the log has several thousand of these:
Jun  6 10:02:49 coyote kernel: cx88[0]: video y / packed - dma channel status dump
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: initial risc: 0x0e59e000
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: cdt base    : 0x00180440
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: cdt size    : 0x0000000c
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: iq base     : 0x00180400
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: iq size     : 0x00000010
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: risc pc     : 0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: iq wr ptr   : 0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: iq rd ptr   : 0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: cdt current : 0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: pci target  : 0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]:   cmds: line / byte : 0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]:   risc0: 0x00000000 [ INVALID count=0 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   risc1: 0x00000000 [ INVALID count=0 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   risc2: 0x00000000 [ INVALID count=0 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   risc3: 0x00000000 [ INVALID count=0 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 0: 0x80008000 [ sync resync count=0 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 1: 0x1c000500 [ write sol eol count=1280 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 2: 0x1ce3c000 [ arg #1 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 3: 0x1c000500 [ write sol eol count=1280 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 4: 0x1ce3ca00 [ arg #1 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 5: 0x1c000500 [ write sol eol count=1280 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 6: 0x1ce3d400 [ arg #1 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 7: 0x18000200 [ write sol count=512 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 8: 0x1ce3de00 [ arg #1 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq 9: 0x14000300 [ write eol count=768 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq a: 0x1ce3e000 [ arg #1 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq b: 0x1c000500 [ write sol eol count=1280 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq c: 0x1ce3e800 [ arg #1 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq d: 0x0031c040 [ INVALID 21 20 cnt0 resync 14 count=64 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq e: 0x00000000 [ INVALID count=0 ]
Jun  6 10:02:49 coyote kernel: cx88[0]:   iq f: 0x00000011 [ INVALID count=17 ]
Jun  6 10:02:49 coyote kernel: cx88[0]: fifo: 0x00180c00 -> 0x183400
Jun  6 10:02:49 coyote kernel: cx88[0]: ctrl: 0x00180400 -> 0x180460
Jun  6 10:02:49 coyote kernel: cx88[0]:   ptr1_reg: 0x00182000
Jun  6 10:02:49 coyote kernel: cx88[0]:   ptr2_reg: 0x00180488
Jun  6 10:02:49 coyote kernel: cx88[0]:   cnt1_reg: 0x0000000b
Jun  6 10:02:49 coyote kernel: cx88[0]:   cnt2_reg: 0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]/0: [cfb3a880/0] timeout - dma=0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]/0: [c9d86340/1] timeout - dma=0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]/0: [cfb3a680/2] timeout - dma=0x00000000
Jun  6 10:02:49 coyote kernel: cx88[0]/0: [f757d560/3] timeout - dma=0x0e59e000
Jun  6 10:02:49 coyote kernel: cx88[0]: video y / packed - dma channel status dump

repeat from last line above many times a second as long as its running, and when
its stopped:
Jun  6 10:03:09 coyote kernel: rtc latency histogram of {tvtime/3960, 583 samples}:
Jun  6 10:03:09 coyote kernel: 5 2
Jun  6 10:03:09 coyote kernel: 6 83
Jun  6 10:03:09 coyote kernel: 7 206
Jun  6 10:03:09 coyote kernel: 8 58
Jun  6 10:03:09 coyote kernel: 9 44
Jun  6 10:03:09 coyote kernel: 10 18
Jun  6 10:03:09 coyote kernel: 11 19
Jun  6 10:03:09 coyote kernel: 12 18
Jun  6 10:03:09 coyote kernel: 13 20
Jun  6 10:03:09 coyote kernel: 14 25
Jun  6 10:03:09 coyote kernel: 15 22
Jun  6 10:03:09 coyote kernel: 16 11
Jun  6 10:03:09 coyote kernel: 17 6
Jun  6 10:03:09 coyote kernel: 18 4
Jun  6 10:03:09 coyote kernel: 19 1
Jun  6 10:03:09 coyote kernel: 20 3
Jun  6 10:03:09 coyote kernel: 21 2
Jun  6 10:03:09 coyote kernel: 22 1
Jun  6 10:03:09 coyote kernel: 25 1
Jun  6 10:03:09 coyote kernel: 28 1
Jun  6 10:03:09 coyote kernel: 29 1
Jun  6 10:03:09 coyote kernel: 9999 37

I presume the default traceing options are using too much
time in logging, hence the dma failure, but thats a not
very scientific guess on my part.

I also reported this in a previous test of one of the 47-xx
kernels I'd managed to make build with the git2 patch also
applied.  That was with some pretty large offsets, 300+ lines
in one case.  That message wasn't ack'd, probably lost in the noise.

Is there some specific xconfig traceing option I can turn off
that will restore tvtime, or is the above a genuine breakage?

Or will tvtime require a rewrite for compatibility with this
new code framework?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
