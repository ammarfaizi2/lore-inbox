Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267857AbTBKOsf>; Tue, 11 Feb 2003 09:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267869AbTBKOsf>; Tue, 11 Feb 2003 09:48:35 -0500
Received: from natco4.southshore.com ([205.167.142.104]:45033 "EHLO
	natco4.southshore.com") by vger.kernel.org with ESMTP
	id <S267857AbTBKOsd>; Tue, 11 Feb 2003 09:48:33 -0500
Message-ID: <3E490F71.9020907@leadhill.net>
Date: Tue, 11 Feb 2003 08:57:53 -0600
From: Michael McGlothlin <mogmios@leadhill.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops i've having problems with
Content-Type: multipart/mixed;
 boundary="------------020700040900000000040901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020700040900000000040901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

CC me directly if you need more info or have a suggestion.

I have a x86-compat 933Mhz VIA Ezra CPU on a FIC mini-itx board. The 
system has 256Mb of RAM and a 40Gb ide hdd. I'm running a fully 
up-to-date copy of RedHat 7.3 with kernel 2.4.18-3. Off and on I'm 
having the system freeze when I su and change to a certain directory. 
The filesystem is ext3 and the directory has about half a dozen 
subdirectories each of which have several gigs of files. I've had the 
system for about a month running 24/7 and have only had this happen 
about four times. After one of these freezes I noticed an oops in my 
logs and and saved it. I've been trying to get more copies but that was 
the only time there was an indication of an oops in the log.

Output of ksymoops on the logged oops is attached. If I didn't do it 
right please let me know. Thanks.

--------------020700040900000000040901
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.4 on i686 2.4.18-3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-3/ (default)
     -m /boot/System.map-2.4.18-3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (pclose_local): find_objects pclose failed 0x100
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01b5a40, System.map says c0155ec0.  Ignoring ksyms_base entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Jan 27 05:49:05 buttercup kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan 27 05:49:05 buttercup kernel: c013fced
Jan 27 05:49:05 buttercup kernel: *pde = 00000000
Jan 27 05:49:05 buttercup kernel: Oops: 0000
Jan 27 05:49:05 buttercup kernel: CPU:    0
Jan 27 05:49:05 buttercup kernel: EIP:    0010:[<c013fced>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 27 05:49:05 buttercup kernel: EFLAGS: 00010246
Jan 27 05:49:05 buttercup kernel: eax: 00000000   ebx: c5d46610   ecx: 00000006   edx: 00000006
Jan 27 05:49:05 buttercup kernel: esi: 00000000   edi: 00000002   ebp: cd4eff7c   esp: cd4eff24
Jan 27 05:49:05 buttercup kernel: ds: 0018   es: 0018   ss: 0018
Jan 27 05:49:05 buttercup kernel: Process lpd (pid: 19650, stackpage=cd4ef000)
Jan 27 05:49:05 buttercup kernel: Stack: c5d46610 ffffffff 00000000 00000006 c62922e0 cd4ee56c bfffeaf0 cd4eff70 
Jan 27 05:49:05 buttercup kernel:        cd4effa4 00000000 c0120460 0000000a cd4eff90 00000542 00000542 00000001 
Jan 27 05:49:05 buttercup kernel:        c1bd9000 c0135746 c1bd9000 00000543 00000180 cd4eff7c c62922e0 c132e490 
Jan 27 05:49:05 buttercup kernel: Call Trace: [<c0120460>] sys_rt_sigaction [kernel] 0xa8 
Jan 27 05:49:05 buttercup kernel: [<c0135746>] filp_open [kernel] 0x32 
Jan 27 05:49:05 buttercup kernel: [<c0135a4f>] sys_open [kernel] 0x33 
Jan 27 05:49:05 buttercup kernel: [<c01085f7>] system_call [kernel] 0x33 
Jan 27 05:49:06 buttercup kernel: Code: ff 10 5a 59 31 c0 e9 f0 00 00 00 ff 74 24 08 e8 df 6b 00 00 

>>EIP; c013fced <open_namei+499/59c>   <=====
Trace; c0120460 <sys_rt_sigaction+a8/15c>
Trace; c0135746 <filp_open+32/50>
Trace; c0135a4f <sys_open+33/a4>
Trace; c01085f7 <system_call+33/38>
Code;  c013fced <open_namei+499/59c>
00000000 <_EIP>:
Code;  c013fced <open_namei+499/59c>   <=====
   0:   ff 10                     call   *(%eax)   <=====
Code;  c013fcef <open_namei+49b/59c>
   2:   5a                        pop    %edx
Code;  c013fcf0 <open_namei+49c/59c>
   3:   59                        pop    %ecx
Code;  c013fcf1 <open_namei+49d/59c>
   4:   31 c0                     xor    %eax,%eax
Code;  c013fcf3 <open_namei+49f/59c>
   6:   e9 f0 00 00 00            jmp    fb <_EIP+0xfb> c013fde8 <open_namei+594/59c>
Code;  c013fcf8 <open_namei+4a4/59c>
   b:   ff 74 24 08               pushl  0x8(%esp,1)
Code;  c013fcfc <open_namei+4a8/59c>
   f:   e8 df 6b 00 00            call   6bf3 <_EIP+0x6bf3> c01468e0 <dput+0/144>

Jan 27 05:49:26 buttercup kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan 27 05:49:26 buttercup kernel: c013fced
Jan 27 05:49:26 buttercup kernel: *pde = 00000000
Jan 27 05:49:26 buttercup kernel: Oops: 0000
Jan 27 05:49:26 buttercup kernel: CPU:    0
Jan 27 05:49:26 buttercup kernel: EIP:    0010:[<c013fced>]    Not tainted
Jan 27 05:49:26 buttercup kernel: EFLAGS: 00210246
Jan 27 05:49:26 buttercup kernel: eax: 00000000   ebx: cd460df0   ecx: 00000006   edx: 00000006
Jan 27 05:49:26 buttercup kernel: esi: 00000000   edi: 00000002   ebp: ca025f7c   esp: ca025f24
Jan 27 05:49:26 buttercup kernel: ds: 0018   es: 0018   ss: 0018
Jan 27 05:49:26 buttercup kernel: Process su (pid: 19681, stackpage=ca025000)
Jan 27 05:49:26 buttercup kernel: Stack: cd460df0 ffffffff 00000000 00000006 ce329200 c6a44050 00200246 00001000 
Jan 27 05:49:26 buttercup kernel:        fffffff4 c1557000 401843c2 c013e65c c1557009 00000002 40181ea5 401843d7 
Jan 27 05:49:26 buttercup kernel:        c1557000 c0135746 c1557000 00000003 00000000 ca025f7c ce329200 c132e490 
Jan 27 05:49:26 buttercup kernel: Call Trace: [<c013e65c>] getname [kernel] 0x60 
Jan 27 05:49:26 buttercup kernel: [<c0135746>] filp_open [kernel] 0x32 
Jan 27 05:49:26 buttercup kernel: [<c013e65c>] getname [kernel] 0x60 
Jan 27 05:49:26 buttercup kernel: [<c0135a4f>] sys_open [kernel] 0x33 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c013fced <open_namei+499/59c>   <=====
Trace; c013e65c <getname+60/9c>
Trace; c0135746 <filp_open+32/50>
Trace; c013e65c <getname+60/9c>
Trace; c0135a4f <sys_open+33/a4>

Jan 27 05:52:31 buttercup kernel: ac97_codec: AC97 Audio codec, id: 0x5649:0x4161 (Unknown)

4 warnings and 3 errors issued.  Results may not be reliable.

--------------020700040900000000040901--

