Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270201AbRIRMh2>; Tue, 18 Sep 2001 08:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270257AbRIRMhS>; Tue, 18 Sep 2001 08:37:18 -0400
Received: from xsmtp.ethz.ch ([129.132.97.6]:46840 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S270201AbRIRMhD> convert rfc822-to-8bit;
	Tue, 18 Sep 2001 08:37:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
content-class: urn:content-classes:message
Subject: new OOPS 2.4.10-pre11, do_generic_file_read [devfs related?]
Date: Tue, 18 Sep 2001 14:34:13 +0200
Message-ID: <3BA73F45.4090704@dplanet.ch>
Thread-Topic: new OOPS 2.4.10-pre11, do_generic_file_read [devfs related?]
Thread-Index: AcFAPqmbtKOyEKv7EdWZHACQJ4nSeQ==
From: "Giacomo Catenazzi" <cate@dplanet.ch>
To: <linux-kernel@vger.kernel.org>, "Richard Gooch" <rgooch@ras.ucalgary.ca>
X-OriginalArrivalTime: 18 Sep 2001 12:37:26.0017 (UTC) FILETIME=[ABF49F10:01C1403E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting in 2.4.10-pre11 I have a new oops.
This time the oops happens also without floppy support,
but also this bug happen at boot time, when mounting root
rw. Also this time the oops seem reproducible.
devfs=nomount solve this bug (like the old bug).


What the status of your devfs rewrite ?

	giacomo


  Receiver lock-up bug exists -- enabling work-around.
Unable to handle kernel NULL pointer dereference at virtual address
00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c0262e00   ebx: cff61e34   ecx: cfb310c0   edx: cff61e34
esi: c13a9034   edi: cfab6cc0   ebp: 00000000   esp: cfa11ed8
ds: 0018   es: 0018   ss: 0018
Process fsck.ext2 (pid: 37, stackpage=cfa11000)
Stack: c0123064 cfb310c0 c13a9034 00000c00 00000001 00000000 00000400
cfab6c20
         00000000 cfe9a420 cfbaeea0 cfa10000 c010fedc cfe9a420 cfbaeea0
080640d4
         cfb310c0 ffffffea 00000000 00000400 c01236af cfb310c0 cfb310e0
cfa11f4c
Call Trace: [<c0123064>] [<c010fedc>] [<c01236af>] [<c01234b0>]
[<c012f410>]
     [<c0136490>] [<c012f26e>] [<c0106d3b>]
Code:  Bad EIP value.

  >>EIP; 00000000 Before first symbol
Trace; c0123064 <do_generic_file_read+2b4/4f0>
Trace; c010fedc <do_page_fault+2fc/4e0>
Trace; c01236ae <generic_file_read+19e/1c0>
Trace; c01234b0 <file_read_actor+0/60>
Trace; c012f410 <sys_read+b0/d0>
Trace; c0136490 <block_llseek+0/a0>
Trace; c012f26e <sys_lseek+6e/80>
Trace; c0106d3a <system_call+32/38>

