Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRATPRp>; Sat, 20 Jan 2001 10:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRATPRf>; Sat, 20 Jan 2001 10:17:35 -0500
Received: from mout0.freenet.de ([194.97.50.131]:1713 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S129610AbRATPRT>;
	Sat, 20 Jan 2001 10:17:19 -0500
From: mkloppstech@freenet.de
Message-Id: <200101201246.NAA15788@john.epistle>
Subject: oops,  signal 11
To: linux-kernel@vger.kernel.org
Date: Sat, 20 Jan 2001 13:46:50 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM979994810-15761-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM979994810-15761-0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I know that signal 11 with gcc is a sign of bad hardware; however  it
strikes me that I don't get random oopses - a whole bunch of them is appended.

I used 2.4.0 with alsa, kmp3player running and an endless loop compiling the
kernel.

Mirko Kloppstech

--ELM979994810-15761-0_
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: attachment; filename=tmp2.oops
Content-Description: /tmp/tmp2.oops
Content-Transfer-Encoding: 7bit

ksymoops 2.3.7 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map (specified)

Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 ccaafcc0 ccaafce0 cb09df90 
       c0124530 ffffffea ccaafcc0 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)
Code;  00000003 Before first symbol
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> fffffff5 <END_OF_CODE+2f7904e2/????>
Code;  00000005 Before first symbol
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  00000009 Before first symbol
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  0000000c Before first symbol
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> fffffff5 <END_OF_CODE+2f7904e2/????>
Code;  0000000e Before first symbol
   e:   53                        pushl  %ebx
Code;  0000000f Before first symbol
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> 00004d61 Before first symbol

Unable to handle kernel paging request at virtual address 00003640
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 00003638   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cad1ff40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15018, stackpage=cad1f000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cbe42340 cbe42360 cad1ff90 
       c0124530 ffffffea cbe42340 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 00003659
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 00003651   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: ca31df40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15039, stackpage=ca31d000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cc5fed40 cc5fed60 ca31df90 
       c0124530 ffffffea cc5fed40 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 00003663
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 0000365b   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cb09df40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15089, stackpage=cb09d000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 ccfa5440 ccfa5460 cb09df90 
       c0124530 ffffffea ccfa5440 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 00003663
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 0000365b   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: ca31df40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15110, stackpage=ca31d000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cbe42a40 cbe42a60 ca31df90 
       c0124530 ffffffea cbe42a40 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 0000366f
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 00003667   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c8ebff40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15160, stackpage=c8ebf000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cd4ff3c0 cd4ff3e0 c8ebff90 
       c0124530 ffffffea cd4ff3c0 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 00003671
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 00003669   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c96cdf40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15182, stackpage=c96cd000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 ccaafec0 ccaafee0 c96cdf90 
       c0124530 ffffffea ccaafec0 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 00003676
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 0000366e   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cadaff40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15232, stackpage=cadaf000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cbe42840 cbe42860 cadaff90 
       c0124530 ffffffea cbe42840 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 00003676
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 0000366e   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cb709f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15253, stackpage=cb709000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cd4ff5c0 cd4ff5e0 cb709f90 
       c0124530 ffffffea cd4ff5c0 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 0000369f
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 00003697   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c96cdf40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15303, stackpage=c96cd000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cc5fedc0 cc5fede0 c96cdf90 
       c0124530 ffffffea cc5fedc0 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 0000369f
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 00003697   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cadaff40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15324, stackpage=cadaf000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 ccf89940 ccf89960 cadaff90 
       c0124530 ffffffea ccf89940 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036a2
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 0000369a   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cb709f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15374, stackpage=cb709000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 ccf89e40 ccf89e60 cb709f90 
       c0124530 ffffffea ccf89e40 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036a2
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 0000369a   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c96cdf40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15395, stackpage=c96cd000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c91217c0 c91217e0 c96cdf90 
       c0124530 ffffffea c91217c0 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036a2
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 0000369a   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c9127f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15445, stackpage=c9127000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 cbe42740 cbe42760 c9127f90 
       c0124530 ffffffea cbe42740 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036c5
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 000036bd   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cb709f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15466, stackpage=cb709000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c9121440 c9121460 cb709f90 
       c0124530 ffffffea c9121440 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036c5
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 000036bd   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c96cdf40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15516, stackpage=c96cd000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c9fa8740 c9fa8760 c96cdf90 
       c0124530 ffffffea c9fa8740 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036c5
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 000036bd   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c9127f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15537, stackpage=c9127000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c9121a40 c9121a60 c9127f90 
       c0124530 ffffffea c9121a40 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036c5
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 000036bd   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cb709f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15587, stackpage=cb709000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c9fa84c0 c9fa84e0 cb709f90 
       c0124530 ffffffea c9fa84c0 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036cd
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010206
eax: cff40000   ebx: 000036c5   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c96cdf40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15608, stackpage=c96cd000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c91219c0 c91219e0 c96cdf90 
       c0124530 ffffffea c91219c0 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000036d8
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 000036d0   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: c9127f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15658, stackpage=c9127000)
Stack: 000027ad 0809ab20 00000000 bfffd900 c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c9dc30c0 c9dc30e0 c9127f90 
       c0124530 ffffffea c9dc30c0 000027ad 00001000 000017ad 0809bb20 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>

Unable to handle kernel paging request at virtual address 000037fa
c012414f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012414f>]
EFLAGS: 00010202
eax: cff40000   ebx: 000037f2   ecx: 00000010   edx: cff7ea64
esi: cca70780   edi: cca70824   ebp: 00001000   esp: cb709f40
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 15694, stackpage=cb709000)
Stack: 000027ad 08140b88 00000000 bfffe03c c125abd8 00000000 cff7ea64 00000001 
       00000000 00000001 cca70824 cca70780 c01245f3 c9fa8cc0 c9fa8ce0 cb709f90 
       c0124530 ffffffea c9fa8cc0 000027ad 00001000 000017ad 08141b88 00000000 
Call Trace: [<c01245f3>] [<c0124530>] [<c013029e>] [<c0108f27>] 
Code: 39 7b 08 75 f0 8b 74 24 24 39 73 0c 75 e7 53 e8 4d 4d 00 00 

>>EIP; c012414f <do_generic_file_read+1af/590>   <=====
Trace; c01245f3 <generic_file_read+63/80>
Trace; c0124530 <file_read_actor+0/60>
Trace; c013029e <sys_read+8e/d0>
Trace; c0108f27 <system_call+33/38>
Code;  c012414f <do_generic_file_read+1af/590>
00000000 <_EIP>:
Code;  c012414f <do_generic_file_read+1af/590>   <=====
   0:   39 7b 08                  cmpl   %edi,0x8(%ebx)   <=====
Code;  c0124152 <do_generic_file_read+1b2/590>
   3:   75 f0                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c0124154 <do_generic_file_read+1b4/590>
   5:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0124158 <do_generic_file_read+1b8/590>
   9:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c012415b <do_generic_file_read+1bb/590>
   c:   75 e7                     jne    fffffff5 <_EIP+0xfffffff5> c0124144 <do_generic_file_read+1a4/590>
Code;  c012415d <do_generic_file_read+1bd/590>
   e:   53                        pushl  %ebx
Code;  c012415e <do_generic_file_read+1be/590>
   f:   e8 4d 4d 00 00            call   4d61 <_EIP+0x4d61> c0128eb0 <age_page_up+0/30>


--ELM979994810-15761-0_--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
