Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKMXY5>; Mon, 13 Nov 2000 18:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbQKMXYr>; Mon, 13 Nov 2000 18:24:47 -0500
Received: from mail.inconnect.com ([209.140.64.7]:37272 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S129103AbQKMXYj>; Mon, 13 Nov 2000 18:24:39 -0500
Date: Mon, 13 Nov 2000 15:54:37 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: <linux-kernel@vger.kernel.org>
Subject: APM oops with Dell 5000e laptop
In-Reply-To: <200011132234.OAA03249@baldur.yggdrasil.com>
Message-ID: <Pine.SOL.4.30.0011131537460.27682-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just got a Sceptre 6950 (also known as a Dell 5000e), I just installed
Red Hat 7.0 on it, and got an APM related oops at boot.

I found that this was reported on l-k in late September with a couple
responses, but no resolution.

Here are a couple detailed bug reports on this same problem, again with no
response.

http://linuxcare.com.au/cgi-bin/apm/incoming?id=90
http://linuxcare.com.au/cgi-bin/apm/incoming?id=91

Here is what got in /var/log/messages, I'm willing to try suggested fixes,
etc.  The problem also happens with the 2.4 test kernels.

general protection fault: ea3c
CPU:    0
EIP:    0050:[<00003319>]
EFLAGS: 00010046
eax: 0000ffff   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: 000000ff   edi: ffff0014   ebp: c78b1ea4   esp: c78b1ea4
ds: 0058   es: 0000   ss: 0018
Process apmd (pid: 342, process nr: 10, stackpage=c78b1000)
Stack: 00000058 00ffffff 1eb80050 00000001 530a0000 00000016 00485c5f 00000000
       c78b1f28 c01078f2 00000010 c78b1f28 ffffffff c64e0018 00000018 c01d8b51
       000000ff ffffffff ffffffff 00000286 ffff0000 c64e0000 c0107ae6 0000530a
Call Trace: [apm_bios_call+58/120] [error_table+1009/9344] [apm_get_power_status+42/100] [apm_get_info+58/248] [proc_file_read+154/468] [sys_read+174/196] [system_call+52/56]
Code: <1>Unable to handle kernel paging request at virtual address 00003319
current->tss.cr3 = 05fe0000, %%cr3 = 05fe0000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[show_registers+653/704]
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: 00003319   edx: c76ca000
esi: 0000002b   edi: c78b2000   ebp: c8000000   esp: c78b1df4
ds: 0018   es: 0018   ss: 0018
Process apmd (pid: 342, process nr: 10, stackpage=c78b1000)
Stack: ffff0014 c78b1ea4 c02490c2 000000ff ffff0014 c78b1ea4 0000ffff 00000001
       00000000 00000000 00003319 00010046 0000331a c8800000 c010a470 c78b1e68
       c01d91a7 c01d927c 0000ea3c c78b1e68 c010a974 c01d927c c78b1e68 0000ea3c
Call Trace: [<c8800000>] [die+48/56] [error_table+2631/9344] [error_table+2844/9344] [do_general_protection+108/116] [error_table+2844/9344] [error_code+45/56]
[apm_bios_call+58/120] [error_table+1009/9344] [apm_get_power_status+42/100] [apm_get_info+58/248] [proc_file_read+154/468] [sys_read+174/196] [system_call+52/56]
Code: 8a 04 0b 89 44 24 38 50 68 9f 91 1d c0 e8 f5 9b 00 00 83 c4


Dax Kelson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
