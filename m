Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbSLDQgp>; Wed, 4 Dec 2002 11:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSLDQgp>; Wed, 4 Dec 2002 11:36:45 -0500
Received: from zok.SGI.COM ([204.94.215.101]:28826 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S266849AbSLDQgl>;
	Wed, 4 Dec 2002 11:36:41 -0500
Message-ID: <064401c29bb4$1b7d99f0$ed1b0f86@dfksystems.com>
From: "Mark Waterhouse" <mwaterho@sgi.com>
To: <linux-kernel@vger.kernel.org>
Cc: <mw@sgi.com>
Subject: Kernel Error : Can you tell me whats causing it?
Date: Wed, 4 Dec 2002 16:42:11 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I've recently bought a new machine (from ebay!) and have installed RedHat
8.0 on it.

Its running Kernel-2.4.18-14 and was installed via RPM.

However, when running a very simple perl script, I get a segmentation fault
and the following lines appear in syslog (at bottom of mail).
The machine is doing nothing fancy .... its running a dhcp-client and
sendmail.

Is there something in the error messages which indicates where the fault
maybe?

Any help would be greatly appreciated.
Thanks
Mark Waterhouse

**********************

Dec  4 17:16:53 mtv-vpn-hw-mwaterho-1 kernel: kmod: runaway modprobe loop
assumed and stopped
Dec  4 17:16:53 mtv-vpn-hw-mwaterho-1 kernel: kmod: runaway modprobe loop
assumed and stopped
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: Unable to handle kernel paging
request at virtual address 88ff0003
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel:  printing eip:
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: c0119c24
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: *pde = 00000000
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: Oops: 0002
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: autofs ne 8390 eepro100
iptable_filter ip_tables mousedev keybdev hid input us
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: CPU:    0
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: EIP:    0010:[<c0119c24>]
Not tainted
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: EFLAGS: 00010246
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: EIP is at do_fork [kernel]
0x304 (2.4.18-14)
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: eax: 00000000   ebx: 00000011
ecx: cd2d9a58   edx: ffff0001
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: esi: fffffff4   edi: c1be3dc0
ebp: caa2a000   esp: ca85bf60
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: Process sh (pid: 3047,
stackpage=ca85b000)
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: Stack: 00000011 caa2a000
00000500 00000000 000000d1 00100077 c585f5d8 c585f5e0
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel:        c585f5c0 fffffff2
00000000 bffff800 c01251cc bffff800 ca85bfa0 ca85a000
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel:        bffff800 00000000
bffff918 c01078c7 00000011 bffff7ec ca85bfc4 00000000
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: Call Trace: [<c01251cc>]
sys_rt_sigprocmask [kernel] 0x11c (0xca85bf90))
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: [<c01078c7>] sys_fork [kernel]
0x27 (0xca85bfac))
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: [<c010910f>] system_call
[kernel] 0x33 (0xca85bfc0))
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:19 mtv-vpn-hw-mwaterho-1 kernel: Code: 0f 85 8a 02 00 00 89 1c
24 89 6c 24 04 e8 3a ed 03 00 85 c0
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel:  <1>Unable to handle kernel
paging request at virtual address 89000002
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel:  printing eip:
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: c0119c24
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: *pde = 00000000
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: Oops: 0002
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: autofs ne 8390 eepro100
iptable_filter ip_tables mousedev keybdev hid input us
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: CPU:    0
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: EIP:    0010:[<c0119c24>]
Not tainted
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: EFLAGS: 00010246
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: EIP is at do_fork [kernel]
0x304 (2.4.18-14)
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: eax: 00000000   ebx: 00000100
ecx: 00000000   edx: 00000000
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: esi: fffffff4   edi: c1be3a80
ebp: ce7fc000   esp: c61e1e58
Dec  4 17:35:21 mtv-vpn-hw-mwaterho-1 kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: Process sendmail (pid: 3058,
stackpage=c61e1000)
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: Stack: 00000100 ce7fc000
00000500 d0fa1600 d0fa3130 c01eb725 00000212 00000000
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel:        c13a4a70 0000004c
c01306a5 d0b2ee68 0000004c c1ccd6dc 00000093 c61e0000
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel:        c61e1ef0 00000001
bfffe4b8 c01078ff 00000100 c0128200 c61e1ebc 00000000
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: Call Trace: [<c01eb725>]
sk_free [kernel] 0x55 (0xc61e1e6c))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c01306a5>] filemap_nopage
[kernel] 0x1a5 (0xc61e1e80))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c01078ff>] sys_clone
[kernel] 0x2f (0xc61e1ea4))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c0128200>] exec_modprobe
[kernel] 0x0 (0xc61e1eac))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c010910f>] system_call
[kernel] 0x33 (0xc61e1eb8))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c0128200>] exec_modprobe
[kernel] 0x0 (0xc61e1ec0))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c0107445>] kernel_thread
[kernel] 0x25 (0xc61e1ee4))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c012834c>] request_module
[kernel] 0xac (0xc61e1ef8))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c0128200>] exec_modprobe
[kernel] 0x0 (0xc61e1efc))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c01e98c0>] sock_create
[kernel] 0xd0 (0xc61e1f28))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c01e993b>] sys_socket
[kernel] 0x2b (0xc61e1f64))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c01ea832>] sys_socketcall
[kernel] 0x72 (0xc61e1f80))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c01168c0>] do_page_fault
[kernel] 0x0 (0xc61e1fb0))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c0109200>] error_code
[kernel] 0x34 (0xc61e1fb8))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: [<c010910f>] system_call
[kernel] 0x33 (0xc61e1fc0))
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: Code: 0f 95 8a 02 00 00 89 1c
24 89 6c 24 04 e8 3a ed 03 00 85 c0
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel:  <1>Unable to handle kernel
paging request at virtual address 5b8d3002
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel:  printing eip:
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: c0119c24
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: *pde = 00000000
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: Oops: 0002
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: autofs ne 8390 eepro100
iptable_filter ip_tables mousedev keybdev hid input us
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: CPU:    0
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: EIP:    0010:[<c0119c24>]
Not tainted
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel: EFLAGS: 00010246
Dec  4 17:35:22 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: EIP is at do_fork [kernel]
0x304 (2.4.18-14)
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: eax: 00000000   ebx: 00000011
ecx: 00000000   edx: d28d3000
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: esi: fffffff4   edi: c1be37c0
ebp: ca85a000   esp: c87c3f60
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: Process go (pid: 2955,
stackpage=c87c3000)
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: Stack: 00000011 ca85a000
00000500 ffffffea 00000018 c017a75d c017e8b0 d0ed0000
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel:        c87c3f60 00000006
0000207d 00000018 c87c2000 00000000 c87c3fb0 c87c2000
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel:        00000000 0804d6f0
bffff808 c01078c7 00000011 bffff7ec c87c3fc4 00000000
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: Call Trace: [<c017a75d>]
tty_write [kernel] 0xfd (0xc87c3f74))
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: [<c017e8b0>] write_chan
[kernel] 0x0 (0xc87c3f78))
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: [<c01078c7>] sys_fork [kernel]
0x27 (0xc87c3fac))
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: [<c010910f>] system_call
[kernel] 0x33 (0xc87c3fc0))
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel:
Dec  4 17:35:23 mtv-vpn-hw-mwaterho-1 kernel: Code: 0f 95 8a 02 00 00 89 1c
24 89 6c 24 04 e8 3a ed 03 00 85 c0

