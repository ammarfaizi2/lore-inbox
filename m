Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285476AbRLNT6I>; Fri, 14 Dec 2001 14:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285473AbRLNT56>; Fri, 14 Dec 2001 14:57:58 -0500
Received: from sammy.netpathway.com ([208.137.139.2]:22159 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S285476AbRLNT5o>; Fri, 14 Dec 2001 14:57:44 -0500
Message-ID: <3C1CF015.1B8C525@netpathway.com>
Date: Sun, 16 Dec 2001 13:03:50 -0600
From: Gary White <gary@netpathway.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.17-rc1 boot problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the output from ksymoops

ksymoops 2.4.1 on i686 2.4.16.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.17-rc1 (specified)
     -m /System.map (specified)

No modules in ksyms, skipping objects
cpu: 0, clocks: 2018132, slice: 1009066
8139too Fast Ethernet driver 0.9.22
CPU:    0
EIP:    0010:[<c018ec3e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000003   ebx: 00001000   ecx: 00000000   edx: 00000000
esi: 00001000   edi: 00000000   ebp: de659c34   esp: de659b8c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 22, stackpage=de659000)
Stack: 00000000 de5a74c0 00000000 00001000 00000000 00000000 00000000 00000001
       de5a8198 00001000 00000001 00000000 de597000 de5b98c0 0004a292 0004a13d
       00000001 000001f4 00300002 00000768 0004a292 0004a13d 00000001 0000022b
Call Trace: [<c018ef1a>] [<c01130f0>] [<c011cb42>] [<c011c446>] [<c0119c1a>]
   [<c0119b40>] [<c011994a>] [<c01083ad>] [<c010a278>] [<c018ed46>] [<c013262e>]
   [<c0132c32>] [<c018ed30>] [<c0190d0a>] [<c018ed30>] [<c0190de0>] [<c0197d8e>]
   [<c0195ad8>] [<c01a59f8>] [<c01963c7>] [<c0134d4e>] [<c0143c65>] [<c0143eff>]
   [<c0143dad>] [<c0143fe4>] [<c0106e5f>]
Code: 0f 0b 83 bd 6c ff ff ff 00 75 0d 8b bd 78 ff ff ff 31 f6 8b

>>EIP; c018ec3e <_get_block_create_0+55e/610>   <=====
Trace; c018ef1a <reiserfs_get_block+ca/cf0>
Trace; c01130f0 <process_timeout+0/50>
Trace; c011cb42 <timer_bh+222/260>
Trace; c011c446 <tqueue_bh+16/20>
Trace; c0119c1a <bh_action+1a/50>
Trace; c0119b40 <tasklet_hi_action+40/60>
Trace; c011994a <do_softirq+5a/b0>
Trace; c01083ad <do_IRQ+9d/b0>
Trace; c010a278 <call_do_IRQ+5/d>
Trace; c018ed46 <reiserfs_get_block_create_0+16/20>
Trace; c013262e <__block_prepare_write+9e/200>
Trace; c0132c32 <block_prepare_write+22/40>
Trace; c018ed30 <reiserfs_get_block_create_0+0/20>
Trace; c0190d0a <grab_tail_page+8a/110>
Trace; c018ed30 <reiserfs_get_block_create_0+0/20>
Trace; c0190de0 <reiserfs_truncate_file+50/160>
Trace; c0197d8e <reiserfs_warning+1e/30>
Trace; c0195ad8 <finish_unfinished+1e8/2a0>
Trace; c01a59f8 <do_journal_end+a78/a90>
Trace; c01963c7 <reiserfs_remount+147/160>
Trace; c0134d4e <do_remount_sb+8e/c0>
Trace; c0143c65 <do_remount+75/a0>
Trace; c0143eff <do_mount+ff/160>
Trace; c0143dad <copy_mount_options+4d/a0>
Trace; c0143fe4 <sys_mount+84/d0>
Trace; c0106e5f <system_call+33/38>
Code;  c018ec3e <_get_block_create_0+55e/610>
0000000000000000 <_EIP>:
Code;  c018ec3e <_get_block_create_0+55e/610>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c018ec40 <_get_block_create_0+560/610>
   2:   83 bd 6c ff ff ff 00      cmpl   $0x0,0xffffff6c(%ebp)
Code;  c018ec47 <_get_block_create_0+567/610>
   9:   75 0d                     jne    18 <_EIP+0x18> c018ec56 <_get_block_create_0+576/610>
Code;  c018ec49 <_get_block_create_0+569/610>
   b:   8b bd 78 ff ff ff         mov    0xffffff78(%ebp),%edi
Code;  c018ec4f <_get_block_create_0+56f/610>
  11:   31 f6                     xor    %esi,%esi
Code;  c018ec51 <_get_block_create_0+571/610>
  13:   8b 00                     mov    (%eax),%eax

ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708

