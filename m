Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUA1Tzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUA1Tzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:55:51 -0500
Received: from devil.servak.biz ([209.124.81.2]:3727 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S266249AbUA1Tzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:55:48 -0500
Subject: Re: 2.6.2-rc2-mm1
From: Torrey Hoffman <thoffman@arnor.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20040127233402.6f5d3497.akpm@osdl.org>
References: <20040127233402.6f5d3497.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1075319712.6729.5.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Jan 2004 11:55:12 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 23:34, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/

Got this during system startup, just before X came up. 
System is Fedora Core 1 with lots of updates on a P4 HT.

(I include a few lines before and after from dmesg, in case context is
relevant?)

...

lp: driver loaded but no devices found
request_module: failed /sbin/modprobe -- char-major-4-72. error = 256
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49844 usecs
intel8x0: clocking to 48000
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0243b74
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
CPU:    1
EIP:    0060:[<c0243b74>]    Not tainted VLI
EFLAGS: 00010286
EIP is at vt_ioctl+0x14/0x1f80
eax: 00000000   ebx: f5dde000   ecx: 00005607   edx: f14cd480
esi: f5dde000   edi: 00005607   ebp: f6593f70   esp: f6593ea0
ds: 007b   es: 007b   ss: 0068
Process X (pid: 2378, threadinfo=f6592000 task=f11ca6c0)
Stack: 00000006 f7f00068 f7043005 00299a31 00000003 f7337280 f6593f14
f6593f6c
       f6593f0c f7337280 f6e88480 f6593ee0 c0178bec f6593f0c f7043008
f6e88480
       f6593f30 c016fdda 00000020 f6593f30 00001846 00000001 c047991e
f7177e00
Call Trace:
 [<c0178bec>] dput+0x1c/0x2d0
 [<c016fdda>] link_path_walk+0x6ba/0xa60
 [<c016adc4>] cdev_get+0x54/0xc0
 [<c016ae3f>] cdev_put+0xf/0x60
 [<c01232f0>] schedule+0x3b0/0x740
 [<c0243b60>] vt_ioctl+0x0/0x1f80
 [<c023e885>] tty_ioctl+0x355/0x450
 [<c0173e6b>] sys_ioctl+0x11b/0x2d0
 [<c023e530>] tty_ioctl+0x0/0x450
 [<c0160b96>] sys_open+0x56/0x70
 [<c033c65a>] sysenter_past_esp+0x43/0x69
                                                                                                        
Code: ff e8 05 88 ec ff e9 70 ff ff ff 90 90 90 90 90 90 90 90 90 90 90
90 55 89 e5 57 56 53 81 ec c4 00 00 00 89 c6 8b 80 78 09 00 00 <8b> 00
89 85 30 ff ff ff 8b 04 85 20 9b 47 c0 89 45 8c 8b 85 30
 <7>request_module: failed /sbin/modprobe -- char-major-10-134. error =
256
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode

-- 
Torrey Hoffman <thoffman@arnor.net>

