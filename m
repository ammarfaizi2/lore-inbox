Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTATVIq>; Mon, 20 Jan 2003 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbTATVIq>; Mon, 20 Jan 2003 16:08:46 -0500
Received: from [209.178.208.101] ([209.178.208.101]:41745 "HELO
	lserver.ddiworldwide.com") by vger.kernel.org with SMTP
	id <S266886AbTATVIo>; Mon, 20 Jan 2003 16:08:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Frank R Callaghan <f.callaghan@ieee.org>
Reply-To: f.callaghan@ieee.org
To: linux-kernel@vger.kernel.org
Subject: Oops from 2.4.20
Date: Mon, 20 Jan 2003 16:16:10 -0500
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301201616.10301.f.callaghan@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm new here so please be patient, I have an SC520 based PC104 board
that has been running 2.4.19 + rtai 24.1.10 with no problems, I have just
switched to 2.4.20 and have encountered an Oops when loading rtai.o module -
I know your saying it must be rtai but, I have looked at the rtai patch diffs
and there are no changes but line offsets ! I have compiled everything on my
i686 workstation and it all works fine !?

The ksymoops output follows:

[root@plinux rtlinux]# ksymoops -k ksyms -o /lib/modules/2.4.20-rthal5 -m 
/boot/System.map-2.4.20-rthal5 Ooops.file
ksymoops 2.4.1 on i686 2.4.18-rthal5.  Options used
     -V (default)
     -k ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rthal5 (specified)
     -m /boot/System.map-2.4.20-rthal5 (specified)

Warning (compare_ksyms_lsmod): module vmnet is in lsmod but not in ksyms, 
probably no symbols exported
Error (compare_ksyms_lsmod): module rtai is in ksyms but not in lsmod
Warning (compare_maps): mismatch on symbol locked_cpus  , rtai says c1974ce0, 
/lib/modules/2.4.20-rthal5/rtai/rtai.o says c19754c0.  Ignoring 
/lib/modules/2.4.20-rthal5/rtai/rtai.o entry
Warning (compare_maps): mismatch on symbol rtai_proc_root  , rtai says 
c1974de8, /lib/modules/2.4.20-rthal5/rtai/rtai.o says c19755c8.  Ignoring 
/lib/modules/2.4.20-rthal5/rtai/rtai.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c197398a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c197398a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: 00000000   ecx: c0268b04   edx: 00000040
esi: c1977160   edi: c1977260   ebp: c19772e0   esp: c0f79f08
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 65, stackpage=c0f79000)
Stack: c1971000 00000000 00000000 080bee00 c1977260 00000010 000000c0 c0268b04
       c19771e0 c0114765 00000000 c0c0b000 00003e00 c0c0c000 00000060 ffffffea
       00000004 c0041460 00000060 c024a980 c1971060 000087a8 00000000 00000000
Call Trace:    [<c1977260>] [<c19771e0>] [<c0114765>] [<c1971060>] 
[<c0108ca3>]
Code: 8b 00 8a 00 3c 49 75 2e a1 24 a0 24 c0 8b 4c 24 14 8b 04 88

>>EIP; c197398a <[rtai]init_module+24a/2f0>   <=====
Trace; c1977260 <global+6a0/????>
Trace; c19771e0 <global+620/????>
Trace; c0114765 <sys_init_module+5b5/670>
Trace; c1971060 <[rtai]my_cs+0/10>
Trace; c0108ca3 <system_call+33/40>
Code;  c197398a <[rtai]init_module+24a/2f0>
00000000 <_EIP>:
Code;  c197398a <[rtai]init_module+24a/2f0>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c197398c <[rtai]init_module+24c/2f0>
   2:   8a 00                     mov    (%eax),%al
Code;  c197398e <[rtai]init_module+24e/2f0>
   4:   3c 49                     cmp    $0x49,%al
Code;  c1973990 <[rtai]init_module+250/2f0>
   6:   75 2e                     jne    36 <_EIP+0x36> c19739c0 
<[rtai]init_module+280/2f0>
Code;  c1973992 <[rtai]init_module+252/2f0>
   8:   a1 24 a0 24 c0            mov    0xc024a024,%eax
Code;  c1973997 <[rtai]init_module+257/2f0>
   d:   8b 4c 24 14               mov    0x14(%esp,1),%ecx
Code;  c197399b <[rtai]init_module+25b/2f0>
  11:   8b 04 88                  mov    (%eax,%ecx,4),%eax




