Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286224AbRLJLCn>; Mon, 10 Dec 2001 06:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286226AbRLJLCf>; Mon, 10 Dec 2001 06:02:35 -0500
Received: from [213.196.40.44] ([213.196.40.44]:36554 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S286224AbRLJLC2>;
	Mon, 10 Dec 2001 06:02:28 -0500
Date: Mon, 10 Dec 2001 10:54:17 +0100 (CET)
From: root <root@laptop.blackstar.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Oops at boot time (2.5.1-pre2 - pre8)
Message-ID: <Pine.LNX.4.33.0112101050160.1551-101000@laptop.blackstar.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811581-1532829870-1007978057=:1551"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811581-1532829870-1007978057=:1551
Content-Type: TEXT/PLAIN; charset=US-ASCII

I am getting an oops on boot time, during the partition check.
I am suspecting it has something to do with Advanced Partition support
(since that's what I've got enabled, trying it now).
I'm also including my .config.

Hope this helps,

Bas Vermeulen

ksymoops 2.4.1 on i686 2.5.0.  Options used
     -v /usr/src/linux-2.5.1/vmlinux (specified)
     -k /dev/null (specified)
     -l /dev/null (specified)
     -o /lib/modules/2.5.1-pre8 (specified)
     -m /usr/src/linux-2.5.1/System.map (specified)

Error (regular_file): read_ksyms /dev/null is not a regular file, ignored
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000018
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012d113>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a83
eax: 00000000   ebx: 00000000   ecx: 506230c2   edx: 000001fc
esi: c1571124   edi: 00000001   ebp: 00000001   esp: d3fe1e9a
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=d3fe1000)
Stack: c1055b80 c01517b1 c1055b80 0000003f c1055b80 00000246 0000115c 00000246 
       00000000 c1571124 c02d0270 00000001 00000000 c015190e d3fe75cc c1571124 
       00000000 00000001 c02d0244 c1571124 d3fe75cc 00000000 c0150fd2 d3fe75cc 
Call Trace: [<c01517b1>] [<c015190e>] [<c0150fd2>] [<c01dfa58>] [<c01ea5d2>] 
   [<c0151161>] [<c01dd328>] [<c0105000>] [<c0105039>] [<c0105000>] [<c01055f6>]
   [<c0105030>]
Code: 8b 43 18 a9 00 40 00 00 75 23 ff 4b 14 0f 94 c0 84 c0 74 19 

>>EIP; c012d113 <page_cache_release+3/40>   <=====
Trace; c01517b1 <adfspart_check_ICS+71/f0>
Trace; c015190e <acorn_partition+2e/60>
Trace; c0150fd2 <check_partition+f2/170>
Trace; c01dfa58 <ide_add_setting+88/120>
Trace; c01ea5d2 <ide_cdrom_add_settings+b2/c0>
Trace; c0151161 <grok_partitions+d1/110>
Trace; c01dd328 <ide_geninit+68/90>
Trace; c0105000 <_stext+0/0>
Trace; c0105039 <init+9/140>
Trace; c0105000 <_stext+0/0>
Trace; c01055f6 <kernel_thread+26/30>
Trace; c0105030 <init+0/140>
Code;  c012d113 <page_cache_release+3/40>
00000000 <_EIP>:
Code;  c012d113 <page_cache_release+3/40>   <=====
   0:   8b 43 18                  mov    0x18(%ebx),%eax   <=====
Code;  c012d116 <page_cache_release+6/40>
   3:   a9 00 40 00 00            test   $0x4000,%eax
Code;  c012d11b <page_cache_release+b/40>
   8:   75 23                     jne    2d <_EIP+0x2d> c012d140 <page_cache_release+30/40>
Code;  c012d11d <page_cache_release+d/40>
   a:   ff 4b 14                  decl   0x14(%ebx)
Code;  c012d120 <page_cache_release+10/40>
   d:   0f 94 c0                  sete   %al
Code;  c012d123 <page_cache_release+13/40>
  10:   84 c0                     test   %al,%al
Code;  c012d125 <page_cache_release+15/40>
  12:   74 19                     je     2d <_EIP+0x2d> c012d140 <page_cache_release+30/40>


1 error issued.  Results may not be reliable.

---1463811581-1532829870-1007978057=:1551
Content-Type: APPLICATION/x-gzip; name="config-2.5.1-pre8.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112101054170.1551@laptop.blackstar.nl>
Content-Description: 
Content-Disposition: attachment; filename="config-2.5.1-pre8.gz"

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
UFl7aC6kqH47t9oKuvKxRYSEzCOhX2crsOqqT855C1pko03f1dT+LLLzSguu
BwrlcQPlXUzTI/gKCEK4PoHy5iltNDM4Hb/YnjkFSbzQLy0TVVIpYVeDgyUV
W9GBS3LHEeuAF5T7NOqAIypJeXGvhUiiIPdJdEfjK6qswPRMOhN+vfFN1KCu
D2uLUAc6BrB6q2ICQauVDLTaQz5pAlaRqCHlxokghhX9+/XH62X/bFQOFKYt
yMnTY3UOV09HecpLUaT6oyClATHiKRyAi3LfCjm+vF28h9PZsq00TvWL/8Vn
fke2fkBWbTBLMlUfccJzgTkhcb75MJwMBv002w/DwY1WTy6pPibb1m1NA01W
5ejl1L/uzrsHVa/r3PVaabczV7I4tEt02W3fKy+/XXSdhw0VmGwkZKquQnZJ
E5fnhYH9qom6VTqf5anUnzxcgcBQFssPo5tpY1U5jWXhRa85WFrzbbP+qbZg
dIQt+z/SYkr4KB6L+VSawHQJQWoqUsRNOIlWJgCsfUSYYUGrPlMcttuSO5m0
OsRLWCnS6lTFVfUkGOy0djidiUKwNF2UdBNZ4KoO3oUyYSEtP69+T7QAsxG+
HQ7yVqsUDwGYoqDm9OMJtP3w8M0siBZyvECMKLtrL2wVJLG4ubEXxEt8RBdL
6bz4U9JAIKZG6qHAYjIdOi5SlBrHsuHgzn4TpaRQgu6oftb49lR/tjwoRrBd
PX0ix9PNCutI0aopJz63V4iqvQlHjpJsiXYlISW6UE+E+3ZWMsf9jmq9wIqD
Qwpct8XLYYpLO8q3/Zxo5KhWlURrxGH/+sZiaAFK7apFlzynkNAnvI+ZgsRH
kb2iV9GoC3G98w58e2HlqlbYcchSrX3G/WTBUWiX+XuKB6O8fUezSlguD18f
T1889SZRczVrJPEySIyrXjUMrP8abVvP7q4eIgllQ2rPawPHxfFAukpkKe7t
EeH7DPI/Z8/FhQpJ8NJJQTKe9BJQ/xYC+xa2xs3AREpsnL8wuoGY2nFddzrY
bNzLMBvPbm9DJ17Vfz65OIFZRjmPtZfZxWtM/UkJNt4TSMfJBR/Pp/brI+rE
g7qq5CKJt2k3VAvLW1iXr3vv89Pp5eVHcS3LDG6NY8W2sNZjL7T8Aj7KCRvv
BBVw5iinKuSK2s2kwiHHWySFE9RRKVHtIrvYFu2KV/W2miDXtgU+chmEWnau
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
byNmAAA=
---1463811581-1532829870-1007978057=:1551--
