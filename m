Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289115AbSBMXWJ>; Wed, 13 Feb 2002 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSBMXV7>; Wed, 13 Feb 2002 18:21:59 -0500
Received: from smtp-stjh-01-01.rogers.nf.net ([192.75.13.141]:12689 "EHLO
	smtp-stjh-01-01.rogers.nf.net") by vger.kernel.org with ESMTP
	id <S289117AbSBMXVs>; Wed, 13 Feb 2002 18:21:48 -0500
Message-ID: <3C6AF523.9070703@colabnet.com>
Date: Wed, 13 Feb 2002 19:52:11 -0330
From: Rob Lake <rlake@colabnet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Promise SuperTrak100 Oops/Kernel Panic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I've been trying to get a Promise SuperTrak 100 working.  I'm using 
linux-2.4.13-ac8 (patched from linux-2.4.13 with ac8 patch, if it 
matters).  Each time I load the i2o_block module, there is a a kernel 
panic.  Running the output through ksymoops produced the what's below - 
hopefully the ???? are supposed to be there.  At first I tried with i2o 
compiled into kernel; It had detected the raid card, but panic'd soon after.

If you're requiring any more information, let me know.

Thanks for any help,
Rob Lake
rlake@colabnet.com

------------
ksymoops 2.4.1 on i686 2.4.13-ac8.  Options used
     -V (default)
     -k ./ksyms.3 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-ac8/ (default)
     -m /boot/System.map-2.4.13-ac8 (default)

No modules in ksyms, skipping objects
Oops:   0000
CPU:    0
EIP:    0010:[<e094af5e>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 000102006
eax: e0956044   ebx: 0009e2be     ecx: 0000000a       edx: 0009e2be
esi: 04000001   edi: c18a0d80     edp: c0267fac       esp: c0267f54
ds:  0018       es:  0018     ss: 0018
Process swapper (pid:0, stackpage=c0266000)
Stack:  dd559280 04000001 0000000a e089e10e c18a0d80 c0108229 0000000a 
c18a0280
        c0267fac c0267fac 0000000a c029ab80 88559280 c0108398 0000000a 
c0267fac
        dd559280 c01051a0 c0250de0 c01551a0 000ae000 c0108254 c01051a0 
00000032
Call Trace: [<e089e10c>] [<c0108229>] [<c0108398>] [<c01051a0>] [<e01051a0>]
[<c010a254>] [<c01051a0>] [<c01051bf>] [<c0105232>] [<c0105000>]
Code: 8b 4a 08 89 c8 83 e0 3f 8b 04 85 00 ff 94 e0 85 c0 74 10 8b

 >>EIP; e094af5e <END_OF_CODE+20679fc2/????>   <=====
Trace; e089e10c <END_OF_CODE+205cd170/????>
Trace; c0108229 <handle_IRQ_event+39/60>
Trace; c0108398 <do_IRQ+68/b0>
Trace; c01051a0 <default_idle+0/30>
Trace; e01051a0 <END_OF_CODE+1fe34204/????>
Trace; c010a254 <call_do_IRQ+5/d>
Trace; c01051a0 <default_idle+0/30>
Trace; c01051bf <default_idle+1f/30>
Trace; c0105232 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Code;  e094af5e <END_OF_CODE+20679fc2/????>
00000000 <_EIP>:
Code;  e094af5e <END_OF_CODE+20679fc2/????>   <=====
   0:   8b 4a 08                  mov    0x8(%edx),%ecx   <=====
Code;  e094af61 <END_OF_CODE+20679fc5/????>
   3:   89 c8                     mov    %ecx,%eax
Code;  e094af63 <END_OF_CODE+20679fc7/????>
   5:   83 e0 3f                  and    $0x3f,%eax
Code;  e094af66 <END_OF_CODE+20679fca/????>
   8:   8b 04 85 00 ff 94 e0      mov    0xe094ff00(,%eax,4),%eax
Code;  e094af6d <END_OF_CODE+20679fd1/????>
   f:   85 c0                     test   %eax,%eax
Code;  e094af6f <END_OF_CODE+20679fd3/????>
  11:   74 10                     je     23 <_EIP+0x23> e094af81 
<END_OF_CODE+20679fe5/????>
Code;  e094af71 <END_OF_CODE+20679fd5/????>
  13:   8b 00                     mov    (%eax),%eax


