Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136132AbREGON7>; Mon, 7 May 2001 10:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136135AbREGONu>; Mon, 7 May 2001 10:13:50 -0400
Received: from adsl-125234.customers.ins.at ([194.152.125.234]:3624 "HELO
	hal.fake.net") by vger.kernel.org with SMTP id <S136132AbREGONk>;
	Mon, 7 May 2001 10:13:40 -0400
Subject: PROBLEM: 2.4.4 and in2000
To: linux-kernel@vger.kernel.org
Date: Mon, 7 May 2001 16:13:29 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010507141329.4C92FC2E@hal.fake.net>
From: girbal@tacheles.de (Peter Chiocchetti)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

patching the kernel from 2.4.3 to 2.4.4 broke the in2000 scsi
lowlevel host adapter module. ksymoops output below.

thanks, peter chiocchetti

-------------------------------------------------------------------------

ksymoops 2.4.1 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Forcing IN2000 detection at IOport 0x220 <1>Unable to handle kernel paging request at virtual address 000d8010
c891f2cb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c891f2cb>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000d8000   ebx: 00000008   ecx: 00000000   edx: 00000002
esi: c497347c   edi: c49734d0   ebp: c49734d8   esp: c5a19e54
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1247, stackpage=c5a19000)
Stack: 00000020 c5a19e90 c5a19e8c 00004927 00000286 00000000 c0219c18 c0219c90 
       c0219df0 00000000 c0219dec 00000002 00000001 c4973400 080c1000 00000220 
       c117d028 c011ee3a c011ee8f c5944e80 c4e8c304 00000000 080c101c 080c1000 
Call Trace: [<c011ee3a>] [<c011ee8f>] [<c891d000>] [<c8921200>] [<c8908416>] [<c8921200>] [<c012208c>] 
       [<c891d000>] [<c891ff06>] [<c8921200>] [<c8921200>] [<c0113545>] [<c8921494>] [<c8907000>] [<c891d060>] 
       [<c0106c17>] 
Code: 8b 40 10 3d 4e 4f 56 41 75 10 0f b6 44 24 1c 83 e0 20 74 06 

>>EIP; c891f2cb <[in2000]in2000_detect+2fb/590>   <=====
Trace; c011ee3a <do_wp_page+1aa/230>
Trace; c011ee8f <do_wp_page+1ff/230>
Trace; c891d000 <[scsi_mod]__kstrtab_scsi_device_types+124a/12aa>
Trace; c8921200 <[in2000]driver_template+0/6b>
Trace; c8908416 <[scsi_mod]scsi_register_host+46/2e0>
Trace; c8921200 <[in2000]driver_template+0/6b>
Trace; c012208c <file_read_actor+2c/60>
Trace; c891d000 <[scsi_mod]__kstrtab_scsi_device_types+124a/12aa>
Trace; c891ff06 <[in2000]init_this_scsi_driver+16/40>
Trace; c8921200 <[in2000]driver_template+0/6b>
Trace; c8921200 <[in2000]driver_template+0/6b>
Trace; c0113545 <sys_init_module+525/5e0>
Trace; c8921494 <[in2000].bss.end+4/1bd0>
Trace; c8907000 <[via686a].data.end+eec5/ef25>
Trace; c891d060 <[in2000]read_1_byte+0/70>
Trace; c0106c17 <system_call+33/38>
Code;  c891f2cb <[in2000]in2000_detect+2fb/590>
00000000 <_EIP>:
Code;  c891f2cb <[in2000]in2000_detect+2fb/590>   <=====
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
Code;  c891f2ce <[in2000]in2000_detect+2fe/590>
   3:   3d 4e 4f 56 41            cmp    $0x41564f4e,%eax
Code;  c891f2d3 <[in2000]in2000_detect+303/590>
   8:   75 10                     jne    1a <_EIP+0x1a> c891f2e5 <[in2000]in2000_detect+315/590>
Code;  c891f2d5 <[in2000]in2000_detect+305/590>
   a:   0f b6 44 24 1c            movzbl 0x1c(%esp,1),%eax
Code;  c891f2da <[in2000]in2000_detect+30a/590>
   f:   83 e0 20                  and    $0x20,%eax
Code;  c891f2dd <[in2000]in2000_detect+30d/590>
  12:   74 06                     je     1a <_EIP+0x1a> c891f2e5 <[in2000]in2000_detect+315/590>


2 warnings issued.  Results may not be reliable.
