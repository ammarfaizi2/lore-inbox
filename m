Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTHTBhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTHTBhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:37:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34517 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S261482AbTHTBhu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:37:50 -0400
Date: Tue, 19 Aug 2003 21:35:14 +0200
From: Enrico Demarin <enricod@videotron.ca>
Subject: RE: SMP oops on Xseries235
In-reply-to: <20030819182738.65296132.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Message-id: <005701c36689$030e08f0$0440a8c0@SC2003002>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook, Build 10.0.3416
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I decoded using the System map from the crashing kernel : I plan to
organize one more "crasher" and to provide
 a fresh report with proper decoding by the end of this week.


- Enrico

kernel BUG at transaction.c:1416!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0169ddc>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000063   ebx: 00000001   ecx: 00000002   edx: f6f7ff44
esi: f37f61c0   edi: ef2a27a0   ebp: f7bd7200   esp: eef559a8
ds: 0018   es: 0018   ss: 0018
Process rateup (pid: 13992, stackpage=eef55000)
Stack: c027c1e0 c027a679 c027a4b9 00000588 c027e120 00000000 00000000
ef2a27a0
       f45ba640 ef2a27a0 c0163a79 ef2a27a0 00000000 00000000 efa375e0
00000000
       f063afa0 f37f61c0 f7bd7200 ef2a27a0 f45ba640 f7bd7400 00000007
c014ea92
Call Trace:    [<c0163a79>] [<c014ea92>] [<c015e3ee>] [<c01694fd>]
[<c013c1c8>]
  [<c013c1d9>] [<c0169b3f>] [<c01635a9>] [<c0163607>] [<c020b96c>]
[<c020bafa>]
  [<c0245337>] [<c01694fd>] [<c01694fd>] [<c013c438>] [<c01635a9>]
[<c0163607>]
  [<c016955f>] [<c0163911>] [<c01694fd>] [<c016078d>] [<c0160ab5>]
[<c01694fd>]
  [<c01694fd>] [<c01694fd>] [<f89a887b>] [<c0169b3f>] [<c01635a9>]
[<c0163607>]
  [<c016114b>] [<c01694fd>] [<c013c438>] [<c013c652>] [<c016127c>]
[<c013cc09>]
  [<c01638a5>] [<c013d595>] [<c0161220>] [<c0168b5d>] [<c01617a5>]
[<c0161220>]
  [<c0163a79>] [<c012d9a2>] [<c0114ff6>] [<c015f262>] [<c013a206>]
[<c0108c43>]
Code: 0f 0b 88 05 b9 a4 27 c0 83 c4 14 f6 47 18 04 ba 01 00 00 00


>>EIP; c0169ddc <journal_stop+6c/190>   <=====

>>edx; f6f7ff44 <END_OF_CODE+36c01f70/????>
>>esi; f37f61c0 <END_OF_CODE+334781ec/????>
>>edi; ef2a27a0 <END_OF_CODE+2ef247cc/????>
>>ebp; f7bd7200 <END_OF_CODE+3785922c/????>
>>esp; eef559a8 <END_OF_CODE+2ebd79d4/????>

Trace; c0163a79 <ext3_dirty_inode+a9/100>
Trace; c014ea92 <__mark_inode_dirty+32/b0>
Trace; c015e3ee <ext3_new_block+be/840>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; c013c1c8 <getblk+28/60>
Trace; c013c1d9 <getblk+39/60>
Trace; c0169b3f <journal_dirty_metadata+15f/190>
Trace; c01635a9 <ext3_do_update_inode+2f9/380>
Trace; c0163607 <ext3_do_update_inode+357/380>
Trace; c020b96c <kfree_skbmem+c/70>
Trace; c020bafa <__kfree_skb+12a/130>
Trace; c0245337 <tcp_rcv_established+107/880>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; c013c438 <bread+18/70>
Trace; c01635a9 <ext3_do_update_inode+2f9/380>
Trace; c0163607 <ext3_do_update_inode+357/380>
Trace; c016955f <journal_get_write_access+3f/60>
Trace; c0163911 <ext3_reserve_inode_write+31/b0>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; c016078d <ext3_alloc_block+1d/30>
Trace; c0160ab5 <ext3_alloc_branch+55/2d0>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; f89a887b <END_OF_CODE+3862a8a7/????>
Trace; c0169b3f <journal_dirty_metadata+15f/190>
Trace; c01635a9 <ext3_do_update_inode+2f9/380>
Trace; c0163607 <ext3_do_update_inode+357/380>
Trace; c016114b <ext3_get_block_handle+21b/2f0>
Trace; c01694fd <do_get_write_access+52d/550>
Trace; c013c438 <bread+18/70>
Trace; c013c652 <create_buffers+62/100>
Trace; c016127c <ext3_get_block+5c/70>
Trace; c013cc09 <__block_prepare_write+f9/320>
Trace; c01638a5 <ext3_mark_iloc_dirty+25/60>
Trace; c013d595 <block_prepare_write+25/80>
Trace; c0161220 <ext3_get_block+0/70>
Trace; c0168b5d <journal_start+7d/a0>
Trace; c01617a5 <ext3_prepare_write+d5/200>
Trace; c0161220 <ext3_get_block+0/70>
Trace; c0163a79 <ext3_dirty_inode+a9/100>
Trace; c012d9a2 <generic_file_write+522/810>
Trace; c0114ff6 <do_page_fault+1a6/4db>
Trace; c015f262 <ext3_file_write+22/b0>
Trace; c013a206 <sys_write+96/110>
Trace; c0108c43 <system_call+33/38>

Code;  c0169ddc <journal_stop+6c/190>
00000000 <_EIP>:
Code;  c0169ddc <journal_stop+6c/190>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0169dde <journal_stop+6e/190>
   2:   88 05 b9 a4 27 c0         mov    %al,0xc027a4b9
Code;  c0169de4 <journal_stop+74/190>
   8:   83 c4 14                  add    $0x14,%esp
Code;  c0169de7 <journal_stop+77/190>
   b:   f6 47 18 04               testb  $0x4,0x18(%edi)
Code;  c0169deb <journal_stop+7b/190>
   f:   ba 01 00 00 00            mov    $0x1,%edx

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andrew Morton
> Sent: mercoledì 20 agosto 2003 3.28
> To: Enrico Demarin
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: SMP oops on Xseries235
> 
> 
> Enrico Demarin <enricod@videotron.ca> wrote:
> >
> >  Assertion failure in journal_stop() at transaction.c:1416:
> >  "journal_current_handle() == handle"
> >  kernel BUG at transaction.c:1416!
> 
> Please decode this trace with ksymoops.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

