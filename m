Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVAROSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVAROSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVARORu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:17:50 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:45034 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261304AbVARORH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:17:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=E9X6GCcq8M6Fw/q+QnoVPJtaS8v/JzwUb6qKLLASwDgF9g15qX4boORZppw9HC+iO5JCBBWApwf7ACoMAqnRZhxhPpVLZjU3uektnz+anRRxH6yPEwlvj7351ydLIJreKQ5J1sb6rakH3JJ/SjedbTez/pTu/PhiiJEXjndFx8w=
Message-ID: <3fff1a71050118061751fcd18@mail.gmail.com>
Date: Tue, 18 Jan 2005 16:17:06 +0200
From: Patrick <nawtyness@gmail.com>
Reply-To: Patrick <nawtyness@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: What Would Cause This :
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg produces the following : 

oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 30, high 90, batch 15
cpu 0 cold: low 0, high 30, batch 15

Free pages:        4012kB (240kB HighMem)
Active:41408 inactive:239841 dirty:0 writeback:0 unstable:0 free:1003
slab:4559 mapped:281415 pagetables:1654
DMA free:68kB min:68kB low:84kB high:100kB active:4984kB
inactive:5812kB present:16384kB pages_scanned:11351 all_unreclaimable?
no
protections[]: 0 0 0
Normal free:3704kB min:3756kB low:4692kB high:5632kB active:31768kB
inactive:826028kB present:901120kB pages_scanned:269506
all_unreclaimable? no
protections[]: 0 0 0
HighMem free:240kB min:252kB low:312kB high:376kB active:128880kB
inactive:127524kB present:261632kB pages_scanned:8619
all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 4*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 44*4kB 5*8kB 10*16kB 4*32kB 2*64kB 0*128kB 2*256kB 1*512kB
0*1024kB 1*2048kB 0*4096kB = 3704kB
HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 240kB
Swap cache: add 593035, delete 592831, find 18378/27962, race 0+0
Out of Memory: Killed process 6814 (rsync).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 30, high 90, batch 15
cpu 0 cold: low 0, high 30, batch 15

Free pages:        4956kB (240kB HighMem)
Active:177148 inactive:103619 dirty:0 writeback:0 unstable:0 free:1239
slab:4480 mapped:281242 pagetables:1758
DMA free:68kB min:68kB low:84kB high:100kB active:5844kB
inactive:4948kB present:16384kB pages_scanned:54179 all_unreclaimable?
yes
protections[]: 0 0 0
Normal free:4648kB min:3756kB low:4692kB high:5632kB active:571716kB
inactive:284548kB present:901120kB pages_scanned:146374
all_unreclaimable? no
protections[]: 0 0 0
HighMem free:240kB min:252kB low:312kB high:376kB active:131032kB
inactive:124980kB present:261632kB pages_scanned:143172
all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 2*8kB 3*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 302*4kB 0*8kB 9*16kB 3*32kB 2*64kB 0*128kB 2*256kB 1*512kB
0*1024kB 1*2048kB 0*4096kB = 4648kB
HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 240kB
Swap cache: add 602170, delete 601966, find 22886/33368, race 0+7
Out of Memory: Killed process 14106 (silc).

Patrick
-- 
</N>

------
In the beginning, there was nothing. And God said, 'Let there be
Light.' And there was still nothing, but you could see a bit better.
