Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRCPLBG>; Fri, 16 Mar 2001 06:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRCPLA4>; Fri, 16 Mar 2001 06:00:56 -0500
Received: from the.earth.li ([195.149.39.90]:42508 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id <S130446AbRCPLAq>;
	Fri, 16 Mar 2001 06:00:46 -0500
Date: Fri, 16 Mar 2001 10:59:55 +0000
From: Jonathan McDowell <noodles@earth.li>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19pre13 problems.
Message-ID: <20010316105955.C6153@earth.li>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Note I don't read l-k, so you'll need to CC me if you want me to
provide more info.]

Hi.

I've been having problems with 2.2.19pre13 with the ext2 compression
patch applied. I'd be inclined to say it's hardware problems or the ext2
compression patch, but I'd been running 2.2.17pre14 in the same
configuration on the same machine with about 200 days uptime and then
the sysctl bug was found and so I upgraded and since then I haven't had
more than about 10 days of uptime at once. I've upgraded to 2.2.19pre17
since last night, so I'll see if that proves any better.

J.

-- 
Web [                 Beware of exploding fridges.                 ]
site: http:// [                                          ]       Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.17

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops

ksymoops 2.3.4 on i686 2.2.19pre17.  Options used
     -v /usr/src/linux-2.2.19pre13/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.2.19pre13/ (specified)
     -m /boot/System.map-2.2.19pre13 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address e0cf7d4d
current->tss.cr3 = 04f00000, %cr3 = 04f00000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a9124>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: e0cf7d23   ebx: cbe4d000   ecx: 00000000   edx: cf443ae0
esi: cf443ae0   edi: 00000000   ebp: 00000000   esp: cd22bf38
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 10506, process nr: 101, stackpage=cd22b000)
Stack: 00000005 c012f0c7 cf443ae0 00000000 00000004 00000001 ca87f8d8 00000000 
       00000020 00000145 cd22a000 00000000 00000000 c4d17000 c012f52d 00000006 
       cd22bfa8 cd22bfa4 cd22a000 00000000 bfffeee4 bfffeeec c0125a82 cd22bfa8 
Call Trace: [<c012f0c7>] [<c012f52d>] [<c0125a82>] [<c010a03c>] 
Code: 66 8b 40 2a 85 db 75 1c 68 7e 2c 1f c0 25 ff ff 00 00 50 e8 

>>EIP; c01a9124 <tty_poll+14/98>   <=====
Trace; c012f0c7 <do_select+10f/204>
Trace; c012f52d <sys_select+371/498>
Trace; c0125a82 <sys_read+be/dc>
Trace; c010a03c <system_call+34/38>
Code;  c01a9124 <tty_poll+14/98>
00000000 <_EIP>:
Code;  c01a9124 <tty_poll+14/98>   <=====
   0:   66 8b 40 2a               mov    0x2a(%eax),%ax   <=====
Code;  c01a9128 <tty_poll+18/98>
   4:   85 db                     test   %ebx,%ebx
Code;  c01a912a <tty_poll+1a/98>
   6:   75 1c                     jne    24 <_EIP+0x24> c01a9148 <tty_poll+38/98>
Code;  c01a912c <tty_poll+1c/98>
   8:   68 7e 2c 1f c0            push   $0xc01f2c7e
Code;  c01a9131 <tty_poll+21/98>
   d:   25 ff ff 00 00            and    $0xffff,%eax
Code;  c01a9136 <tty_poll+26/98>
  12:   50                        push   %eax
Code;  c01a9137 <tty_poll+27/98>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c01a913c <tty_poll+2c/98>

Unable to handle kernel paging request at virtual address e0cf7d93
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0130120>]
EFLAGS: 00010286
eax: e0cf7d23   ebx: cf443ae0   ecx: 00000000   edx: e0cf7d23
esi: 00000000   edi: cf7b99e1   ebp: e0cf7d93   esp: cd22be18
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 10506, process nr: 101, stackpage=cd22b000)
Stack: cf7b99e1 c3bcac60 e0cf7d23 c011af68 c324d000 c4f00bfc 00000001 c011aabd 
       00000019 00000032 c011ab5d 00000000 bfffa000 ce24f8c0 00000286 ce24f8c0 
       cd22a000 cd22befc e0cf7d4d 00000300 ce24f93c c01256b9 cf443ae0 c3bcac60 
Call Trace: [<c011af68>] [<c011aabd>] [<c011ab5d>] [<c01256b9>] [<c0117d69>] [<c010a574>] [<c01e01ca>] 
       [<c01e172e>] [<c010f91e>] [<c01e172e>] [<c010f638>] [<c010a155>] [<c01a9124>] [<c012f0c7>] [<c012f52d>] 
       [<c0125a82>] [<c010a03c>] 
Code: 8b 72 70 85 f6 74 62 90 f6 46 24 01 74 52 8b 54 24 64 39 56 

>>EIP; c0130120 <locks_remove_posix+20/94>   <=====
Trace; c011af68 <zap_page_range+144/1c4>
Trace; c011aabd <check_pgt_cache+11/18>
Trace; c011ab5d <clear_page_tables+99/a4>
Trace; c01256b9 <filp_close+51/64>
Trace; c0117d69 <do_exit+139/274>
Trace; c010a574 <die_if_no_fixup+0/44>
Trace; c01e01ca <error_table+84e/1e5c>
Trace; c01e172e <error_table+1db2/1e5c>
Trace; c010f91e <do_page_fault+2e6/3e8>
Trace; c01e172e <error_table+1db2/1e5c>
Trace; c010f638 <do_page_fault+0/3e8>
Trace; c010a155 <error_code+35/40>
Trace; c01a9124 <tty_poll+14/98>
Trace; c012f0c7 <do_select+10f/204>
Trace; c012f52d <sys_select+371/498>
Trace; c0125a82 <sys_read+be/dc>
Trace; c010a03c <system_call+34/38>
Code;  c0130120 <locks_remove_posix+20/94>
00000000 <_EIP>:
Code;  c0130120 <locks_remove_posix+20/94>   <=====
   0:   8b 72 70                  mov    0x70(%edx),%esi   <=====
Code;  c0130123 <locks_remove_posix+23/94>
   3:   85 f6                     test   %esi,%esi
Code;  c0130125 <locks_remove_posix+25/94>
   5:   74 62                     je     69 <_EIP+0x69> c0130189 <locks_remove_posix+89/94>
Code;  c0130127 <locks_remove_posix+27/94>
   7:   90                        nop    
Code;  c0130128 <locks_remove_posix+28/94>
   8:   f6 46 24 01               testb  $0x1,0x24(%esi)
Code;  c013012c <locks_remove_posix+2c/94>
   c:   74 52                     je     60 <_EIP+0x60> c0130180 <locks_remove_posix+80/94>
Code;  c013012e <locks_remove_posix+2e/94>
   e:   8b 54 24 64               mov    0x64(%esp,1),%edx
Code;  c0130132 <locks_remove_posix+32/94>
  12:   39 56 00                  cmp    %edx,0x0(%esi)

Unable to handle kernel paging request at virtual address 8feae870
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01befb0>]
EFLAGS: 00010046
eax: 8feae800   ebx: cfead7a0   ecx: cfea0806   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c009e200   esp: c021bdb4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c021b000)
Stack: c04cbc00 c01bf103 00000002 00000000 c04cbc00 c009e200 9c73882f 9c73882f 
       cbc8cd5c ce758580 c016df3e cfebf8c0 cbc8ccc0 cbc8ccc0 c016dff4 cbc8ccc0 
       0000001b c021be48 c017c8ca cbc8ccc0 c3b520b0 ce2d482e c01f3499 ce33a1e0 
Call Trace: [<c01bf103>] [<c016df3e>] [<c016dff4>] [<c017c8ca>] [<c01f3499>] [<c0160035>] [<c018bfbb>] 
       [<c01be4c2>] [<c01beba5>] [<c01bebbd>] [<c01bd50e>] [<c01c3ab3>] [<c01cd514>] [<c010b0e2>] [<c010ae97>] 
       [<c0118d41>] [<c010b1f7>] [<d0000044>] [<c010aedc>] [<d0000044>] [<c01087dd>] [<c0106000>] [<c0108800>] 
       [<c010a03c>] [<c0106000>] [<d0000044>] [<c010607b>] [<c0106000>] [<c0100175>] 
Code: f6 40 70 01 0f 85 1a 01 00 00 f6 43 54 01 74 34 f6 43 52 04 

>>EIP; c01befb0 <do_sd_request+9c/1c4>   <=====
Trace; c01bf103 <requeue_sd_request+2b/fc0>
Trace; c016df3e <kfree_skbmem+32/44>
Trace; c016dff4 <__kfree_skb+a4/ac>
Trace; c017c8ca <tcp_clean_rtx_queue+12a/140>
Trace; c01f3499 <twist_table.462+5b9/82f>
Trace; c0160035 <nfs3_xdr_mkdirargs+39/21c>
Trace; c018bfbb <ip_fw_check+277/500>
Trace; c01be4c2 <end_scsi_request+12e/138>
Trace; c01beba5 <rw_intr+3c1/730>
Trace; c01bebbd <rw_intr+3d9/730>
Trace; c01bd50e <scsi_old_done+5de/5ec>
Trace; c01c3ab3 <aic7xxx_done_cmds_complete+2b/38>
Trace; c01cd514 <do_aic7xxx_isr+58/74>
Trace; c010b0e2 <handle_IRQ_event+36/6c>
Trace; c010ae97 <do_8259A_IRQ+7f/ac>
Trace; c0118d41 <do_bottom_half+49/64>
Trace; c010b1f7 <do_IRQ+23/40>
Trace; d0000044 <END_OF_CODE+fdbbe74/????>
Trace; c010aedc <common_interrupt+18/20>
Trace; d0000044 <END_OF_CODE+fdbbe74/????>
Trace; c01087dd <cpu_idle+61/70>
Trace; c0106000 <get_options+0/74>
Trace; c0108800 <sys_idle+14/24>
Trace; c010a03c <system_call+34/38>
Trace; c0106000 <get_options+0/74>
Trace; d0000044 <END_OF_CODE+fdbbe74/????>
Trace; c010607b <cpu_idle+7/18>
Trace; c0106000 <get_options+0/74>
Trace; c0100175 <L6+0/2>
Code;  c01befb0 <do_sd_request+9c/1c4>
00000000 <_EIP>:
Code;  c01befb0 <do_sd_request+9c/1c4>   <=====
   0:   f6 40 70 01               testb  $0x1,0x70(%eax)   <=====
Code;  c01befb4 <do_sd_request+a0/1c4>
   4:   0f 85 1a 01 00 00         jne    124 <_EIP+0x124> c01bf0d4 <do_sd_request+1c0/1c4>
Code;  c01befba <do_sd_request+a6/1c4>
   a:   f6 43 54 01               testb  $0x1,0x54(%ebx)
Code;  c01befbe <do_sd_request+aa/1c4>
   e:   74 34                     je     44 <_EIP+0x44> c01beff4 <do_sd_request+e0/1c4>
Code;  c01befc0 <do_sd_request+ac/1c4>
  10:   f6 43 52 04               testb  $0x4,0x52(%ebx)

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing



Unable to handle kernel paging request at virtual address 85fffff2
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0112382>]
EFLAGS: 00010082
eax: 00000000   ebx: 85fffff2   ecx: 7530b07d   edx: c020890c
esi: 85fffff2   edi: c0208ba0   ebp: c021bf48   esp: c021bf38
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c021b000)
Stack: 00000000 c0208ba0 00000001 00000000 c021bf60 c0118d41 00000000 c021a000 
       003a2ae2 c010b20d d0000044 c010aedc 00000000 c021a000 00000000 c021a000 
       003a2ae2 d0000044 00000000 00000018 c0210018 ffffff00 c01087dd 00000010 
Call Trace: [<c0118d41>] [<c010b20d>] [<d0000044>] [<c010aedc>] [<d0000044>] [<c01087dd>] [<c0106000>] 
       [<c0108800>] [<c010a03c>] [<c0106000>] [<d0000044>] [<c010607b>] [<c0106000>] [<c0100175>] 
Code: 8b 36 8b 4b 08 89 ca 2b 15 a8 90 20 c0 a1 80 88 22 c0 85 c0 

>>EIP; c0112382 <timer_bh+14e/3a8>   <=====
Trace; c0118d41 <do_bottom_half+49/64>
Trace; c010b20d <do_IRQ+39/40>
Trace; d0000044 <END_OF_CODE+fdbbe74/????>
Trace; c010aedc <common_interrupt+18/20>
Trace; d0000044 <END_OF_CODE+fdbbe74/????>
Trace; c01087dd <cpu_idle+61/70>
Trace; c0106000 <get_options+0/74>
Trace; c0108800 <sys_idle+14/24>
Trace; c010a03c <system_call+34/38>
Trace; c0106000 <get_options+0/74>
Trace; d0000044 <END_OF_CODE+fdbbe74/????>
Trace; c010607b <cpu_idle+7/18>
Trace; c0106000 <get_options+0/74>
Trace; c0100175 <L6+0/2>
Code;  c0112382 <timer_bh+14e/3a8>
00000000 <_EIP>:
Code;  c0112382 <timer_bh+14e/3a8>   <=====
   0:   8b 36                     mov    (%esi),%esi   <=====
Code;  c0112384 <timer_bh+150/3a8>
   2:   8b 4b 08                  mov    0x8(%ebx),%ecx
Code;  c0112387 <timer_bh+153/3a8>
   5:   89 ca                     mov    %ecx,%edx
Code;  c0112389 <timer_bh+155/3a8>
   7:   2b 15 a8 90 20 c0         sub    0xc02090a8,%edx
Code;  c011238f <timer_bh+15b/3a8>
   d:   a1 80 88 22 c0            mov    0xc0228880,%eax
Code;  c0112394 <timer_bh+160/3a8>
  12:   85 c0                     test   %eax,%eax

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

--LpQ9ahxlCli8rRTG--
