Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbQLWPXF>; Sat, 23 Dec 2000 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbQLWPWz>; Sat, 23 Dec 2000 10:22:55 -0500
Received: from proxy.ovh.net ([213.244.20.42]:2835 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S130155AbQLWPWo>;
	Sat, 23 Dec 2000 10:22:44 -0500
Message-ID: <3A44BBE5.94770873@ovh.net>
Date: Sat, 23 Dec 2000 15:51:17 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: oops 2.2.18 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.18 + 
VM-global-2.2.18pre25-7-to-2.2.18-1 + 
raid-2.2.18-A2-to-A3 +
raid1readbalance-2.2.15-B2-to-2.2.18-A0 +

ksymoops 2.3.4 on i686 2.2.18-ovh.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18-ovh/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000a90
current->tss.cr3 = 0fe86000, %cr3 = 0fe86000
*pde = 100dc067
Oops: 0002
CPU:    0
EIP:    0010:[<c011ea2b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 00000001   ebx: c01f39a0   ecx: ffffffff   edx: 00000000
esi: 0000a932   edi: 00005499   ebp: 00000206   esp: c4d73e3c
ds: 0018   es: 0018   ss: 0018
Process ncftpd (pid: 32299, process nr: 291, stackpage=c4d73000)
Stack: c06c8840 00000000 ffffffff c0118fd8 ccd56000 c4d73eb4 0000086f 00001004 
       ccd5607c df632860 ccd5607c c012e23b ccd56000 00000000 d807e8e4 c012e2b1 
       ccd56000 c4d73eb4 c4d73eb4 c01d4dc4 c012e530 c4d73eb4 00000000 c01f42a0 
Call Trace: [<c0118fd8>] [<c012e23b>] [<c012e2b1>] [<c012e530>] [<c012e57a>]
[<c012e8f1>] [<c012ea5e>] 
       [<c012ea7b>] [<c013d1d8>] [<c01287ab>] [<c0128aa0>] [<c0128b88>]
[<c012698a>] [<c0107940>] [<c010002b>] 
Code: 0f bb 3a 19 c0 85 c0 74 3a ff 4b 0c 8b 44 24 10 f7 d8 31 f0 

>>EIP; c011ea2b <__free_pages+b7/120>   <=====
Trace; c0118fd8 <truncate_inode_pages+a4/13c>
Trace; c012e23b <clear_inode+13/70>
Trace; c012e2b1 <dispose_list+19/50>
Trace; c012e530 <try_to_free_inodes+e4/108>
Trace; c012e57a <grow_inodes+1e/180>
Trace; c012e8f1 <get_new_inode+b9/124>
Trace; c012ea5e <iget4+6e/78>
Trace; c012ea7b <iget+13/18>
Trace; c013d1d8 <ext2_lookup+54/7c>
Trace; c01287ab <real_lookup+4f/a0>
Trace; c0128aa0 <lookup_dentry+128/1e8>
Trace; c0128b88 <__namei+28/58>
Trace; c012698a <sys_newlstat+e/60>
Trace; c0107940 <system_call+34/38>
Trace; c010002b <startup_32+2b/11d>
Code;  c011ea2b <__free_pages+b7/120>
00000000 <_EIP>:
Code;  c011ea2b <__free_pages+b7/120>   <=====
   0:   0f bb 3a                  btc    %edi,(%edx)   <=====
Code;  c011ea2e <__free_pages+ba/120>
   3:   19 c0                     sbb    %eax,%eax
Code;  c011ea30 <__free_pages+bc/120>
   5:   85 c0                     test   %eax,%eax
Code;  c011ea32 <__free_pages+be/120>
   7:   74 3a                     je     43 <_EIP+0x43> c011ea6e
<__free_pages+fa/120>
Code;  c011ea34 <__free_pages+c0/120>
   9:   ff 4b 0c                  decl   0xc(%ebx)
Code;  c011ea37 <__free_pages+c3/120>
   c:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c011ea3b <__free_pages+c7/120>
  10:   f7 d8                     neg    %eax
Code;  c011ea3d <__free_pages+c9/120>
  12:   31 f0                     xor    %esi,%eax

................Unable to handle kernel NULL pointer dereference at virtual
address 00000000
current->tss.cr3 = 0fe86000, %cr3 = 0fe86000
*pde = 100dc067
Oops: 0000
CPU:    0
EIP:    0010:[<c011ebbe>]
EFLAGS: 00010086
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: c01f39a0   edi: 000036a8   ebp: 00000000   esp: c4d739dc
ds: 0018   es: 0018   ss: 0018
Process ncftpd (pid: 32299, process nr: 291, stackpage=c4d73000)
Stack: dffef1a0 00000286 00000000 00000000 00000202 00000000 c011d0d9 dffef1a8 
       dffef1a0 00000008 00000286 c01d81e0 00000246 00000003 00000008 00000020 
       00000000 c011d733 dffef1a0 00000008 d93f70e0 000000a0 00000008 c4cfe000 
Call Trace: [<c011d0d9>] [<c011d733>] [<c014a88d>] [<c014a037>] [<c015c1bd>]
[<c0154460>] [<c015e60e>] 
       [<c015e653>] [<c015e980>] [<c0168e5b>] [<c01c4fd0>] [<c0149b07>]
[<c014bec0>] [<c01546a5>] [<c01549a9>] 
       [<c015b275>] [<c015cb6c>] [<c014a92a>] [<c014a9d9>] [<c015a6b3>]
[<c015f217>] [<c015f48f>] [<c015f4ee>] 
       [<c015239a>] [<c0152681>] [<c014c20d>] [<c01151d9>] [<c0108e27>]
[<c0108af4>] [<c0107e5f>] [<c01ac596>] 
       [<c01adfee>] [<c010d40c>] [<c01adfee>] [<c0108ad1>] [<c0107a51>]
[<c011ea2b>] [<c0118fd8>] [<c012e23b>] 
       [<c012e2b1>] [<c012e530>] [<c012e57a>] [<c012e8f1>] [<c012ea5e>]
[<c012ea7b>] [<c013d1d8>] [<c01287ab>] 
       [<c0128aa0>] [<c0128b88>] [<c012698a>] [<c0107940>] [<c010002b>] 
Code: 8b 45 00 89 06 89 70 04 89 e8 2b 05 4c 34 1d c0 8d 04 40 89 

>>EIP; c011ebbe <__get_free_pages+102/2b4>   <=====
Trace; c011d0d9 <kmem_cache_grow+fd/374>
Trace; c011d733 <kmalloc+ef/15c>
Trace; c014a88d <alloc_skb+71/dc>
Trace; c014a037 <sock_wmalloc+23/50>
Trace; c015c1bd <tcp_make_synack+41/378>
Trace; c0154460 <ip_build_and_send_pkt+1cc/1dc>
Trace; c015e60e <tcp_v4_send_synack+4a/108>
Trace; c015e653 <tcp_v4_send_synack+8f/108>
Trace; c015e980 <tcp_v4_conn_request+290/354>
Trace; c0168e5b <ipfw_output_check+5f/64>
Trace; c01c4fd0 <twist_table.460+5b0/89a>
Trace; c0149b07 <call_out_firewall+37/50>
Trace; c014bec0 <dev_queue_xmit+20/bc>
Trace; c01546a5 <ip_output+85/a8>
Trace; c01549a9 <ip_queue_xmit+2e1/3a8>
Trace; c015b275 <tcp_transmit_skb+3d9/3e4>
Trace; c015cb6c <tcp_reset_xmit_timer+7c/9c>
Trace; c014a92a <kfree_skbmem+32/40>
Trace; c014a9d9 <__kfree_skb+a1/a8>
Trace; c015a6b3 <tcp_rcv_state_process+63/84c>
Trace; c015f217 <tcp_v4_do_rcv+117/140>
Trace; c015f48f <tcp_v4_rcv+24f/334>
Trace; c015f4ee <tcp_v4_rcv+2ae/334>
Trace; c015239a <ip_local_deliver+16a/1b8>
Trace; c0152681 <ip_rcv+299/2c8>
Trace; c014c20d <net_bh+181/1dc>
Trace; c01151d9 <do_bottom_half+45/64>
Trace; c0108e27 <do_IRQ+3b/40>
Trace; c0108af4 <common_interrupt+18/20>
Trace; c0107e5f <die+33/38>
Trace; c01ac596 <stext_lock+11c2/2d2c>
Trace; c01adfee <stext_lock+2c1a/2d2c>
Trace; c010d40c <do_page_fault+2c4/3b0>
Trace; c01adfee <stext_lock+2c1a/2d2c>
Trace; c0108ad1 <do_8259A_IRQ+9d/a8>
Trace; c0107a51 <error_code+2d/34>
Trace; c011ea2b <__free_pages+b7/120>
Trace; c0118fd8 <truncate_inode_pages+a4/13c>
Trace; c012e23b <clear_inode+13/70>
Trace; c012e2b1 <dispose_list+19/50>
Trace; c012e530 <try_to_free_inodes+e4/108>
Trace; c012e57a <grow_inodes+1e/180>
Trace; c012e8f1 <get_new_inode+b9/124>
Trace; c012ea5e <iget4+6e/78>
Trace; c012ea7b <iget+13/18>
Trace; c013d1d8 <ext2_lookup+54/7c>
Trace; c01287ab <real_lookup+4f/a0>
Trace; c0128aa0 <lookup_dentry+128/1e8>
Trace; c0128b88 <__namei+28/58>
Trace; c012698a <sys_newlstat+e/60>
Trace; c0107940 <system_call+34/38>
Trace; c010002b <startup_32+2b/11d>
Code;  c011ebbe <__get_free_pages+102/2b4>
00000000 <_EIP>:
Code;  c011ebbe <__get_free_pages+102/2b4>   <=====
   0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
Code;  c011ebc1 <__get_free_pages+105/2b4>
   3:   89 06                     mov    %eax,(%esi)
Code;  c011ebc3 <__get_free_pages+107/2b4>
   5:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c011ebc6 <__get_free_pages+10a/2b4>
   8:   89 e8                     mov    %ebp,%eax
Code;  c011ebc8 <__get_free_pages+10c/2b4>
   a:   2b 05 4c 34 1d c0         sub    0xc01d344c,%eax
Code;  c011ebce <__get_free_pages+112/2b4>
  10:   8d 04 40                  lea    (%eax,%eax,2),%eax
Code;  c011ebd1 <__get_free_pages+115/2b4>
  13:   89 00                     mov    %eax,(%eax)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
