Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265407AbRFVN3f>; Fri, 22 Jun 2001 09:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbRFVN3Z>; Fri, 22 Jun 2001 09:29:25 -0400
Received: from regurgitate.ugcs.caltech.edu ([131.215.43.159]:30731 "HELO
	regurgitate.ugcs.caltech.edu") by vger.kernel.org with SMTP
	id <S265407AbRFVN3I>; Fri, 22 Jun 2001 09:29:08 -0400
Date: Fri, 22 Jun 2001 06:29:06 -0700 (PDT)
From: "Joe W. Haas" <haas@ugcs.caltech.edu>
To: linux-kernel@vger.kernel.org
Subject: Kernel oopses 2.4.5
Message-ID: <Pine.LNX.4.10.10106220618130.32242-100000@regurgitate.ugcs.caltech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of oopses.  They occured while realplay was running.
The sound changed from the dulcit tones of Marvin Gaye to short,
static-y bursts.  Innocently enough, I thought to bother my sound
driver's maintainer, but the problem isn't in his regime;  not knowing
who else to bother, I'm posting this here.  

Machine is a Pentium II 350 running Debian testing.  Any further
info/testing needed, just ask me.  
Please CC me in any reply, as I am not subscribed to the list.
I have not been able to reproduce the problem.

Thanks.
--
Joe Haas


ksymoops 2.4.1 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Jun 21 07:47:53 lembas kernel: cpu: 0, clocks: 1002294, slice: 501147
Jun 21 07:47:53 lembas kernel: ds: no socket drivers loaded!
Jun 21 07:48:14 lembas kernel: ac97_codec: AC97  codec, id: 0x414b:0x4d00 (Asahi Kasei AK4540)
Jun 21 11:59:52 lembas kernel: Unable to handle kernel paging request at virtual address 021802c2
Jun 21 11:59:52 lembas kernel: c0114bcf
Jun 21 11:59:52 lembas kernel: *pde = 00000000
Jun 21 11:59:52 lembas kernel: Oops: 0002
Jun 21 11:59:52 lembas kernel: CPU:    0
Jun 21 11:59:52 lembas kernel: EIP:    0010:[<c0114bcf>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 21 11:59:52 lembas kernel: EFLAGS: 00010286
Jun 21 11:59:52 lembas kernel: eax: 021802c2   ebx: c549bdc0   ecx: c435e250   edx: c435e250
Jun 21 11:59:52 lembas kernel: esi: c435e000   edi: 021802c2   ebp: bf5ffb24   esp: c435ff90
Jun 21 11:59:52 lembas kernel: ds: 0018   es: 0018   ss: 0018
Jun 21 11:59:52 lembas kernel: Process realplay (pid: 2447, stackpage=c435f000)
Jun 21 11:59:52 lembas kernel: Stack: c549bdc0 c435e000 00000000 bf5ffb24 bf5ffb24 c01151af 021802c2 c435e000 
Jun 21 11:59:52 lembas kernel:        bf5ffc00 bf7ffc00 c0115312 00000000 c0106a7b 00000000 00000020 401ad5dc 
Jun 21 11:59:52 lembas kernel:        bf5ffc00 bf7ffc00 bf5ffb24 00000001 c010002b 0000002b 00000001 402514ed 
Jun 21 11:59:52 lembas kernel: Call Trace: [<c01151af>] [<c0115312>] [<c0106a7b>] [<c010002b>] 
Jun 21 11:59:52 lembas kernel: Code: ff 0f 0f 94 c0 84 c0 0f 84 9c 00 00 00 8b 57 14 31 ed 31 f6 

>>EIP; c0114bcf <put_files_struct+b/bc>   <=====
Trace; c01151af <do_exit+c3/1fc>
Trace; c0115312 <sys_exit+e/10>
Trace; c0106a7b <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>
Code;  c0114bcf <put_files_struct+b/bc>
00000000 <_EIP>:
Code;  c0114bcf <put_files_struct+b/bc>   <=====
   0:   ff 0f                     decl   (%edi)   <=====
Code;  c0114bd1 <put_files_struct+d/bc>
   2:   0f 94 c0                  sete   %al
Code;  c0114bd4 <put_files_struct+10/bc>
   5:   84 c0                     test   %al,%al
Code;  c0114bd6 <put_files_struct+12/bc>
   7:   0f 84 9c 00 00 00         je     a9 <_EIP+0xa9> c0114c78 <put_files_struct+b4/bc>
Code;  c0114bdc <put_files_struct+18/bc>
   d:   8b 57 14                  mov    0x14(%edi),%edx
Code;  c0114bdf <put_files_struct+1b/bc>
  10:   31 ed                     xor    %ebp,%ebp
Code;  c0114be1 <put_files_struct+1d/bc>
  12:   31 f6                     xor    %esi,%esi

Jun 21 11:59:52 lembas kernel: Unable to handle kernel paging request at virtual address 078d023e
Jun 21 11:59:52 lembas kernel: c01151ca
Jun 21 11:59:52 lembas kernel: *pde = 00000000
Jun 21 11:59:52 lembas kernel: Oops: 0002
Jun 21 11:59:52 lembas kernel: CPU:    0
Jun 21 11:59:52 lembas kernel: EIP:    0010:[<c01151ca>]
Jun 21 11:59:52 lembas kernel: EFLAGS: 00010202
Jun 21 11:59:52 lembas kernel: eax: 00000000   ebx: 078d023e   ecx: c435e250   edx: c435e250
Jun 21 11:59:52 lembas kernel: esi: c435e000   edi: 0000000b   ebp: 021802c2   esp: c435fe90
Jun 21 11:59:52 lembas kernel: ds: 0018   es: 0018   ss: 0018
Jun 21 11:59:52 lembas kernel: Process realplay (pid: 2447, stackpage=c435f000)
Jun 21 11:59:52 lembas kernel: Stack: 00000000 00000002 c010fc14 c0106f7e 0000000b c010ff67 c020d77e c435ff5c 
Jun 21 11:59:52 lembas kernel:        00000002 c435e000 00000002 c010fc14 bf5ffb24 00000046 00000000 c435e000 
Jun 21 11:59:52 lembas kernel:        00000046 c25c4000 00030001 c0119f5a c25c4000 00000286 00000020 c0119fd4 
Jun 21 11:59:52 lembas kernel: Call Trace: [<c010fc14>] [<c0106f7e>] [<c010ff67>] [<c010fc14>] [<c0119f5a>] [<c0119fd4>] [<c011a20d>] 
Jun 21 11:59:52 lembas kernel:        [<c011a959>] [<c0106b98>] [<c0110018>] [<c0114bcf>] [<c01151af>] [<c0115312>] [<c0106a7b>] [<c010002b>] 
Jun 21 11:59:52 lembas kernel: Code: ff 0b 0f 94 c0 84 c0 0f 84 88 00 00 00 8b 43 0c 50 e8 50 7f 

>>EIP; c01151ca <do_exit+de/1fc>   <=====
Trace; c010fc14 <do_page_fault+0/45c>
Trace; c0106f7e <die+42/44>
Trace; c010ff67 <do_page_fault+353/45c>
Trace; c010fc14 <do_page_fault+0/45c>
Trace; c0119f5a <deliver_signal+4a/50>
Trace; c0119fd4 <send_sig_info+74/98>
Trace; c011a20d <kill_something_info+d5/e0>
Trace; c011a959 <sys_kill+4d/58>
Trace; c0106b98 <error_code+34/3c>
Trace; c0110018 <do_page_fault+404/45c>
Trace; c0114bcf <put_files_struct+b/bc>
Trace; c01151af <do_exit+c3/1fc>
Trace; c0115312 <sys_exit+e/10>
Trace; c0106a7b <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>
Code;  c01151ca <do_exit+de/1fc>
00000000 <_EIP>:
Code;  c01151ca <do_exit+de/1fc>   <=====
   0:   ff 0b                     decl   (%ebx)   <=====
Code;  c01151cc <do_exit+e0/1fc>
   2:   0f 94 c0                  sete   %al
Code;  c01151cf <do_exit+e3/1fc>
   5:   84 c0                     test   %al,%al
Code;  c01151d1 <do_exit+e5/1fc>
   7:   0f 84 88 00 00 00         je     95 <_EIP+0x95> c011525f <do_exit+173/1fc>
Code;  c01151d7 <do_exit+eb/1fc>
   d:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c01151da <do_exit+ee/1fc>
  10:   50                        push   %eax
Code;  c01151db <do_exit+ef/1fc>
  11:   e8 50 7f 00 00            call   7f66 <_EIP+0x7f66> c011d130 <flush_scheduled_tasks+50/94>

Jun 21 11:59:52 lembas kernel: Unable to handle kernel paging request at virtual address 011604df
Jun 21 11:59:52 lembas kernel: c0119950
Jun 21 11:59:52 lembas kernel: *pde = 00000000
Jun 21 11:59:52 lembas kernel: Oops: 0000
Jun 21 11:59:52 lembas kernel: CPU:    0
Jun 21 11:59:52 lembas kernel: EIP:    0010:[<c0119950>]
Jun 21 11:59:52 lembas kernel: EFLAGS: 00010002
Jun 21 11:59:52 lembas kernel: eax: c435e558   ebx: c435e000   ecx: c435e250   edx: 011604df
Jun 21 11:59:52 lembas kernel: esi: c435e000   edi: 0000000b   ebp: 078d023e   esp: c435fd78
Jun 21 11:59:52 lembas kernel: ds: 0018   es: 0018   ss: 0018
Jun 21 11:59:52 lembas kernel: Process realplay (pid: 2447, stackpage=c435f000)
Jun 21 11:59:52 lembas kernel: Stack: c435e000 c01199d3 c435e558 00000000 c0115265 c435e000 00000000 00000002 
Jun 21 11:59:52 lembas kernel:        c010fc14 c0106f7e 0000000b c010ff67 c020d77e c435fe5c 00000002 c435e000 
Jun 21 11:59:52 lembas kernel:        00000002 c010fc14 021802c2 00000000 00000001 c435e000 c435fde0 ffffffff 
Jun 21 11:59:52 lembas kernel: Call Trace: [<c01199d3>] [<c0115265>] [<c010fc14>] [<c0106f7e>] [<c010ff67>] [<c010fc14>] [<c010002b>] 
Jun 21 11:59:52 lembas kernel:        [<c017afb6>] [<c017afb6>] [<c02039c6>] [<c017afb6>] [<c017afb6>] [<c0106b98>] [<c01151ca>] [<c010fc14>] 
Jun 21 11:59:52 lembas kernel:        [<c0106f7e>] [<c010ff67>] [<c010fc14>] [<c0119f5a>] [<c0119fd4>] [<c011a20d>] [<c011a959>] [<c0106b98>] 
Jun 21 11:59:52 lembas kernel:        [<c0110018>] [<c0114bcf>] [<c01151af>] [<c0115312>] [<c0106a7b>] [<c010002b>] 
Jun 21 11:59:52 lembas kernel: Code: 8b 1a a1 60 15 2a c0 52 50 e8 06 bf 00 00 83 c4 08 ff 0d bc 

>>EIP; c0119950 <flush_sigqueue+24/44>   <=====
Trace; c01199d3 <exit_sighand+47/50>
Trace; c0115265 <do_exit+179/1fc>
Trace; c010fc14 <do_page_fault+0/45c>
Trace; c0106f7e <die+42/44>
Trace; c010ff67 <do_page_fault+353/45c>
Trace; c010fc14 <do_page_fault+0/45c>
Trace; c010002b <startup_32+2b/a5>
Trace; c017afb6 <vt_console_print+76/2d4>
Trace; c017afb6 <vt_console_print+76/2d4>
Trace; c02039c6 <vsprintf+33e/36c>
Trace; c017afb6 <vt_console_print+76/2d4>
Trace; c017afb6 <vt_console_print+76/2d4>
Trace; c0106b98 <error_code+34/3c>
Trace; c01151ca <do_exit+de/1fc>
Trace; c010fc14 <do_page_fault+0/45c>
Trace; c0106f7e <die+42/44>
Trace; c010ff67 <do_page_fault+353/45c>
Trace; c010fc14 <do_page_fault+0/45c>
Trace; c0119f5a <deliver_signal+4a/50>
Trace; c0119fd4 <send_sig_info+74/98>
Trace; c011a20d <kill_something_info+d5/e0>
Trace; c011a959 <sys_kill+4d/58>
Trace; c0106b98 <error_code+34/3c>
Trace; c0110018 <do_page_fault+404/45c>
Trace; c0114bcf <put_files_struct+b/bc>
Trace; c01151af <do_exit+c3/1fc>
Trace; c0115312 <sys_exit+e/10>
Trace; c0106a7b <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>
Code;  c0119950 <flush_sigqueue+24/44>
00000000 <_EIP>:
Code;  c0119950 <flush_sigqueue+24/44>   <=====
   0:   8b 1a                     mov    (%edx),%ebx   <=====
Code;  c0119952 <flush_sigqueue+26/44>
   2:   a1 60 15 2a c0            mov    0xc02a1560,%eax
Code;  c0119957 <flush_sigqueue+2b/44>
   7:   52                        push   %edx
Code;  c0119958 <flush_sigqueue+2c/44>
   8:   50                        push   %eax
Code;  c0119959 <flush_sigqueue+2d/44>
   9:   e8 06 bf 00 00            call   bf14 <_EIP+0xbf14> c0125864 <kmem_cache_free+0/ac>
Code;  c011995e <flush_sigqueue+32/44>
   e:   83 c4 08                  add    $0x8,%esp
Code;  c0119961 <flush_sigqueue+35/44>
  11:   ff 0d bc 00 00 00         decl   0xbc


1 warning issued.  Results may not be reliable.


