Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSLOSow>; Sun, 15 Dec 2002 13:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSLOSow>; Sun, 15 Dec 2002 13:44:52 -0500
Received: from [213.171.53.133] ([213.171.53.133]:30989 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S262373AbSLOSov>;
	Sun, 15 Dec 2002 13:44:51 -0500
Date: Sun, 15 Dec 2002 21:53:42 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <192267038701.20021215215342@wr.miee.ru>
To: kernelnewbies@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: [2.5.5(01)]oops when catting info from /proc/bus/pnp/escd
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=> cat /proc/bus/pnp/escd
Then this oops.
Unable to handle kernel paging request at virtual address ffffa00a
=> Could someone explain me in a few words what does it mean "unable
=> to handle..." or point me on docs?
Dec 16 22:35:06 cubloid-pc kernel:  printing eip:
Dec 16 22:35:06 cubloid-pc kernel: 00007768
Dec 16 22:35:06 cubloid-pc kernel: *pde = 00001063
Dec 16 22:35:06 cubloid-pc kernel: *pte = 00000000
Dec 16 22:35:06 cubloid-pc kernel: Oops: 0000
Dec 16 22:35:06 cubloid-pc kernel: CPU:    0
Dec 16 22:35:06 cubloid-pc kernel: EIP:    0088:[<00007768>]    Not tainted
Dec 16 22:35:06 cubloid-pc kernel: EFLAGS: 00010086
Dec 16 22:35:06 cubloid-pc kernel: EIP is at 0x7768
Dec 16 22:35:06 cubloid-pc kernel: eax: 000022ff   ebx: 00a06816   ecx: 00000090   edx: 00000000
Dec 16 22:35:06 cubloid-pc kernel: esi: 0000000a   edi: 00000000   ebp: c202790f   esp: c2027e80
Dec 16 22:35:06 cubloid-pc kernel: ds: 00a0   es: 0098   ss: 0068
Dec 16 22:35:06 cubloid-pc kernel: Process cat (pid: 130, threadinfo=c2026000 task=c25a06e0)
Dec 16 22:35:06 cubloid-pc kernel: Stack: 000a0006 00a00000 00060098 7919774a 00000000 658a0090 682f7eb4 00680000
Dec 16 22:35:06 cubloid-pc kernel:        00000068 66840042 00960098 c2027efc 0080000b 00000042 00a00098 00000090
Dec 16 22:35:06 cubloid-pc kernel:        00000000 c01d6f2c 00000060 00000082 00000000 00000000 00000068 00000068
Dec 16 22:35:06 cubloid-pc kernel: Call Trace:
Dec 16 22:35:06 cubloid-pc kernel:  [<c01d6f2c>] __pnp_bios_read_escd+0xe0/0x128
=> In this func "__pnp_bios_read_escd" error occured? I think so, am I
=> right?
Dec 16 22:35:06 cubloid-pc kernel:  [<c01d6f85>] pnp_bios_read_escd+0x11/0x34
Dec 16 22:35:06 cubloid-pc kernel:  [<c01d8002>] proc_read_escd+0x66/0xfc
Dec 16 22:35:06 cubloid-pc kernel:  [<c015c577>] proc_file_read+0xb7/0x178
Dec 16 22:35:06 cubloid-pc kernel:  [<c0139033>] vfs_read+0xa7/0x108
Dec 16 22:35:06 cubloid-pc kernel:  [<c013927e>] sys_read+0x2a/0x40
Dec 16 22:35:06 cubloid-pc kernel:  [<c0108a67>] syscall_call+0x7/0xb
Dec 16 22:35:06 cubloid-pc kernel:
Dec 16 22:35:06 cubloid-pc kernel: Code:  Bad EIP value.

=> cat /proc/bus/pnp/escd_info
min_ESCD_write_size 8192
ESCD_size 3776
NVRAM_base 0xffffa000
=> We get this adress from call to another BIOS function, but may be
=> we have to allocate page or something else I don't know exactly
=> what. But I want to know more about it. And any suggextions or
=> explanations will be very good.
Beforehead Thanks to All.
                  Ruslan.

