Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316852AbSF1NG3>; Fri, 28 Jun 2002 09:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSF1NG2>; Fri, 28 Jun 2002 09:06:28 -0400
Received: from mail305.mail.bellsouth.net ([205.152.58.165]:33409 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S316852AbSF1NG1>; Fri, 28 Jun 2002 09:06:27 -0400
Date: Fri, 28 Jun 2002 09:08:09 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.4.19-rc1 unlock_page
Message-ID: <Pine.LNX.4.43.0206280904250.25987-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

logger:/home/bwindle# ksymoops -m /root/System.map-2.4.19-rc1 < oops.txt
ksymoops 2.4.5 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /root/System.map-2.4.19-rc1 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012390c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c10238d8   ecx: 0000001c   edx: c0234ca0
esi: c1058070   edi: 00000001   ebp: c0f9febc   esp: c0f9feb4
ds: 0018   es: 0018   ss: 0018
Process bb-combo.sh (pid: 6070, stackpage=c0f9f000)
Stack: c10238d8 00000000 c0f9fed8 c01210e6 c10238d8 4005aa64 c0e70b54
00000001
       c102afc8 c0f9ff00 c0121806 c0e70b54 c0bb6d30 4005aa64 c0b51168
00ced065
       c0e70b54 00000001 c0bb6d30 c0f9ffb4 c01116bb c0e70b54 c0bb6d30
4005aa64
Call Trace: [<c01210e6>] [<c0121806>] [<c01116bb>] [<c011153c>]
[<c0136d7a>]
   [<c012f457>] [<c01088d0>]
Code: 0e 31 c9 ba 03 00 00 00 89 f0 e8 15 e9 fe ff 5b 5e 89 ec 5d


>>EIP; c012390c <unlock_page+54/6c>   <=====

>>ebx; c10238d8 <END_OF_CODE+d789a0/????>
>>edx; c0234ca0 <contig_page_data+0/340>
>>esi; c1058070 <END_OF_CODE+dad138/????>
>>ebp; c0f9febc <END_OF_CODE+cf4f84/????>
>>esp; c0f9feb4 <END_OF_CODE+cf4f7c/????>

Trace; c01210e6 <do_wp_page+4a/1f0>
Trace; c0121806 <handle_mm_fault+7a/b4>
Trace; c01116bb <do_page_fault+17f/4c2>
Trace; c011153c <do_page_fault+0/4c2>
Trace; c0136d7a <pipe_write+206/254>
Trace; c012f457 <sys_write+e3/f0>
Trace; c01088d0 <error_code+34/3c>

Code;  c012390c <unlock_page+54/6c>
00000000 <_EIP>:
Code;  c012390c <unlock_page+54/6c>   <=====
   0:   0e                        push   %cs   <=====
Code;  c012390d <unlock_page+55/6c>
   1:   31 c9                     xor    %ecx,%ecx
Code;  c012390f <unlock_page+57/6c>
   3:   ba 03 00 00 00            mov    $0x3,%edx
Code;  c0123914 <unlock_page+5c/6c>
   8:   89 f0                     mov    %esi,%eax
Code;  c0123916 <unlock_page+5e/6c>
   a:   e8 15 e9 fe ff            call   fffee924 <_EIP+0xfffee924>
c0112230 <__wake_up+0/98>
Code;  c012391b <unlock_page+63/6c>
   f:   5b                        pop    %ebx
Code;  c012391c <unlock_page+64/6c>
  10:   5e                        pop    %esi
Code;  c012391d <unlock_page+65/6c>
  11:   89 ec                     mov    %ebp,%esp
Code;  c012391f <unlock_page+67/6c>
  13:   5d                        pop    %ebp


1 warning issued.  Results may not be reliable.

System is a PPro200 with 32mb ram, 128mb swap, running BigBrother, MRTG,
and acting as a syslogd server; it survived the oops.

Linux version 2.4.19-rc1 (root@logger) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Mon Jun 24 13:32:47 EDT 2002


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


