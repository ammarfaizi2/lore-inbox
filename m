Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSGVLEu>; Mon, 22 Jul 2002 07:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSGVLEt>; Mon, 22 Jul 2002 07:04:49 -0400
Received: from [196.26.86.1] ([196.26.86.1]:25561 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316739AbSGVLEq>; Mon, 22 Jul 2002 07:04:46 -0400
Date: Mon, 22 Jul 2002 13:25:32 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: "David S. Miller" <davem@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.27] Oops in tcp_v6_get_port
Message-ID: <Pine.LNX.4.44.0207221324530.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Arnaldo

I get this whenever i run some X11 app from the 2.5.27 box and then ssh 
in from the X server. It seems to sometimes take a while but is reproducible.

Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c02ed9e9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02ed9e9>]    Not tainted
EFLAGS: 00010202
eax: 0000000a   ebx: cf5f8380   ecx: 00000010   edx: 00000000
esi: cf5f8380   edi: 00000010   ebp: ce9dddbc   esp: cdbf9e84
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 728, threadinfo=cdbf8000 task=ceb48060)
Stack: c5ef3c48 c5ef3f30 0100007f 00000011 00000000 000003a0 cf5f7e00 cf5a19e0
       0000177a c5ef3be0 c5ef3f20 c5ef3f30 c5ef3d34 c02d56f4 c4ef3be0 0000177a
       00000000 c5ef3c00 0000177a 00000011 0600007f cdbf9f00 ce93c644 cdbf9f00
Call Trace: [<c02d56f4>] [<c028a5ff>] [<c02896ba>] [<c028a3e3>] [<c0126176>]
   [<c012634c>] [<c028a43d>] [<c01075db>] [<c01075db>]

Code: f3 a6 0f 97 c2 0f 92 c0 38 c2 74 2c 81 7c 24 0c 00 10 00 00
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

>>EIP; c02ed9e9 <tcp_v6_get_port+339/4e0>   <=====
Trace; c02d56f4 <inet6_bind+4c4/740>
Trace; c028a5ff <sys_bind+4f/70>
Trace; c02896ba <sock_map_fd+10a/120>
Trace; c028a3e3 <sock_create+f3/120>
Trace; c0126176 <update_wall_time+16/50>
Trace; c012634c <timer_bh+5c/400>
Trace; c028a43d <sys_socket+2d/50>
Trace; c01075db <syscall_call+7/b>
Trace; c01075db <syscall_call+7/b>
Code;  c02ed9e9 <tcp_v6_get_port+339/4e0>
00000000 <_EIP>:
Code;  c02ed9e9 <tcp_v6_get_port+339/4e0>   <=====
   0:   f3 a6                     repz cmpsb %es:(%edi),%ds:(%esi)   <=====
Code;  c02ed9eb <tcp_v6_get_port+33b/4e0>
   2:   0f 97 c2                  seta   %dl
Code;  c02ed9ee <tcp_v6_get_port+33e/4e0>
   5:   0f 92 c0                  setb   %al
Code;  c02ed9f1 <tcp_v6_get_port+341/4e0>
   8:   38 c2                     cmp    %al,%dl
Code;  c02ed9f3 <tcp_v6_get_port+343/4e0>
   a:   74 2c                     je     38 <_EIP+0x38> c02eda21 <tcp_v6_get_port+371/4e0>
Code;  c02ed9f5 <tcp_v6_get_port+345/4e0>
   c:   81 7c 24 0c 00 10 00      cmpl   $0x1000,0xc(%esp,1)
Code;  c02ed9fc <tcp_v6_get_port+34c/4e0>
  13:   00


-- 
function.linuxpower.ca

