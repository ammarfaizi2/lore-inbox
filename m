Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSHBXnv>; Fri, 2 Aug 2002 19:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHBXnv>; Fri, 2 Aug 2002 19:43:51 -0400
Received: from u195-95-84-30.dialup.planetinternet.be ([195.95.84.30]:41732
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S317269AbSHBXnr>; Fri, 2 Aug 2002 19:43:47 -0400
Message-Id: <200208022345.g72Njk6m007819@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: martin@dalecki.de
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 unresolved symbol: elv_queue_empty 
In-Reply-To: Your message of "Fri, 02 Aug 2002 11:38:40 +0200."
             <3D4A5320.8070100@evision.ag> 
Date: Sat, 03 Aug 2002 01:45:46 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes having the oops at hand would be rather helpfull.
> Unfortunately I don't have a SCSI system at hand, which makes
> it a bit inconvenient too me to test ide.c compiled as module.

Here it is. I hope it's correct, because it was written down by hand.

Unable to handle kernel NULL pointer dereference at virtual address 
0000002d
c709d418
*pde = 00000000
Oops: 0002
CPU: 1
EIP: 0010:[<c709d418>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c709d4a0  ebx: c5ce2d40  ecx: 0000002d  edx: c50e7cd0
esi: 20000001  edi: c709d4ae  ebp: c50e7cd0  esp: c50e7c84
ds: 0018 es: 0018 ss: 0018
Stack: c0109451 0000000e c70a38a0 c50e7cd0 c50e6000 c02969c0 c50e6000 c50e7cc8
       c0109688 0000000e c50e7cd0 c5ce2d40 c534ea90 00000400 00000000 0000000e
       c5ce2d40 c50e7d50 c0108048 c534ea90 c50e6000 c534ea84 00000400 00000000
Call trace:   [<c0109451>] [<c0109688>] [<c0108048>] [<c01635df>] [<c013deea>]
 [<c013df0c>] [<c0165210>] [<c01654de>] [<c01658c6>] [<c013e1cc>] [<c013e7ca>]
 [<c013f0ed>] [<c016564c>] [<c0165aad>] [<c016564c>] [<c012c3dd>] [<c012bed8>]
 [<c013b7de>] [<c013b9b2>] [<c0107157>]
Code: 01 02 00 00 28 b8 09 c7 9c 75 09 c7 50 76 09 c7 e4 92 09 c7


>>EIP; c709d418 <[ide-mod]ata_irq_request+8/18c>   <=====

>>eax; c709d4a0 <[ide-mod]ata_irq_request+90/18c>
>>ebx; c5ce2d40 <_end+59d883c/6d79afc>
>>edx; c50e7cd0 <_end+4ddd7cc/6d79afc>
>>esi; 20000001 Before first symbol
>>edi; c709d4ae <[ide-mod]ata_irq_request+9e/18c>
>>ebp; c50e7cd0 <_end+4ddd7cc/6d79afc>
>>esp; c50e7c84 <_end+4ddd780/6d79afc>

Trace; c0109451 <handle_IRQ_event+29/4c>
Trace; c0109688 <do_IRQ+c0/154>
Trace; c0108048 <common_interrupt+18/20>
Trace; c01635df <.text.lock.balloc+24/75>
Trace; c013deea <__find_get_block+de/e8>
Trace; c013df0c <__getblk+18/3c>
Trace; c0165210 <ext2_alloc_block+bc/c8>
Trace; c01654de <ext2_alloc_branch+2a/198>
Trace; c01658c6 <ext2_get_block+27a/400>
Trace; c013e1cc <create_empty_buffers+18/d8>
Trace; c013e7ca <__block_prepare_write+17e/3cc>
Trace; c013f0ed <block_prepare_write+21/3c>
Trace; c016564c <ext2_get_block+0/400>
Trace; c0165aad <ext2_prepare_write+19/20>
Trace; c016564c <ext2_get_block+0/400>
Trace; c012c3dd <generic_file_write+505/68c>
Trace; c012bed8 <generic_file_write+0/68c>
Trace; c013b7de <do_readv_writev+1ce/2dc>
Trace; c013b9b2 <sys_writev+5a/6c>
Trace; c0107157 <syscall_call+7/b>

Code;  c709d418 <[ide-mod]ata_irq_request+8/18c>
00000000 <_EIP>:
Code;  c709d418 <[ide-mod]ata_irq_request+8/18c>   <=====
   0:   01 02                     add    %eax,(%edx)   <=====
Code;  c709d41a <[ide-mod]ata_irq_request+a/18c>
   2:   00 00                     add    %al,(%eax)
Code;  c709d41c <[ide-mod]ata_irq_request+c/18c>
   4:   28 b8 09 c7 9c 75         sub    %bh,0x759cc709(%eax)
Code;  c709d422 <[ide-mod]ata_irq_request+12/18c>
   a:   09 c7                     or     %eax,%edi
Code;  c709d424 <[ide-mod]ata_irq_request+14/18c>
   c:   50                        push   %eax
Code;  c709d425 <[ide-mod]ata_irq_request+15/18c>
   d:   76 09                     jbe    18 <_EIP+0x18> c709d430 <[ide-mod]ata_irq_request+20/18c>
Code;  c709d427 <[ide-mod]ata_irq_request+17/18c>
   f:   c7 e4 92 09 c7 00         mov    $0xc70992,%esp

 <0>Kernel panic: Aiee, killing interrupt handler!

Regards,

  MCE

PS: I will have very limited net connectivity till monday evening 
    (European time), so it might take a bit of time in case you want
    me to test any fix for this.

  MCE
-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a36 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

