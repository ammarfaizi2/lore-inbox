Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131208AbRCKGO4>; Sun, 11 Mar 2001 01:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbRCKGOp>; Sun, 11 Mar 2001 01:14:45 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:46086 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S131208AbRCKGO3>;
	Sun, 11 Mar 2001 01:14:29 -0500
Date: Sat, 10 Mar 2001 22:14:27 -0800
From: David Raufeisen <david@fortyoz.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3pre1: kernel BUG at page_alloc.c:73!
Message-ID: <20010310221427.A5415@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mar 10 21:34:30 prototype kernel: kernel BUG at page_alloc.c:73!
Mar 10 21:34:30 prototype kernel: invalid operand: 0000
Mar 10 21:34:30 prototype kernel: CPU:    0
Mar 10 21:34:30 prototype kernel: EIP:    0010:[__free_pages_ok+34/784]
Mar 10 21:34:30 prototype kernel: EFLAGS: 00013082
Mar 10 21:34:30 prototype kernel: eax: 0000001f   ebx: c14285d0   ecx: c3642000   edx: c7839380
Mar 10 21:34:30 prototype kernel: esi: cfa70000   edi: 0000001f   ebp: 00000003   esp: c3643c68
Mar 10 21:34:30 prototype kernel: ds: 0018   es: 0018   ss: 0018
Mar 10 21:34:30 prototype kernel: Process X (pid: 6847, stackpage=c3643000)
Mar 10 21:34:30 prototype kernel: Stack: c021c565 c021c6f3 00000049 ffffffff cfa70000 0000001f c3643cbc c0112c37 
Mar 10 21:34:30 prototype kernel:        cda57000 c88ce837 cda57000 e0000000 c012af3a c012af64 c88ce933 cda1d004 
Mar 10 21:34:30 prototype kernel:        c51aea40 c0044646 03050000 c3643cd0 c3643cd0 c3643cd0 c88d6dc4 cfa70000 
Mar 10 21:34:30 prototype kernel: Call Trace: [<cfa70000>] [iounmap+23/32] [<cda57000>] [NVdriver:osUnmapKernelSpace+67/76] [<cda57000>] [<e0000000>] [__free_pages+26/32] 
Mar 10 21:34:30 prototype kernel:        [free_pages+36/48] [NVdriver:osFreeContigPages+79/84] [<cda1d004>] [NVdriver:RmTeardownAGP+156/176] [<cfa70000>] [NVdriver:nv_devices+0/384] [NVdriver:nvExtEscape+2888/3100] [<
cda1d004>] 
Mar 10 21:34:30 prototype kernel:        [<cda1d004>] [<cda1d004>] [NVdriver:_nv_rmsym_01225+71/104] [<cda1d004>] [<cda21308>] [<cda212c8>] [NVdriver:_nv_rmsym_01425+446/468] [<cda1d004>]
Mar 10 21:34:30 prototype kernel:        [<cda212c8>] [<cda1d004>] [NVdriver:_nv_rmsym_00560+222/432] [<cda1d004>] [<cda1d004>] [NVdriver:nv_devices+0/384] [<cda1d004>] [<cda1d004>] 
Mar 10 21:34:30 prototype kernel:        [alloc_skb+230/384] [sock_def_readable+38/80] [<cda22028>] [<cda1d004>] [<cda1d004>] [NVdriver:_nv_rmsym_00958+116/168] [<cda1d004>] [<cda1d004>] 
Mar 10 21:34:30 prototype kernel:        [NVdriver:_nv_rmsym_00345+0/204] [<cda1d004>] [NVdriver:_nv_rmsym_01083+293/776] [<cda1d004>] [<cda1d004>] [NVdriver:nv_ioctl+449/480] [NVdriver:nv_devices+0/384] [__run_task_q
ueue+76/96] 
Mar 10 21:34:30 prototype kernel:        [<cda1d004>] [NVdriver:nv_bottom_halves+0/2560] [NVdriver:nv_bottom_halves+0/2560] [schedule+614/912] [sys_ioctl+359/384] [system_call+51/56]
Mar 10 21:34:30 prototype kernel: 
Mar 10 21:34:30 prototype kernel: Code: 0f 0b 83 c4 0c 83 7b 08 00 74 16 6a 4b 68 f3 c6 21 c0 68 65

Linux prototype 2.4.3-pre1 #1 Sun Mar 4 14:14:54 PST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.58
Kbd                    command
Sh-utils               2.0.11
Modules Loaded         NVdriver

reiserfs is the filesystem.. machine is athlon thunderbird 800mhz.

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
