Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276786AbSIVHUl>; Sun, 22 Sep 2002 03:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276792AbSIVHUl>; Sun, 22 Sep 2002 03:20:41 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:43392 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S276786AbSIVHUk>;
	Sun, 22 Sep 2002 03:20:40 -0400
Subject: kernel BUG at /usr/src/linux-2.5.37/include/asm/spinlock.h:123!
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 10:25:48 +0300
Message-Id: <1032679548.2042.5.camel@devil>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened on 2.5.37 with KDE artsd and OSS sound drivers.

	MikaL

Sep 21 22:12:10 devil kernel: eip: c02471a0
Sep 21 22:12:10 devil kernel: kernel BUG at /usr/src/linux-2.5.37/include/asm/spinlock.h:123!
Sep 21 22:12:10 devil kernel: invalid operand: 0000
Sep 21 22:12:10 devil kernel: CPU:    1
Sep 21 22:12:10 devil kernel: EIP:    0060:[dma_ioctl+920/2634]    Not tainted
Sep 21 22:12:10 devil kernel: EFLAGS: 00210082
Sep 21 22:12:10 devil kernel: eax: 0000000e   ebx: 40045010   ecx: d2a87e70   edx: c0368800
Sep 21 22:12:10 devil kernel: esi: 40045038   edi: d98220fc   ebp: 40045038   esp: d2a87f00
Sep 21 22:12:10 devil kernel: ds: 0068   es: 0068   ss: 0068
Sep 21 22:12:10 devil kernel: Process artsd (pid: 545, threadinfo=d2a86000 task=d2dca020)
Sep 21 22:12:10 devil kernel: Stack: c032bacd c02471a0 40045010 bffff6ec 00000000 40045010 d9822000 00000000 
Sep 21 22:12:10 devil kernel:        00200202 00000002 d9822574 00000000 d5135a20 c0125226 00000000 00001000 
Sep 21 22:12:10 devil kernel:        00000000 00000000 c0246a4c 00000000 40045010 bffff6ec 00000004 00000003 
Sep 21 22:12:10 devil kernel: Call Trace: [dma_ioctl+896/2634] [update_wall_time+18/60] [audio_ioctl+1452/1512] [sound_ioctl+341/380] [sys_ioctl+639/748] 
Sep 21 22:12:10 devil kernel:    [syscall_call+7/11] 
Sep 21 22:12:10 devil kernel: 
Sep 21 22:12:10 devil kernel: Code: 0f 0b 7b 00 a0 ba 32 c0 83 c4 08 f0 fe 0e 0f 88 aa 06 00 00 
