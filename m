Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286556AbRL0TyN>; Thu, 27 Dec 2001 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286572AbRL0TyF>; Thu, 27 Dec 2001 14:54:05 -0500
Received: from isis.telemach.net ([213.143.65.10]:54281 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S286556AbRL0Txt>;
	Thu, 27 Dec 2001 14:53:49 -0500
Date: Thu, 27 Dec 2001 20:53:50 +0100
From: Jure Pecar <pegasus@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 oops
Message-Id: <20011227205350.532d20b1.pegasus@telemach.net>
In-Reply-To: <20011227190954.6b504c04.pegasus@telemach.net>
In-Reply-To: <20011227190954.6b504c04.pegasus@telemach.net>
Organization: Select Technology 
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Huh, it just happened again. Same symptoms, shell responsive, can do dmesg & such, but w or ps ax gives no reply. Load steadily increases.

ksymoops 0.7c on i686 2.4.17-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01ee900, System.map says c0156eb0.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    2
EIP:    0010:[<c012e1cb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000840   ebx: c2cda940   ecx: c2cda940   edx: 00000000
esi: fe068fdd   edi: 00000000   ebp: 00000000   esp: c7f75ef4
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 13231, stackpage=c7f75000)
Stack: 0000012e fe068fdd 00000000 ed2ad000 f75006c0 bffffeaf 00000000 00000000 
       0000012e c012e8d8 c011de64 f75006c0 00000000 0000012e f74b8000 c7f75f44 
       c7f74000 f75006dc ed2ad000 f75006c0 c2cda940 f74fed20 c0152319 f74b8000 
Call Trace: [<c012e8d8>] [<c011de64>] [<c0152319>] [<c0152631>] [<c0134bee>] 
   [<c0106de3>] 
Code: 0f 0b 8b 43 18 a8 80 74 02 0f 0b 80 63 18 eb be 00 e0 ff ff

>>EIP; c012e1cb <__free_pages_ok+4b/1fc>   <=====
Trace; c012e8d8 <__free_pages+1c/20>
Trace; c011de64 <access_process_vm+170/1b0>
Trace; c0152319 <proc_pid_environ+55/68>
Trace; c0152631 <proc_info_read+59/128>
Trace; c0134bee <sys_read+8e/c4>
Trace; c0106de3 <system_call+2f/34>
Code;  c012e1cb <__free_pages_ok+4b/1fc>
00000000 <_EIP>:
Code;  c012e1cb <__free_pages_ok+4b/1fc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012e1cd <__free_pages_ok+4d/1fc>
   2:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012e1d0 <__free_pages_ok+50/1fc>
   5:   a8 80                     test   $0x80,%al
Code;  c012e1d2 <__free_pages_ok+52/1fc>
   7:   74 02                     je     b <_EIP+0xb> c012e1d6 <__free_pages_ok+56/1fc>
Code;  c012e1d4 <__free_pages_ok+54/1fc>
   9:   0f 0b                     ud2a   
Code;  c012e1d6 <__free_pages_ok+56/1fc>
   b:   80 63 18 eb               andb   $0xeb,0x18(%ebx)
Code;  c012e1da <__free_pages_ok+5a/1fc>
   f:   be 00 e0 ff ff            mov    $0xffffe000,%esi


2 warnings issued.  Results may not be reliable.



-- 


Jure Pecar
