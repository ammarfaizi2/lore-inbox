Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSJNJfV>; Mon, 14 Oct 2002 05:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263547AbSJNJfV>; Mon, 14 Oct 2002 05:35:21 -0400
Received: from [212.3.242.3] ([212.3.242.3]:27386 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S263544AbSJNJfT>;
	Mon, 14 Oct 2002 05:35:19 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.40] Oops fbcon
Date: Mon, 14 Oct 2002 12:35:51 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210141235.51638.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this oops while vi'ing a large file. Framebuffer is Neomagic.

Unable to handle kernel paging request at virtual address d0c81000
 printing eip:
c0241314
*pde = 0fe04067
*pte = 00000000
Oops: 0002
ipt_REDIRECT ipt_LOG ip_nat_ftp ip_conntrack_ftp iptable_filter ipt_MASQUERADE 
iptable_nat ip_conntrack ip_tables 3c59x serial_cs tun  
CPU:    0
EIP:    0060:[<c0241314>]    Not tainted
EFLAGS: 00010286
EIP is at cfb_copyarea+0x434/0x490
eax: ffffffff   ebx: d0c80fff   ecx: 00000004   edx: 00000000
esi: 00000008   edi: d0c78fff   ebp: d0c78fff   esp: cbed5ca0
ds: 0068   es: 0068   ss: 0068
Process lynx (pid: 279, threadinfo=cbed4000 task=cc174680)
Stack: 00000000 000009d0 00000030 00000400 d0c80fff 00000000 d0bc0fff 000000ff 
       00000030 ffffff00 ffffffff 00000003 00000400 00000286 c011dcb9 00000000 
       fffffc00 c024247c cfe09c00 cbed5d04 c03865c0 00000003 00000030 0000002d 
Call Trace:
 [<c011dcb9>]run_timer_tasklet+0x15/0x1c
 [<c024247c>]fbcon_accel_bmove+0x98/0xa4
 [<c023d16b>]fbcon_bmove_rec+0x183/0x18c
 [<c023cfde>]fbcon_bmove+0xe2/0xec
 [<c023c9b6>]fbcon_scroll+0x4d6/0xa1c
 [<c01e874b>]scrup+0x6b/0x104
 [<c01eaa76>]csi_M+0x4a/0x5c
 [<c01eb7d1>]do_con_trol+0x951/0xcb0
 [<c01ec0f8>]do_con_write+0x5c8/0x688
 [<c01ec6df>]con_write+0x1b/0x2c
 [<c01deb63>]opost_block+0x167/0x174
 [<c01e08af>]write_chan+0x163/0x208
 [<c0112d8c>]default_wake_function+0x0/0x34
 [<c0112d8c>]default_wake_function+0x0/0x34
 [<c01dc668>]tty_write+0x1dc/0x294
 [<c01e074c>]write_chan+0x0/0x208
 [<c013989d>]vfs_write+0xb1/0x130
 [<c0139982>]sys_write+0x2a/0x3c
 [<c0106f9f>]syscall_call+0x7/0xb

Code: 89 03 8b 54 24 20 03 6c 24 40 03 5c 24 40 89 5c 24 18 4a 89 
 

-- 
"It is easier for a camel to pass through the eye of a needle if it is
lightly greased."
		-- Kehlog Albran, "The Profit"

