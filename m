Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263164AbTCNNaw>; Fri, 14 Mar 2003 08:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCNNav>; Fri, 14 Mar 2003 08:30:51 -0500
Received: from [80.190.48.67] ([80.190.48.67]:60166 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S263164AbTCNNat> convert rfc822-to-8bit; Fri, 14 Mar 2003 08:30:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
Date: Fri, 14 Mar 2003 14:39:07 +0100
User-Agent: KMail/1.4.3
References: <20030314090825.GB1375@dualathlon.random>
In-Reply-To: <20030314090825.GB1375@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303141437.11589.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 March 2003 10:08, Andrea Arcangeli wrote:

Hi Andrea,

> Only in 2.4.21pre5aa1: 22_sched-deadlock-mmdrop-1
>
> 	Backport from 2.5 (in a more icache friendy way) an anti-deadlock
> 	fix for the o1 scheduler that can otherwise send a cross IPI with
> 	irq disabled.
I get _tons_ of these messages:

Initializing RT netlink socket
rq->prev_mm was c025b0e0 set to c025b0e0 - swapper
dffddf4c c0115786 c023b1a0 c025b0e0 c025b0e0 dffdc24e dffddfbc dffce02c 
       dffdc000 00000000 dffdc000 dffddfbc c0105000 0008e000 c01072bd 00000700 
       c0125d00 c02916a8 dffddfbc c0105000 0008e000 00000002 c01e0018 dffd0018 
Call Trace: [<c0115786>]  [<c0105000>]  [<c01072bd>]  [<c0125d00>]  
[<c0105000>]  [<c01e0018>]  [<c0105685>]  [<c0125faf>]  [<c0125d00>]  
[<c0105043>]  [<c01050
00>]  [<c010568e>]  [<c0105030>] 
rq->prev_mm was c025b0e0 set to c025b0e0 - keventd
dffcff4c c0115786 c023b1a0 c025b0e0 c025b0e0 dffce24e 00000011 dffdc02c 
       dffce000 00000000 dffce570 dffce580 dffce256 dffce000 c0125e2d 00000011 
       dffcffa0 00000000 dffce570 dffce580 dffce000 00000001 00000000 83e58955 
Call Trace: [<c0115786>]  [<c0125e2d>]  [<c0105000>]  [<c0105000>]  
[<c010568e>]  [<c0125d00>] 
rq->prev_mm was c025b0e0 set to c025b0e0 - ksoftirqd_CPU0
dffcdf9c c0115786 c023b1a0 c025b0e0 c025b0e0 dffcc24e dffcc24e dffdc02c 
       dffcc000 00000000 dffcc000 dffcc000 dffcc000 0008e000 c011d8fe dffcc24e 
       c023ae48 00000000 00010f00 dffddfb8 c0105000 c010568e 00000000 c011d880 
Call Trace: [<c0115786>]  [<c011d8fe>]  [<c0105000>]  [<c010568e>]  
[<c011d880>] 
Starting kswapd
rq->prev_mm was c025b0e0 set to c025b0e0 - kswapd
dffcbf84 c0115786 c023b1a0 c025b0e0 c025b0e0 dffca24e 0fe45589 dffdc02c 
       dffca000 00000000 dffca000 dffcbfc4 ffffffff 0008e000 c0134306 c01071c4 
       00000000 dffca000 c025e490 c025e490 00000000 0008e000 00000000 dffd0018 
Call Trace: [<c0115786>]  [<c0134306>]  [<c01071c4>]  [<c0105000>]  
[<c010568e>]  [<c0134270>] 
bigpage subsystem: allocated 0 bigpages (=0MB).
rq->prev_mm was c025b0e0 set to c025b0e0 - bdflush
dffc9f78 c0115786 c023b1a0 c025b0e0 c025b0e0 dffc824e 3dd3ac3f dffdc02c 
       dffc8000 00000000 00000286 c023afca dffc8256 dffc9fd8 c0115b3f 00000000 
       dffc8000 c025ee04 c025ee04 00000000 00000282 000001f4 c023afca 000001f4 
Call Trace: [<c0115786>]  [<c0115b3f>]  [<c0140c5a>]  [<c0105000>]  
[<c010568e>]  [<c0140b90>] 
rq->prev_mm was c025b0e0 set to c025b0e0 - kupdated
dffc7f64 c0115786 c023b1a0 c025b0e0 c025b0e0 dffc624e 0001080d dffdc02c 
       dffc6000 00000000 0000021e dffc7fac dffc6000 dffc6000 c0121265 dffc7fac 
       83080da2 45890cec c02cbb44 c02cbb44 0000021e dffc6000 c01211f0 c02cb320 
Call Trace: [<c0115786>]  [<c0121265>]  [<c01211f0>]  [<c0140cfc>]  
[<c0105000>]  [<c010568e>]  [<c0140c70>] 
aio_setup: num_physpages = 32760
aio_setup: sizeof(struct page) = 44

....

rq->prev_mm was c40dddc0 set to c40ddf00 - grep
cb795f64 c0115786 c023b1a0 c40dddc0 c40ddf00 cb79424e c011bd9d cb7fc02c 
       cb794000 00000000 c16fa7a0 c158d200 cb794000 00000000 c011c1da cb794000 
       c16fa7a0 cb794000 4012e8c4 00000000 bffff838 c011c233 00000000 c010720f 
Call Trace: [<c0115786>]  [<c011bd9d>]  [<c011c1da>]  [<c011c233>]  
[<c010720f>] 
rq->prev_mm was c40ddf00 set to cb78a0c0 - grep
cb789f64 c0115786 c023b1a0 c40ddf00 cb78a0c0 cb78824e c011bd9d cb7fc02c 
       cb788000 00000000 c16fa760 c158d200 cb788000 00000000 c011c1da cb788000 
       c16fa760 cb788000 4012e8c4 00000000 bffff838 c011c233 00000000 c010720f 
Call Trace: [<c0115786>]  [<c011bd9d>]  [<c011c1da>]  [<c011c233>]  
[<c010720f>]



Machine:

Celeron 1,3GHz, UP, 512MB RAM, IDE.


ciao, Marc


