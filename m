Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271529AbTGQSND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271563AbTGQSLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:11:03 -0400
Received: from 152.46-136-217.adsl.skynet.be ([217.136.46.152]:3337 "EHLO
	obelix.village-gaulois") by vger.kernel.org with ESMTP
	id S271573AbTGQSGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:06:11 -0400
Subject: Re: a crash of the 2.4.20 when I do emerge dia (ksymoops)
From: Arnaud Ligot <spyroux@freegates.be>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1058443775.1350.15.camel@portable>
References: <1058443775.1350.15.camel@portable>
Content-Type: text/plain
Message-Id: <1058466040.2197.0.camel@portable>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Jul 2003 20:20:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.9 on i586 2.4.20.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.20/ (specified)
     -m /usr/src/linux/System.map (specified)

kernel BUG at namei.c:1088!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c018f0ce>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: 00000000   ebx: ffffffff   ecx: c44a3e58   edx: 00000000
esi: c44a3d18   edi: c44a3df8   ebp: c44a3dd8   esp: c44a3c78
ds: 0018   es: 0018   ss: 0018
Process gcc (pid: 2485, stackpage=c44a3000)
Stack: 00000000 00000000 00000004 c44a3d14 c44a3cb4 0000000f c44a3ef0
81a40a70 
       00000000 00000000 c2f4cac0 c44a3cd4 c02deec7 00000001 00000039
0000c2e1 
       c7f89c00 00001001 ffffffff 00000000 c01a0a70 c44a3d48 00000000
00000001 
Call Trace:    [<c01a0a70>] [<c01280a7>] [<c0136820>] [<c018d4e2>]
[<c0140671>]
  [<c01408ee>] [<c0141139>] [<c01409ae>] [<c0108ce3>]
Code: 0f 0b 40 04 43 e9 2d c0 8b 84 24 e0 01 00 00 8b 94 c4 e4 01 


>>EIP; c018f0ce <reiserfs_rename+24e/8a0>   <=====

>>ecx; c44a3e58 <_end+40ddb34/8d45d3c>
>>esi; c44a3d18 <_end+40dd9f4/8d45d3c>
>>edi; c44a3df8 <_end+40ddad4/8d45d3c>
>>ebp; c44a3dd8 <_end+40ddab4/8d45d3c>
>>esp; c44a3c78 <_end+40dd954/8d45d3c>

Trace; c01a0a70 <reiserfs_delete_solid_item+f0/260>
Trace; c01280a7 <mark_page_accessed+27/40>
Trace; c0136820 <getblk+40/60>
Trace; c018d4e2 <search_by_entry_key+a2/1e0>
Trace; c0140671 <vfs_rename_other+131/380>
Trace; c01408ee <vfs_rename+2e/a0>
Trace; c0141139 <do_rename+179/189>
Trace; c01409ae <sys_rename+4e/80>
Trace; c0108ce3 <system_call+33/40>

Code;  c018f0ce <reiserfs_rename+24e/8a0>
00000000 <_EIP>:
Code;  c018f0ce <reiserfs_rename+24e/8a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c018f0d0 <reiserfs_rename+250/8a0>
   2:   40                        inc    %eax
Code;  c018f0d1 <reiserfs_rename+251/8a0>
   3:   04 43                     add    $0x43,%al
Code;  c018f0d3 <reiserfs_rename+253/8a0>
   5:   e9 2d c0 8b 84            jmp    848bc037 <_EIP+0x848bc037>
Code;  c018f0d8 <reiserfs_rename+258/8a0>
   a:   24 e0                     and    $0xe0,%al
Code;  c018f0da <reiserfs_rename+25a/8a0>
   c:   01 00                     add    %eax,(%eax)
Code;  c018f0dc <reiserfs_rename+25c/8a0>
   e:   00 8b 94 c4 e4 01         add    %cl,0x1e4c494(%ebx)


-- 
Arnaud Ligot <spyroux@freegates.be>

