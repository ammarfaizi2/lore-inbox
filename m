Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRCXApR>; Fri, 23 Mar 2001 19:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRCXApJ>; Fri, 23 Mar 2001 19:45:09 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:49870 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131429AbRCXAo7>; Fri, 23 Mar 2001 19:44:59 -0500
To: linux-kernel@vger.kernel.org
Subject: [Panic] 2.4.2ac22
Message-Id: <20010324004416.E03FE35D77@oscar.casa.dyndns.org>
Date: Fri, 23 Mar 2001 19:44:16 -0500 (EST)
From: root@casa.dyndns.org (root)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yet another one.  This time with all the traceback entries...

Ed

ksymoops 2.3.7 on i586 2.4.2-ac22.  Options used
     -V (default)
     -k 20010323183444.ksyms (specified)
     -l 20010323183444.modules (specified)
     -o /lib/modules/2.4.2-ac22/ (default)
     -m /boot/System.map-2.4.2-ac22 (default)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): snd symbol pm_register not found in /usr/lib/alsa-modules/2.4.2-ac22/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.2-ac22/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in /usr/lib/alsa-modules/2.4.2-ac22/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.2-ac22/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in /usr/lib/alsa-modules/2.4.2-ac22/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.2-ac22/0.5/snd.o entry
8139too Fast Ethernet driver 0.9.15 loaded
Unable to handle kernel paging request at virtual address 0000ef1f
c01b2b53
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b2b53>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: d1ce1b00   ebx: 0000ef1f   ecx: 00000000   edx: 0000ef1f
esi: c8fd25a0   edi: d1ce1ba0   ebp: 00000060   esp: c0227de0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0227000)
Stack: 00000100 c01b2bfb c8fd25a0 00000100 c8fd25a0 c01b310a c8fd25a0 c8fd25a0 
       d3eae800 d1a122a0 d3eae800 c01b589a c8fd25a0 00000002 c6b4b160 c8fd25a0 
       c01b8973 c8fd25a0 c8fd25a0 00000000 00000004 c01c268c c01c2705 c8fd25a0 
Call Trace: [<c01b2bfb>] [<c01b310a>] [<c01b589a>] [<c01b8973>] [<c01c268c>] [<c01c2705>] [<c01ba937>] 
       [<c01bff2c>] [<c01c2672>] [<c01c268c>] [<c01bff7a>] [<c01ba937>] [<c01bfed8>] [<c01bff2c>] [<c01bf200>] 
       [<c01bf34f>] [<c01bf200>] [<c01ba937>] [<c01bf075>] [<c01bf200>] [<c01b5e2b>] [<c0117510>] [<c010a172>] 
       [<c01071f0>] [<c0108e80>] [<c01071f0>] [<c0107213>] [<c0107277>] [<c0105000>] [<c0100191>] 
Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09 

>>EIP; c01b2b53 <skb_drop_fraglist+17/3c>   <=====
Trace; c01b2bfb <skb_release_data+5f/70>
Trace; c01b310a <skb_linearize+7e/e0>
Trace; c01b589a <dev_queue_xmit+26/1e0>
Trace; c01b8973 <neigh_resolve_output+103/174>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01c2705 <ip_finish_output2+79/b4>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bff2c <ip_forward_finish+0/54>
Trace; c01c2672 <ip_finish_output+de/e4>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01bff7a <ip_forward_finish+4e/54>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bfed8 <ip_forward+188/1dc>
Trace; c01bff2c <ip_forward_finish+0/54>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01bf34f <ip_rcv_finish+14f/180>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bf075 <ip_rcv+309/340>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01b5e2b <net_rx_action+13b/218>
Trace; c0117510 <do_softirq+40/64>
Trace; c010a172 <do_IRQ+a2/b0>
Trace; c01071f0 <default_idle+0/28>
Trace; c0108e80 <ret_from_intr+0/20>
Trace; c01071f0 <default_idle+0/28>
Trace; c0107213 <default_idle+23/28>
Trace; c0107277 <cpu_idle+3f/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c01b2b53 <skb_drop_fraglist+17/3c>
00000000 <_EIP>:
Code;  c01b2b53 <skb_drop_fraglist+17/3c>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01b2b55 <skb_drop_fraglist+19/3c>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c01b2b58 <skb_drop_fraglist+1c/3c>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c01b2b5b <skb_drop_fraglist+1f/3c>
   8:   74 0a                     je     14 <_EIP+0x14> c01b2b67 <skb_drop_fraglist+2b/3c>
Code;  c01b2b5d <skb_drop_fraglist+21/3c>
   a:   ff 4a 70                  decl   0x70(%edx)
Code;  c01b2b60 <skb_drop_fraglist+24/3c>
   d:   0f 94 c0                  sete   %al
Code;  c01b2b63 <skb_drop_fraglist+27/3c>
  10:   84 c0                     test   %al,%al
Code;  c01b2b65 <skb_drop_fraglist+29/3c>
  12:   74 09                     je     1d <_EIP+0x1d> c01b2b70 <skb_drop_fraglist+34/3c>

 <0>Kernel panic: Aiee, killing interrupt handler!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111d7d>]
EFLAGS: 00010282
eax: 00000018   ebx: c0227bac   ecx: c9da8000   edx: c0213a44
esi: c9226c60   edi: c0226000   ebp: c0227b98   esp: c0227b70
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0227000)
Stack: c01eab96 c0227bac c9226c60 c0226000 c01177a4 c0280a60 c0227bac c9226c60 
       00000000
Call Trace: [<c01177a4>] [<c012daaa>] [<d682f284>] [<c0164bde>] [<d682f2b8>] [<d682f2ac>] [<c01685db>] 
       [<d682f284>] [<d68528a0>] [<c016753d>] [<c0159185>] [<c0131406>] [<c012dcb7>] [<c0187b9a>] [<c0187c24>] 
       [<c0113aae>] [<c011645b>] [<c0109329>] [<c0111438>] [<c011112c>] [<d6ab4000>] [<c01bae03>] [<c01b595e>] 
       [<d6a08ab6>] [<c0108f04>] [<c01b2b53>] [<c01b2bfb>] [<c01b310a>] [<c01b589a>] [<c01b8973>] [<c01c268c>] 
       [<c01c2705>] [<c01ba937>] [<c01bff2c>] [<c01c2672>] [<c01c268c>] [<c01bff7a>] [<c01ba937>] [<c01bfed8>] 
       [<c01bff2c>] [<c01bf200>] [<c01bf34f>] [<c01bf200>] [<c01ba937>] [<c01bf075>] [<c01bf200>] [<c01b5e2b>] 
       [<c0117510>] [<c010a172>] [<c01071f0>] [<c0108e80>] [<c01071f0>] [<c0107213>] [<c0107277>] [<c0105000>] 
       [<c0100191>] 
Code: 0f 0b 8d 65 dc 5b 5e 5f c9 c3 90 55 89 e5 83 ec 10 57 56 53 

>>EIP; c0111d7d <schedule+339/344>   <=====
Trace; c01177a4 <__run_task_queue+4c/68>
Trace; c012daaa <__wait_on_buffer+6a/8c>
Trace; d682f284 <[lvm-mod].bss.end+1f5f9/14f3d5>
Trace; c0164bde <flush_commit_list+26e/384>
Trace; d682f2b8 <[lvm-mod].bss.end+1f62d/14f3d5>
Trace; d682f2ac <[lvm-mod].bss.end+1f621/14f3d5>
Trace; c01685db <do_journal_end+743/9f0>
Trace; d682f284 <[lvm-mod].bss.end+1f5f9/14f3d5>
Trace; d68528a0 <[lvm-mod].bss.end+42c15/14f3d5>
Trace; c016753d <flush_old_commits+191/1b0>
Trace; c0159185 <reiserfs_write_super+15/20>
Trace; c0131406 <sync_supers+76/ac>
Trace; c012dcb7 <fsync_dev+17/30>
Trace; c0187b9a <go_sync+106/118>
Trace; c0187c24 <do_emergency_sync+78/a4>
Trace; c0113aae <panic+ce/d0>
Trace; c011645b <do_exit+27/1b0>
Trace; c0109329 <die+4d/50>
Trace; c0111438 <do_page_fault+30c/444>
Trace; c011112c <do_page_fault+0/444>
Trace; d6ab4000 <[8139too]__module_parm_full_duplex+134e/33ae>
Trace; c01bae03 <qdisc_restart+13/c8>
Trace; c01b595e <dev_queue_xmit+ea/1e0>
Trace; d6a08ab6 <[ipchains]ip_fw_check+4b6/59c>
Trace; c0108f04 <error_code+34/40>
Trace; c01b2b53 <skb_drop_fraglist+17/3c>
Trace; c01b2bfb <skb_release_data+5f/70>
Trace; c01b310a <skb_linearize+7e/e0>
Trace; c01b589a <dev_queue_xmit+26/1e0>
Trace; c01b8973 <neigh_resolve_output+103/174>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01c2705 <ip_finish_output2+79/b4>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bff2c <ip_forward_finish+0/54>
Trace; c01c2672 <ip_finish_output+de/e4>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01bff7a <ip_forward_finish+4e/54>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bfed8 <ip_forward+188/1dc>
Trace; c01bff2c <ip_forward_finish+0/54>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01bf34f <ip_rcv_finish+14f/180>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bf075 <ip_rcv+309/340>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01b5e2b <net_rx_action+13b/218>
Trace; c0117510 <do_softirq+40/64>
Trace; c010a172 <do_IRQ+a2/b0>
Trace; c01071f0 <default_idle+0/28>
Trace; c0108e80 <ret_from_intr+0/20>
Trace; c01071f0 <default_idle+0/28>
Trace; c0107213 <default_idle+23/28>
Trace; c0107277 <cpu_idle+3f/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c0111d7d <schedule+339/344>
00000000 <_EIP>:
Code;  c0111d7d <schedule+339/344>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0111d7f <schedule+33b/344>
   2:   8d 65 dc                  lea    0xffffffdc(%ebp),%esp
Code;  c0111d82 <schedule+33e/344>
   5:   5b                        pop    %ebx
Code;  c0111d83 <schedule+33f/344>
   6:   5e                        pop    %esi
Code;  c0111d84 <schedule+340/344>
   7:   5f                        pop    %edi
Code;  c0111d85 <schedule+341/344>
   8:   c9                        leave  
Code;  c0111d86 <schedule+342/344>
   9:   c3                        ret    
Code;  c0111d87 <schedule+343/344>
   a:   90                        nop    
Code;  c0111d88 <__wake_up+0/a0>
   b:   55                        push   %ebp
Code;  c0111d89 <__wake_up+1/a0>
   c:   89 e5                     mov    %esp,%ebp
Code;  c0111d8b <__wake_up+3/a0>
   e:   83 ec 10                  sub    $0x10,%esp
Code;  c0111d8e <__wake_up+6/a0>
  11:   57                        push   %edi
Code;  c0111d8f <__wake_up+7/a0>
  12:   56                        push   %esi
Code;  c0111d90 <__wake_up+8/a0>
  13:   53                        push   %ebx

 <0>Kernel panic: Aiee, killing interrupt handler!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111d7d>]
EFLAGS: 00010282
eax: 00000018   ebx: c0226000   ecx: c9da8000   edx: c0213a44
esi: c0227a18   edi: c0226000   ebp: c02279f4   esp: c02279cc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0227000)
Stack: c01eab96 c0226000 c0227a18 d3761400 0000001c 0000321e c025c660 0000321e 
       00000000 c0227a18 c0227b98 c0131375 d3761400 d3761448 00003a01 00000000 
       c0226000 00000000 00000000 00000000 c0226000 d3761438 d3761438 c01313d5 
Call Trace: [<c0131375>] [<c01313d5>] [<c012dcb7>] [<c0187b24>] [<c0187c24>] [<c0113aae>] [<c011645b>] 
       [<c0109538>] [<c0109329>] [<c01095be>] [<c0111d7d>] [<c01825b3>] [<c0180b8a>] [<c0113de9>] [<c0113e4b>] 
       [<c0108f04>] [<c0111d7d>] [<c01177a4>] [<c012daaa>] [<d682f284>] [<c0164bde>] [<d682f2b8>] [<d682f2ac>] 
       [<c01685db>] [<d682f284>] [<d68528a0>] [<c016753d>] [<c0159185>] [<c0131406>] [<c012dcb7><2c0109329>] [<c0111438>] [<c011112c>] [<d6ab4000>] [<c01bae03>] 
       [<c01b595e>] [<d6a08ab6>] [<c0108f04>] [<c01b2b53>] [<c01b2bfb>] [<c01b310a>] [<c01b589a>] [<c01b8973>] 
       [<c01c268c>] [<c01c2705>] [<c01ba937>] [<c01bff2c>] [<c01c2672>] [<c01c268c>] [<c01bff7a>] [<c01ba937>] 
       [<c01bfed8>] [<c01bff2c>] [<c01bf200>] [<c01bf34f>] [<c01bf200>] [<c01ba937>] [<c01bf075>] [<c01bf200>] 
       [<c01b5e2b>] [<c0117510>] [<c010a172>] [<c01071f0>] [<c0108e80>] [<c01071f0>] [<c0107213>] [<c0107277>] 
       [<c0105000>] [<c0100191>] 
Code: 0f 0b 8d 65 dc 5b 5e 5f c9 c3 90 55 89 e5 83 ec 10 57 56 53 

>>EIP; c0111d7d <schedule+339/344>   <=====
Trace; c0131375 <__wait_on_super+79/94>
Trace; c01313d5 <sync_supers+45/ac>
Trace; c012dcb7 <fsync_dev+17/30>
Trace; c0187b24 <go_sync+90/118>
Trace; c0187c24 <do_emergency_sync+78/a4>
Trace; c0113aae <panic+ce/d0>
Trace; c011645b <do_exit+27/1b0>
Trace; c0109538 <do_invalid_op+0/90>
Trace; c0109329 <die+4d/50>
Trace; c01095be <do_invalid_op+86/90>
Trace; c0111d7d <schedule+339/344>
Trace; c01825b3 <serial_in+13/34>
Trace; c0180b8a <vt_console_print+76/2e4>
Trace; c0113de9 <__call_console_drivers+39/48>
Trace; c0113e4b <_call_console_drivers+53/58>
Trace; c0108f04 <error_code+34/40>
Trace; c0111d7d <schedule+339/344>
Trace; c01177a4 <__run_task_queue+4c/68>
Trace; c012daaa <__wait_on_buffer+6a/8c>
Trace; d682f284 <[lvm-mod].bss.end+1f5f9/14f3d5>
Trace; c0164bde <flush_commit_list+26e/384>
Trace; d682f2b8 <[lvm-mod].bss.end+1f62d/14f3d5>
Trace; d682f2ac <[lvm-mod].bss.end+1f621/14f3d5>
Trace; c01685db <do_journal_end+743/9f0>
Trace; d682f284 <[lvm-mod].bss.end+1f5f9/14f3d5>
Trace; d68528a0 <[lvm-mod].bss.end+42c15/14f3d5>
Trace; c016753d <flush_old_commits+191/1b0>
Trace; c0159185 <reiserfs_write_super+15/20>
Trace; c0131406 <sync_supers+76/ac>
Trace; c012dcb7 <fsync_dev+17/30>
Trace; 2c0109329 <END_OF_CODE+1e761deea/????>
Trace; c0111438 <do_page_fault+30c/444>
Trace; c011112c <do_page_fault+0/444>
Trace; d6ab4000 <[8139too]__module_parm_full_duplex+134e/33ae>
Trace; c01bae03 <qdisc_restart+13/c8>
Trace; c01b595e <dev_queue_xmit+ea/1e0>
Trace; d6a08ab6 <[ipchains]ip_fw_check+4b6/59c>
Trace; c0108f04 <error_code+34/40>
Trace; c01b2b53 <skb_drop_fraglist+17/3c>
Trace; c01b2bfb <skb_release_data+5f/70>
Trace; c01b310a <skb_linearize+7e/e0>
Trace; c01b589a <dev_queue_xmit+26/1e0>
Trace; c01b8973 <neigh_resolve_output+103/174>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01c2705 <ip_finish_output2+79/b4>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bff2c <ip_forward_finish+0/54>
Trace; c01c2672 <ip_finish_output+de/e4>
Trace; c01c268c <ip_finish_output2+0/b4>
Trace; c01bff7a <ip_forward_finish+4e/54>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bfed8 <ip_forward+188/1dc>
Trace; c01bff2c <ip_forward_finish+0/54>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01bf34f <ip_rcv_finish+14f/180>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01ba937 <nf_hook_slow+e3/124>
Trace; c01bf075 <ip_rcv+309/340>
Trace; c01bf200 <ip_rcv_finish+0/180>
Trace; c01b5e2b <net_rx_action+13b/218>
Trace; c0117510 <do_softirq+40/64>
Trace; c010a172 <do_IRQ+a2/b0>
Trace; c01071f0 <default_idle+0/28>
Trace; c0108e80 <ret_from_intr+0/20>
Trace; c01071f0 <default_idle+0/28>
Trace; c0107213 <default_idle+23/28>
Trace; c0107277 <cpu_idle+3f/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c0111d7d <schedule+339/344>
00000000 <_EIP>:
Code;  c0111d7d <schedule+339/344>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0111d7f <schedule+33b/344>
   2:   8d 65 dc                  lea    0xffffffdc(%ebp),%esp
Code;  c0111d82 <schedule+33e/344>
   5:   5b                        pop    %ebx
Code;  c0111d83 <schedule+33f/344>
   6:   5e                        pop    %esi
Code;  c0111d84 <schedule+340/344>
   7:   5f                        pop    %edi
Code;  c0111d85 <schedule+341/344>
   8:   c9                        leave  
Code;  c0111d86 <schedule+342/344>
   9:   c3                        ret    
Code;  c0111d87 <schedule+343/344>
   a:   90                        nop    
Code;  c0111d88 <__wake_up+0/a0>
   b:   55                        push   %ebp
Code;  c0111d89 <__wake_up+1/a0>
   c:   89 e5                     mov    %esp,%ebp
Code;  c0111d8b <__wake_up+3/a0>
   e:   83 ec 10                  sub    $0x10,%esp
Code;  c0111d8e <__wake_up+6/a0>
  11:   57                        push   %edi
Code;  c0111d8f <__wake_up+7/a0>
  12:   56                        push   %esi
Code;  c0111d90 <__wake_up+8/a0>
  13:   53                        push   %ebx

 <0>Kernel panic: Aiee, killing interrupt handler!

4 warnings issued.  Results may not be reliable.
