Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310864AbSCSL7t>; Tue, 19 Mar 2002 06:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310959AbSCSL7j>; Tue, 19 Mar 2002 06:59:39 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:55524 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S310864AbSCSL7Y>;
	Tue, 19 Mar 2002 06:59:24 -0500
Message-ID: <017301c1cf3d$7ce4f920$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Oops on 2.4.19-pre2-ac3
Date: Tue, 19 Mar 2002 06:59:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System was pretty busy at the time so I don't know specifiically what
process caused this.
Dual PIII/1Ghz - 2G RAM - 2G swap

ksymoops 2.4.5 on i686 2.4.19-pre2-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre2-ac3/ (default)
     -m /System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c01c4e40, System.map says c0157ef0.  Ignoring ksyms_base entry
Mar 18 14:58:13 yeti kernel: Unable to handle kernel paging request at
virtual address 66b1e3d0
Mar 18 14:58:13 yeti kernel: c01287b0
Mar 18 14:58:13 yeti kernel: *pde = 00000000
Mar 18 14:58:13 yeti kernel: Oops: 0002
Mar 18 14:58:13 yeti kernel: CPU:    0
Mar 18 14:58:13 yeti kernel: EIP:    0010:[do_generic_file_read+1076/1224]
Tainted: P
Mar 18 14:58:13 yeti kernel: EFLAGS: 00010206
Mar 18 14:58:13 yeti kernel: eax: 02000800   ebx: db91bf8c   ecx: c21cd500
edx: 00000000
Mar 18 14:58:13 yeti kernel: esi: c21cd500   edi: ffffffea   ebp: f73b1334
esp: db91bf40
Mar 18 14:58:13 yeti kernel: ds: 0018   es: 0018   ss: 0018
Mar 18 14:58:13 yeti kernel: Process sort (pid: 1516, stackpage=db91b000)
Mar 18 14:58:13 yeti kernel: Stack: 00000000 f790bca0 ffffffea 00003000
00001000 00000000 00000000 00000000
Mar 18 14:58:13 yeti kernel:        00000039 f73b1280 c0128b75 f790bca0
f790bcc0 db91bf8c c0128a20 00000000
Mar 18 14:58:13 yeti kernel:        f790bca0 ffffffea 00003000 00001000
00002000 0805493c 00000000 c0137d0b
Mar 18 14:58:13 yeti kernel: Call Trace: [generic_file_read+129/308]
[file_read_actor+0/212] [sys_read+143/252] [system_call+51/56]
Mar 18 14:58:13 yeti kernel: Code: ff 8b 44 24 20 8b 5c 24 1c 8b 4c 24 30 31
d2 0f 0c 39 44 24
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 02000800 Before first symbol
>>ebx; db91bf8c <_end+1b5d43d8/384d544c>
>>ecx; c21cd500 <_end+1e8594c/384d544c>
>>esi; c21cd500 <_end+1e8594c/384d544c>
>>edi; ffffffea <END_OF_CODE+77273ab/????>
>>ebp; f73b1334 <_end+37069780/384d544c>
>>esp; db91bf40 <_end+1b5d438c/384d544c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 8b 44 24 20 8b         decl   0x8b202444(%ebx)
Code;  00000006 Before first symbol
   6:   5c                        pop    %esp
Code;  00000007 Before first symbol
   7:   24 1c                     and    $0x1c,%al
Code;  00000009 Before first symbol
   9:   8b 4c 24 30               mov    0x30(%esp,1),%ecx
Code;  0000000d Before first symbol
   d:   31 d2                     xor    %edx,%edx
Code;  0000000f Before first symbol
   f:   0f 0c                     (bad)
Code;  00000011 Before first symbol
  11:   39 44 24 00               cmp    %eax,0x0(%esp,1)


1 warning issued.  Results may not be reliable.

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

