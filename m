Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282123AbRKWLcv>; Fri, 23 Nov 2001 06:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282125AbRKWLcl>; Fri, 23 Nov 2001 06:32:41 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:58540 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S282123AbRKWLcb>; Fri, 23 Nov 2001 06:32:31 -0500
Date: Fri, 23 Nov 2001 12:32:29 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre8 Oops (also in 2.4.15 too) (i810_audio probably)
Message-ID: <20011123123229.A21037@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


ksymoops 2.4.3 on i686 2.4.15-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre8/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol __rta_fill_R__ver___rta_fill not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol neigh_add_R__ver_neigh_add not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol neigh_delete_R__ver_neigh_delete not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol neigh_dump_info_R__ver_neigh_dump_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol rtattr_parse_R__ver_rtattr_parse not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol rtnetlink_dump_ifinfo_R__ver_rtnetlink_dump_ifinfo not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol rtnetlink_links_R__ver_rtnetlink_links not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol rtnetlink_put_metrics_R__ver_rtnetlink_put_metrics not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol rtnl_R__ver_rtnl not found in System.map.  Ignoring ksyms_base entry
Nov 23 04:02:03 videotest kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Nov 23 04:02:03 videotest kernel: c0114393
Nov 23 04:02:03 videotest kernel: *pde = 00000000
Nov 23 04:02:03 videotest kernel: Oops: 0000
Nov 23 04:02:03 videotest kernel: CPU:    0
Nov 23 04:02:03 videotest kernel: EIP:    0010:[__wake_up+51/192]    Not tainted
Nov 23 04:02:03 videotest kernel: EIP:    0010:[<c0114393>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 23 04:02:03 videotest kernel: EFLAGS: 00210016
Nov 23 04:02:03 videotest kernel: eax: cf09ef0c   ebx: cfe07380   ecx: 00000001   edx: cfd96400
Nov 23 04:02:03 videotest kernel: esi: cf09eed0   edi: cf09ef08   ebp: c6e57f1c   esp: c6e57f04
Nov 23 04:02:03 videotest kernel: ds: 0018   es: 0018   ss: 0018
Nov 23 04:02:03 videotest kernel: Process realproducer (pid: 2498, stackpage=c6e57000)
Nov 23 04:02:03 videotest kernel: Stack: 00000001 00200082 00000003 0000a3c0 cf09eed0 00010000 00008000 d08f1ccd 
Nov 23 04:02:03 videotest kernel:        cd21a740 00000014 00000000 cf09eea0 cf09eed0 ce4bc5e0 bfffeeb8 cf09eea0 
Nov 23 04:02:03 videotest kernel:        d08f32ef cf09eea0 00200001 c73644a0 00000000 00000000 00000001 cfd96400 
Nov 23 04:02:03 videotest kernel: Call Trace: [e100:__insmod_e100_O/lib/modules/2.4.15-pre8/kernel/drivers/net/+-254771/96] [e100:__insmod_e100_O/lib/modules/2.4.15-pre8/kernel/drivers/net/+-249105/96] [sys_select+1138/1152] [sys_socketcall+315/512] [sys_ioctl+455/512] 
Nov 23 04:02:03 videotest kernel: Call Trace: [<d08f1ccd>] [<d08f32ef>] [<c0141f92>] [<c01c4d2b>] [<c0140ff7>] 
Nov 23 04:02:03 videotest kernel:    [<c0106f1b>] 
Nov 23 04:02:03 videotest kernel: Code: 8b 01 85 45 f0 74 66 31 c0 9c 5e fa f0 fe 0d 00 f8 2a c0 0f 

>>EIP; c0114392 <__wake_up+32/c0>   <=====
Trace; d08f1ccc <[i810_audio]i810_update_ptr+ec/230>
Trace; d08f32ee <[i810_audio]i810_ioctl+a1e/10a0>
Trace; c0141f92 <sys_select+472/480>
Trace; c01c4d2a <sys_socketcall+13a/200>
Trace; c0140ff6 <sys_ioctl+1c6/200>
Trace; c0106f1a <system_call+32/38>
Code;  c0114392 <__wake_up+32/c0>
00000000 <_EIP>:
Code;  c0114392 <__wake_up+32/c0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0114394 <__wake_up+34/c0>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c0114396 <__wake_up+36/c0>
   5:   74 66                     je     6d <_EIP+0x6d> c01143fe <__wake_up+9e/c0>
Code;  c0114398 <__wake_up+38/c0>
   7:   31 c0                     xor    %eax,%eax
Code;  c011439a <__wake_up+3a/c0>
   9:   9c                        pushf  
Code;  c011439c <__wake_up+3c/c0>
   a:   5e                        pop    %esi
Code;  c011439c <__wake_up+3c/c0>
   b:   fa                        cli    
Code;  c011439e <__wake_up+3e/c0>
   c:   f0 fe 0d 00 f8 2a c0      lock decb 0xc02af800
Code;  c01143a4 <__wake_up+44/c0>
  13:   0f 00 00                  sldt   (%eax)


9 warnings issued.  Results may not be reliable.

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
