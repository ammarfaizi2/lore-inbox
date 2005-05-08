Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVEHDVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVEHDVW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 23:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVEHDVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 23:21:20 -0400
Received: from HostMaster28.hostingbay.net ([67.15.120.2]:44490 "EHLO
	HostMaster28.hostingbay.net") by vger.kernel.org with ESMTP
	id S262802AbVEHDU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 23:20:59 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
From: Norval Watson <norv@longforest.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 08 May 2005 13:30:45 +1000
Message-Id: <1115523045.4132.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - HostMaster28.hostingbay.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - longforest.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried to build 2.6.12-rc3 kernel with Ingo's
realtime-preempt-2.6.12-rc3-V0.7.46-02 on amd64

When I enabled option 4, Complete Realtime, make bzImage failed as
described in Lee Revell's Apr 12 lkml post:
http://lkml.org/lkml/2005/4/12/523

"HOSTCC scripts/bin2c 
CC arch/x86_64/kernel/asm-offsets.s 
CHK include/asm-x86_64/offset.h 
UPD include/asm-x86_64/offset.h 
CC init/main.o 
In file included from include/linux/rwsem.h:38, 
from include/linux/kobject.h:24, 
from include/linux/module.h:19, 
from init/main.c:16: 
include/asm/rwsem.h:55: error: redefinition of `struct rw_semaphore' 
etc etc......"

When I started again with option 3, Low Latency Desktop, the build got a
bit further before hanging: (Full ouput:
http://www.longforest.com/index.php?option=com_content&task=view&id=133&Itemid=2 )

"
  CC      arch/x86_64/kernel/head64.o
  CC      arch/x86_64/kernel/init_task.o
arch/x86_64/kernel/init_task.c:17: warning: implicit declaration of
function `__RWSEM_INITIALIZER'
arch/x86_64/kernel/init_task.c:17: warning: missing braces around
initializer

...etc etc etc...

 constant
arch/x86_64/kernel/init_task.c:17: error: (near initialization for
`init_mm.default_kioctx')
make[1]: *** [arch/x86_64/kernel/init_task.o] Error 1
make: *** [arch/x86_64/kernel] Error 2"

Please CC any advice (or abuse!),
I can supply further info if required
Cheers,
Norv

