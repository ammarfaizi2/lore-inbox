Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbTF2RoY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 13:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265717AbTF2RoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 13:44:24 -0400
Received: from web10901.mail.yahoo.com ([216.136.131.37]:22812 "HELO
	web10901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265716AbTF2RoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 13:44:18 -0400
Message-ID: <20030629175836.64302.qmail@web10901.mail.yahoo.com>
Date: Sun, 29 Jun 2003 10:58:36 -0700 (PDT)
From: Ned Ren <nedren@yahoo.com>
Subject: HELP! Mysterious oops around PIPE code, kernel 2.4.18
To: linux-kernel@vger.kernel.org
Cc: nedren@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel gurus,

I am running out of ideas about this problem. Our system keeps crashing near the pipe code
(pipe_write, pipe_release etc), even within some very innocent system calls like date or grep. I
have found a thread mentioning gcc bug and we have recompiled the kernel using both gcc-2.95 and
gcc-3.3 (on redhat 9) but didn't help.

If I should provide more info please write to me: nedren@yahoo.com

Thank you very much for your time!


lsmod:
Module                  Size  Used by    Tainted: P
mod_led                 2352   0
ip_ids                  7040   0  (unused)
ipsec                 147872   0
eepro100               19992   2  (autoclean)       

uname:
Linux Firewall-2 2.4.18-18.7.xcustom #3 Fri Jun 27 13:53:41 PDT 2003 i686 unknown     

Oops:

Sun Jun 29 02:25:01 2003 localhost  kernel: Unable to handle kernel paging request at virtual
address 3031206d(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Oops: 0000(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: EIP:0010:[__wake_up+35/96] at __wake_up+0x23/60
EFLAGS: 00010083(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: eax:ddd7a8e0  ebx:ddd7a160  ecx:00000001  edx:3031206d
 esi:ddd7a8e0(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: edi:00000001  ebp:dd923f68  esp:dd923f54  ds:0018 
es:0018  ss:0018(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Process date (pid: 30704, stackpage=dd923000)(Sun Jun
29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Stack: (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel:        00000001 00000282 df3c4d80 ddd7a8e0 fffffff2
00000000 c013d022 00001000 (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel:        0000000b dd810000 00000000 df3c4dec 0000000b
0000000b 40013000 ddd2c840 (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel:        ffffffea 0000000b c01348f5 ddd2c840 4001300b
0000000b ddd2c860 dd922000 (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Call Trace: [pipe_write+370/704] pipe_write+0x172/2c0
(0xdd923f6c)(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: [sys_write+133/256] sys_write+0x85/100
(0xdd923f9c)(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xdd923fc0)(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Code: 8b 02 85 c7 75 17 8b 1b 39 f3 75 f1 ff 75 f0 9d
8d 65 f4 5b (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Oops: 0002(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: EIP:0010:[remove_wait_queue+10/32] at
remove_wait_queue+0xa/20 EFLAGS: 00010046(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: eax:ddd7a8e0  ebx:00000246  ecx:00000000  edx:ddc2bf58
 esi:ddc2a000(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: edi:df3c4d80  ebp:ddc2bf58  esp:ddc2bf40  ds:0018 
es:0018  ss:0018(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Process sync_ntp.sh (pid: 30700,
stackpage=ddc2b000)(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Stack: (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel:        df3c4dec c013cc78 00000000 ddc2a000 00000000
00000000 00000000 ddc2a000 (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel:        ddd7a8e0 00000000 df3c4d80 fffffe00 ddd7a8e0
00000080 c013cd52 df3c4d80 (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel:        ddc2a000 df3c4dec 00000000 080a32e0 ddd2c4c0
ffffffea 00000080 c01347f5 (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Call Trace: [pipe_wait+136/176] pipe_wait+0x88/b0
(0xddc2bf44)(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: [pipe_read+178/528] pipe_read+0xb2/210
(0xddc2bf78)(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: [sys_read+133/256] sys_read+0x85/100 (0xddc2bf9c)(Sun
Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xddc2bfc0)(Sun Jun 29 02:25:01 2003 )
Sun Jun 29 02:25:01 2003 localhost  kernel: Code: 89 01 89 48 04 53 9d 5b c3 8d b6 00 00 00 00 8d
bc 27 00 00 (Sun Jun 29 02:25:01 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: Oops: 0000(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: EIP:0010:[pipe_read+119/528] at pipe_read+0x77/210
EFLAGS: 00010246(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: eax:00000000  ebx:dfc21c00  ecx:dfc21c6c  edx:dea5f660
 esi:fffffe00(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: edi:00000000  ebp:00008000  esp:ddf3df80  ds:0018 
es:0018  ss:0018(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: Process grep (pid: 2987, stackpage=ddf3d000)(Sun Jun
29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: Stack: (Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel:        11800005 dfc21c6c 00000000 08059000 dea5f660
ffffffea 00008000 c01347f5 (Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel:        dea5f660 08059000 00008000 dea5f680 ddf3c000
00000000 00000000 bffffdb8 (Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel:        c0108c03 00000000 08059000 00008000 00000000
00000000 bffffdb8 00000003 (Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: Call Trace: [sys_read+133/256] sys_read+0x85/100
(0xddf3df9c)(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xddf3dfc0)(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: Code: 8b 47 0c 85 c0 75 74 8b 47 18 31 f6 85 c0 74 59
8b 44 24 20 (Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: Oops: 0000(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: EIP:0010:[__wake_up+35/96] at __wake_up+0x23/60
EFLAGS: 00010006(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: eax:ddd7a460  ebx:de1c6000  ecx:00000001  edx:00001063
 esi:ddd7a460(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:00 2003 localhost  kernel: edi:00000001  ebp:dd61df24  esp:dd61df10  ds:0018 
es:0018  ss:0018(Sun Jun 29 03:12:00 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Process sh (pid: 2981, stackpage=dd61d000)(Sun Jun 29
03:12:00 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Stack: (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel:        00000001 00000286 ddd7a460 dfb65e4c dfb65de0
dea2b2a0 c013d2ae df035760 (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel:        c2413260 dfb65de0 c013d30e dfb65de0 00000000
00000001 c0135519 dfb65de0 (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel:        df035760 df035760 df5b9a60 00000000 00000001
c0133fa7 df035760 df5b9a60 (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Call Trace: [pipe_release+94/144] pipe_release+0x5e/90
(0xdd61df28)(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [pipe_write_release+14/32] pipe_write_release+0xe/20
(0xdd61df38)(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [fput+217/256] fput+0xd9/100 (0xdd61df48)(Sun Jun 29
03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [filp_close+55/96] filp_close+0x37/60 (0xdd61df64)(Sun
Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [put_files_struct+87/176] put_files_struct+0x57/b0
(0xdd61df84)(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [do_exit+180/576] do_exit+0xb4/240 (0xdd61dfa0)(Sun
Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [sys_exit+15/16] sys_exit+0xf/10 (0xdd61dfb8)(Sun Jun
29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xdd61dfc0)(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Code: 8b 02 85 c7 75 17 8b 1b 39 f3 75 f1 ff 75 f0 9d
8d 65 f4 5b (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Oops: 0000(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: EIP:0010:[pipe_read+119/528] at pipe_read+0x77/210
EFLAGS: 00010246(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: eax:00000000  ebx:df541dc0  ecx:df541e2c  edx:de3d9ba0
 esi:fffffe00(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: edi:00000000  ebp:00008000  esp:dda11f80  ds:0018 
es:0018  ss:0018(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Process grep (pid: 2989, stackpage=dda11000)(Sun Jun
29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Stack: (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel:        11800005 df541e2c 00000000 08059000 de3d9ba0
ffffffea 00008000 c01347f5 (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel:        de3d9ba0 08059000 00008000 de3d9bc0 dda10000
00000000 00000000 bffffdb8 (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel:        c0108c03 00000000 08059000 00008000 00000000
00000000 bffffdb8 00000003 (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Call Trace: [sys_read+133/256] sys_read+0x85/100
(0xdda11f9c)(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xdda11fc0)(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Code: 8b 47 0c 85 c0 75 74 8b 47 18 31 f6 85 c0 74 59
8b 44 24 20 (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Oops: 0000(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: EIP:0010:[pipe_read+119/528] at pipe_read+0x77/210
EFLAGS: 00010246(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: eax:00000000  ebx:dfb650e0  ecx:dfb6514c  edx:deb76da0
 esi:fffffe00(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: edi:00000000  ebp:00001000  esp:dd77bf80  ds:0018 
es:0018  ss:0018(Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:01 2003 localhost  kernel: Process awk (pid: 2990, stackpage=dd77b000)(Sun Jun 29
03:12:01 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Stack: (Sun Jun 29 03:12:01 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel:        df9376c0 dfb6514c 00000000 080734f8 deb76da0
ffffffea 00001000 c01347f5 (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel:        deb76da0 080734f8 00001000 deb76dc0 dd77a000
080734f8 0806f620 bffffdec (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel:        c0108c03 00000000 080734f8 00001000 080734f8
0806f620 bffffdec 00000003 (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Call Trace: [sys_read+133/256] sys_read+0x85/100
(0xdd77bf9c)(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xdd77bfc0)(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Code: 8b 47 0c 85 c0 75 74 8b 47 18 31 f6 85 c0 74 59
8b 44 24 20 (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Oops: 0000(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: EIP:0010:[__wake_up+35/96] at __wake_up+0x23/60
EFLAGS: 00010006(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: eax:ddd7a460  ebx:de1c6000  ecx:00000001  edx:00001063
 esi:ddd7a460(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: edi:00000001  ebp:dd727f24  esp:dd727f10  ds:0018 
es:0018  ss:0018(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Process debuglog.sh (pid: 2979,
stackpage=dd727000)(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Stack: (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel:        00000001 00000286 ddd7a460 dec8926c dec89200
df53f2e0 c013d2ae de35f7c0 (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel:        c2413260 dec89200 c013d30e dec89200 00000000
00000001 c0135519 dec89200 (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel:        de35f7c0 de35f7c0 df5ba300 00000000 00000001
c0133fa7 de35f7c0 df5ba300 (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Call Trace: [pipe_release+94/144] pipe_release+0x5e/90
(0xdd727f28)(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [pipe_write_release+14/32] pipe_write_release+0xe/20
(0xdd727f38)(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [fput+217/256] fput+0xd9/100 (0xdd727f48)(Sun Jun 29
03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [filp_close+55/96] filp_close+0x37/60 (0xdd727f64)(Sun
Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [put_files_struct+87/176] put_files_struct+0x57/b0
(0xdd727f84)(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [do_exit+180/576] do_exit+0xb4/240 (0xdd727fa0)(Sun
Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [sys_exit+15/16] sys_exit+0xf/10 (0xdd727fb8)(Sun Jun
29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xdd727fc0)(Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:12:02 2003 localhost  kernel: Code: 8b 02 85 c7 75 17 8b 1b 39 f3 75 f1 ff 75 f0 9d
8d 65 f4 5b (Sun Jun 29 03:12:02 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Oops: 0000(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: EIP:0010:[pipe_read+119/528] at pipe_read+0x77/210
EFLAGS: 00010246(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: eax:00000000  ebx:df9cfc80  ecx:df9cfcec  edx:de35f6c0
 esi:fffffe00(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: edi:00000000  ebp:00008000  esp:de079f80  ds:0018 
es:0018  ss:0018(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Process grep (pid: 4906, stackpage=de079000)(Sun Jun
29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Stack: (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel:        11800005 df9cfcec 00000000 08059000 de35f6c0
ffffffea 00008000 c01347f5 (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel:        de35f6c0 08059000 00008000 de35f6e0 de078000
00000000 00000000 bffffdb8 (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel:        c0108c03 00000000 08059000 00008000 00000000
00000000 bffffdb8 00000003 (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Call Trace: [sys_read+133/256] sys_read+0x85/100
(0xde079f9c)(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xde079fc0)(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Code: 8b 47 0c 85 c0 75 74 8b 47 18 31 f6 85 c0 74 59
8b 44 24 20 (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Oops: 0000(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: EIP:0010:[pipe_release+31/144] at pipe_release+0x1f/90
EFLAGS: 00010246(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: eax:00000000  ebx:de3d9ca0  ecx:df6765ac  edx:00000000
 esi:df6765ac(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: edi:df676540  ebp:df53f7e0  esp:de10df2c  ds:0018 
es:0018  ss:0018(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Process vss_control.sh (pid: 4932,
stackpage=de10d000)(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Stack: (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel:        de3d9ca0 c2413260 df676540 c013d30e df676540
00000000 00000001 c0135519 (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel:        df676540 de3d9ca0 de3d9ca0 de4423a0 00000000
00000001 c0133fa7 de3d9ca0 (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel:        de4423a0 de3d9ca0 de4423a0 00000003 00000001
de4423a0 c01172a7 de3d9ca0 (Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Call Trace: [pipe_write_release+14/32]
pipe_write_release+0xe/20 (0xde10df38)(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: [fput+217/256] fput+0xd9/100 (0xde10df48)(Sun Jun 29
03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: [filp_close+55/96] filp_close+0x37/60 (0xde10df64)(Sun
Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: [put_files_struct+87/176] put_files_struct+0x57/b0
(0xde10df84)(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: [do_exit+180/576] do_exit+0xb4/240 (0xde10dfa0)(Sun
Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: [sys_exit+15/16] sys_exit+0xf/10 (0xde10dfb8)(Sun Jun
29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: [system_call+51/64] system_call+0x33/40
(0xde10dfc0)(Sun Jun 29 03:32:01 2003 )
Sun Jun 29 03:32:01 2003 localhost  kernel: Code: 8b 5a 14 29 c3 89 5a 14 8b 97 e8 00 00 00 8b 44
24 18 8b 4a (Sun Jun 29 03:32:01 2003 )



__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
