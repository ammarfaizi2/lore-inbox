Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWIBBGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWIBBGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIBBGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:06:21 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:1426 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750770AbWIBBGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:06:20 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 11:06:15 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com>
References: <20060901015818.42767813.akpm@osdl.org>
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
...
>- See the `hot-fixes' directory for any important updates to this patchset.
>
Okay, I applied hotfixes and it crashed on boot, keyboard LEDs flashing:

Repeating message, hand copied:
atkbd.c: Spurious ACK in isa0060/serio0. Some program might be trying access 
hardware directly.

Thing is, I've been getting this similar message once in dmesg for ages:

<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.14.7a.gz>:
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.15.7a.gz>:
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.16.27a.gz>:
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.16.28a.gz>:
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.17.11a.gz>:
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.

<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.18-rc3-mm2a.gz>:
<no mention>

<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.18-rc4a.gz>:
atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying access hardware directly.
<http://bugsplatter.mine.nu/test/boxen/sempro/dmesg-2.6.18-rc5-git4b>:
atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying access hardware directly.

<http://bugsplatter.mine.nu/test/boxen/sempro/> for more info on hardware

This is MSI KM4M-V <http://tinyurl.com/64cfd> AMD Sempron SktA 32-bit CPU, I 
don't see the error on Intel CPU boxen, nor on an AMD K6-2/500 CPU (2.6.15.6)

Grant.

-- 
VGER BF report: U 0.480374
