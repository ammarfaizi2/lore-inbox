Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSJNGiU>; Mon, 14 Oct 2002 02:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261906AbSJNGiT>; Mon, 14 Oct 2002 02:38:19 -0400
Received: from mail.spylog.com ([194.67.35.220]:13523 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S261900AbSJNGiR>;
	Mon, 14 Oct 2002 02:38:17 -0400
Date: Mon, 14 Oct 2002 10:43:59 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: kernel oops in 2.4.20-pre10aa1
Message-ID: <20021014064359.GA14826@an.local>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kernel 2.4.20-pre10aa1, 1CPU (no SMP), 2Gb RAM.


$ bin/ksymoops 
ksymoops 2.4.7 on i686 2.4.20-pre10aa1h.  Options used
...
No modules in ksyms, skipping objects
No ksyms, skipping lsmod

EIP:    0010:[<e0113fca>]    Not tainted
EFLAGS: 00010007
eax: 0000008c   ebx: e0307524   ecx: 00000000   edx: e0307520
esi: e43d6000   edi: ffffffd9   ebp: e43d7f50   esp: e43d7f3c
ds: 0018   es: 0018   ss: 0018
Process layers-dbg (pid: 974, stackpage=e43d7000)
Stack: e43d6000 e0307998 e43d6000 e43d7fb8 e43d6000 e43d7f58 e01140fc e43d7f9c 
       e0106fd7 e43d6000 e43d602c e3ccc02c e0307998 e43d6000 e43d7fbc e3cec02c 
       e43d0018 e0110018 e3cec02c e0114cf6 e0300010 00000206 e43d7f9c e43d0018 
Call Trace:    [<e01140fc>] [<e0106fd7>] [<e0110018>] [<e0114cf6>] [<e0114cf6>]
  [<e0106d87>]
Code: 8b 47 58 89 45 f8 8b 5e 5c 85 c0 75 09 89 5f 5c ff 43 14 eb 
 general protection fault: 0000 2.4.20-pre10aa1h #1 Fri Oct 11 16:24:07 MSD 2002
CPU:    0
EIP:    0010:[<e0113a01>]    Not tainted
EFLAGS: 00010002
eax: 00000073   ebx: e0307520   ecx: e03078d0   edx: ffffffd9
esi: e30d2000   edi: e0307500   ebp: e43d7db0   esp: e43d7d98
ds: 0018   es: 0018   ss: 0018
Process layers-dbg (pid: 974, stackpage=e43d7000)
Stack: e30d3f78 00000001 e02a992c e43d7dac 00000000 00000056 e43d7dd8 e0114133 
       e30d2000 00000000 fffffc72 00000092 00000001 00000082 00000001 e02a992c 
       e43d7de8 e01170b6 e0310481 00000046 e43d7dfc e0116fe8 0000000f 00000000 
Call Trace:    [<e0114133>] [<e01170b6>] [<e0116fe8>] [<e0112bbf>] [<e0107361>]
  [<e0112ffd>] [<e0113fca>] [<e0112bcc>] [<e011c88a>] [<e011c70d>] [<e011c88a>]
  [<e0119698>] [<e01195cd>] [<e01193ab>] [<e0106e78>] [<e0113fca>] [<e01140fc>]
  [<e0106fd7>] [<e0110018>] [<e0114cf6>] [<e0114cf6>] [<e0106d87>]
Code: 8b 42 24 39 46 24 7d 07 c7 42 14 01 00 00 00 c7 45 f8 01 00 
Reading Oops report from the terminal
EIP:    0010:[<e0113fca>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: 0000008c   ebx: e0307524   ecx: 00000000   edx: e0307520
esi: e43d6000   edi: ffffffd9   ebp: e43d7f50   esp: e43d7f3c
ds: 0018   es: 0018   ss: 0018
Process layers-dbg (pid: 974, stackpage=e43d7000)
Stack: e43d6000 e0307998 e43d6000 e43d7fb8 e43d6000 e43d7f58 e01140fc e43d7f9c 
       e0106fd7 e43d6000 e43d602c e3ccc02c e0307998 e43d6000 e43d7fbc e3cec02c 
       e43d0018 e0110018 e3cec02c e0114cf6 e0300010 00000206 e43d7f9c e43d0018 
Call Trace:    [<e01140fc>] [<e0106fd7>] [<e0110018>] [<e0114cf6>] [<e0114cf6>]
  [<e0106d87>]
Code: 8b 47 58 89 45 f8 8b 5e 5c 85 c0 75 09 89 5f 5c ff 43 14 eb 


>>EIP; e0113fca <do_schedule+13a/214>   <=====

>>ebx; e0307524 <runqueues+24/940>
>>edx; e0307520 <runqueues+20/940>

Trace; e01140fc <kern_do_schedule+18/1c>
Trace; e0106fd7 <kern_schedule+1b/24>
Trace; e0110018 <mtrr_write+e0/310>
Trace; e0114cf6 <sys_sched_yield+122/12c>
Trace; e0114cf6 <sys_sched_yield+122/12c>
Trace; e0106d87 <system_call+33/38>

Code;  e0113fca <do_schedule+13a/214>
00000000 <_EIP>:
Code;  e0113fca <do_schedule+13a/214>   <=====
   0:   8b 47 58                  mov    0x58(%edi),%eax   <=====
Code;  e0113fcd <do_schedule+13d/214>
   3:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  e0113fd0 <do_schedule+140/214>
   6:   8b 5e 5c                  mov    0x5c(%esi),%ebx
Code;  e0113fd3 <do_schedule+143/214>
   9:   85 c0                     test   %eax,%eax
Code;  e0113fd5 <do_schedule+145/214>
   b:   75 09                     jne    16 <_EIP+0x16> e0113fe0
<do_schedule+150/214>
Code;  e0113fd7 <do_schedule+147/214>
   d:   89 5f 5c                  mov    %ebx,0x5c(%edi)
Code;  e0113fda <do_schedule+14a/214>
  10:   ff 43 14                  incl   0x14(%ebx)
Code;  e0113fdd <do_schedule+14d/214>
  13:   eb 00                     jmp    15 <_EIP+0x15> e0113fdf
<do_schedule+14f/214>

CPU:    0
EIP:    0010:[<e0113a01>]    Not tainted
EFLAGS: 00010002
eax: 00000073   ebx: e0307520   ecx: e03078d0   edx: ffffffd9
esi: e30d2000   edi: e0307500   ebp: e43d7db0   esp: e43d7d98
ds: 0018   es: 0018   ss: 0018
Process layers-dbg (pid: 974, stackpage=e43d7000)
Stack: e30d3f78 00000001 e02a992c e43d7dac 00000000 00000056 e43d7dd8 e0114133 
       e30d2000 00000000 fffffc72 00000092 00000001 00000082 00000001 e02a992c 
       e43d7de8 e01170b6 e0310481 00000046 e43d7dfc e0116fe8 0000000f 00000000 
Call Trace:    [<e0114133>] [<e01170b6>] [<e0116fe8>] [<e0112bbf>] [<e0107361>]
  [<e0112ffd>] [<e0113fca>] [<e0112bcc>] [<e011c88a>] [<e011c70d>] [<e011c88a>]
  [<e0119698>] [<e01195cd>] [<e01193ab>] [<e0106e78>] [<e0113fca>] [<e01140fc>]
  [<e0106fd7>] [<e0110018>] [<e0114cf6>] [<e0114cf6>] [<e0106d87>]
Code: 8b 42 24 39 46 24 7d 07 c7 42 14 01 00 00 00 c7 45 f8 01 00 


>>EIP; e0113a01 <try_to_wake_up+121/150>   <=====

>>ebx; e0307520 <runqueues+20/940>
>>ecx; e03078d0 <runqueues+3d0/940>
>>edi; e0307500 <runqueues+0/940>

Trace; e0114133 <__wake_up+33/7c>
Trace; e01170b6 <release_console_sem+76/80>
Trace; e0116fe8 <printk+f0/108>
Trace; e0112bbf <bust_spinlocks+3f/4c>
Trace; e0107361 <die+7d/88>
Trace; e0112ffd <do_page_fault+431/612>
Trace; e0113fca <do_schedule+13a/214>
Trace; e0112bcc <do_page_fault+0/612>
Trace; e011c88a <timer_bh+26/354>
Trace; e011c70d <update_wall_time+d/44>
Trace; e011c88a <timer_bh+26/354>
Trace; e0119698 <bh_action+1c/4c>
Trace; e01195cd <tasklet_hi_action+4d/70>
Trace; e01193ab <do_softirq+4b/a0>
Trace; e0106e78 <error_code+34/3c>
Trace; e0113fca <do_schedule+13a/214>
Trace; e01140fc <kern_do_schedule+18/1c>
Trace; e0106fd7 <kern_schedule+1b/24>
Trace; e0110018 <mtrr_write+e0/310>
Trace; e0114cf6 <sys_sched_yield+122/12c>
Trace; e0114cf6 <sys_sched_yield+122/12c>
Trace; e0106d87 <system_call+33/38>

Code;  e0113a01 <try_to_wake_up+121/150>
00000000 <_EIP>:
Code;  e0113a01 <try_to_wake_up+121/150>   <=====
   0:   8b 42 24                  mov    0x24(%edx),%eax   <=====
Code;  e0113a04 <try_to_wake_up+124/150>
   3:   39 46 24                  cmp    %eax,0x24(%esi)
Code;  e0113a07 <try_to_wake_up+127/150>
   6:   7d 07                     jge    f <_EIP+0xf> e0113a10
<try_to_wake_up+130/150>
Code;  e0113a09 <try_to_wake_up+129/150>
   8:   c7 42 14 01 00 00 00      movl   $0x1,0x14(%edx)
Code;  e0113a10 <try_to_wake_up+130/150>
   f:   c7 45 f8 01 00 00 00      movl   $0x1,0xfffffff8(%ebp)



User program:

$ps axfu

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
....
vz         793  0.0  0.0  9160    4 ?        S    04:48   0:00 /layers-dbg
vz         794  0.0 79.9 1759832 1655784 ?   S    04:48   0:00  \_ layers-dbg sf
vz         811  0.0 79.9 1759832 1655784 ?   S    04:48   0:00      \_ layers-dbgsf
vz         812  0.0 79.9 1759832 1655784 ?   S    04:48   0:00          \_layers-dbg sf
vz         813  0.0 79.9 1759832 1655784 ?   S    04:48   0:00          \_layers-dbg sf
vz         814  0.0 79.9 1759832 1655788 ?   S    04:48   0:00          \_layers-dbg sf
vz         815  0.0 79.9 1759832 1655788 ?   S    04:48   0:00          \_layers-dbg sf
vz        1063 27.0 79.9 1759832 1655788 ?   S    05:08  25:06          \_layers-dbg sf
vz        1145  0.7 79.9 1759832 1655788 ?   S    05:23   0:36          \_layers-dbg sf


$vmstat 5
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0 156044  79056   4512 234860   4  24   219   136 2028  5982  33  17  50
 1  0  0 156036  78940   4512 234860  19   0    19     0 3120  2903  45  16  40
 3  0  0 156028  78892   4512 234860  13   0    13     0 3013 10992  50  18  32




-- 
bye.
Andrey Nekrasov, SpyLOG.
