Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSJAMtE>; Tue, 1 Oct 2002 08:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSJAMtE>; Tue, 1 Oct 2002 08:49:04 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:25547 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261597AbSJAMtB> convert rfc822-to-8bit; Tue, 1 Oct 2002 08:49:01 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39/2.5.40/2.5.39-mm1/2.5.40-mm1 Debug: sleeping function called from illegal context at page_alloc.c:396
Date: Tue, 1 Oct 2002 14:54:09 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210011450.07462.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

starting Unreal Tournament (yep, I want to play sometimes ;)
I get the following:

codeman kernel: PCI: Found IRQ 11 for device 00:1f.5
codeman kernel: PCI: Sharing IRQ 11 with 00:1f.3
codeman kernel: PCI: Setting latency timer of device 00:1f.5 to 64
codeman kernel: intel8x0: clocking to 48000
codeman kernel: Debug: sleeping function called from illegal context at 
page_alloc.c:396
codeman kernel: cb3e2ea8 c0113f54 c0239460 c023de50 0000018c c534cca8 c01308dc 
c023de50
codeman kernel: 0000018c 00000000 000001d0 c44e7e60 c534cca8 c012789c c60b57c0 
00000000
codeman kernel: 000001d0 c0130b58 00000000 cb3e2f60 c0149da7 cea8a5e0 c534cc00 
00000000
codeman kernel: Call Trace: [__might_sleep+84/96] [__alloc_pages+36/632] 
[handle_mm_fault+128/288] [__get_free_pages+40/96] [__pollwait+51/152] 
[<d51fc237>] [do_select+257/528] [sys_select+1054/1528] [syscall_call+7/11]
codeman kernel: 06f63>]
codeman kernel: bad: scheduling while atomic!
codeman kernel: cb3e2c08 c0112af1 c0239320 cb3e2c40 003265b3 003265db ce483800 
00000246
codeman kernel: cb3e2c40 00005622 c011dbc0 cb3e2c40 cb3e2000 cb3e2000 c02e7428 
c02e7428
codeman kernel: 003265b3 c3926ca0 c011db28 c02e6e80 d51d717a cb3e2000 cb084a00 
c534cc00
codeman kernel: Call Trace: [schedule+61/744] [schedule_timeout+140/172] 
[process_timeout+0/12] [<d51d717a>] [<d51f17f3>] [<d51e3369>] [<d51e53c1>] 
[<d51e57a8>] [vt_console_print+118/736] [__wake_up_common+51/76] 
[__wake_up+32/64] [__wake_up+52/64] [release_console_sem+178/184] 
[printk+303/344] [math_state_restore+38/56] [device_not_available+37/42] 
[save_init_fpu+16/56] [__switch_to+60/304] [schedule+648/744] [<d51e5b1f>] 
[<d51e5b7b>] [<d51f9e46>] [<d51f9eba>] [<d51fa280>] [<d51fc15a>] 
[vfs_write+177/288] [sys_write+42/60] [syscall_call+7/11]
codeman kernel: bad: scheduling while atomic!
codeman kernel: cb3e2c08 c0112af1 c0239320 cb3e2c40 003265b4 003265db ce483800 
00000246
codeman kernel: cb3e2c40 00005622 c011dbc0 cb3e2c40 cb3e2000 cb3e2000 c02e7430 
c02e7430
codeman kernel: 003265b4 c3926ca0 c011db28 c02e6e80 d51d717a cb3e2000 cb084a00 
c534cc00

Did not occur with 2.5.38!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
