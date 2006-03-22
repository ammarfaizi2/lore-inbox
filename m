Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWCVEGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWCVEGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 23:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWCVEGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 23:06:00 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:4564
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1750738AbWCVEF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 23:05:59 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: BIOS causes (exposes?) modprobe (load_module) kernel oops
Date: Tue, 21 Mar 2006 20:05:58 -0800
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603212005.58274.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.14.2, yeah, I know, and sorry if this has been fixed...but read on, please,
this is a new take...

So everything else is equal...same rootfs, same command line, same
kernel, and same modules...

When I boot my x86 board with one BIOS (and bootloader, not to forget that),
I can modprobe 'til the proverbial cows come home...

With the other BIOS (and its own bootloader), modprobe'ing ANY module gets this:

# modprobe ide-core
Unable to handle kernel paging request at virtual address e081e000
 printing eip:
c0127ae5
*pde = 01774067
*pte = 1fa6b01e
Oops: 0002 [#1]
SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0127ae5>]    Not tainted VLI
EFLAGS: 00010202   (2.6.14.2-2-zbios) 
eax: 00000000   ebx: e08128f0   ecx: 00004ac4   edx: 00012b10
esi: 00012b10   edi: e081e000   ebp: 00000000   esp: df863f3c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 265, threadinfo=df862000 task=dfe31030)
Stack: c17b1f60 e081e000 00000000 e0812380 00000000 00000000 00000000 00000000 
       0000000d 00000011 00000000 00000018 00000009 00000000 0000000f 0000001f 
       0000001e 00000020 e0819298 e0804000 b7e76000 df862000 b7f162f4 df862000 
Call Trace:
 [<c0127f98>]
 [<c010271d>]
Code: 89 44 24 18 83 c4 14 83 7c 24 04 00 0f 84 0a 04 00 00 8b 7c 24 0c 31 ed 89 e8 8b b7 bc 00 00 00 8b 7c 24 04 89 f1  
 Segmentation fault

I've seen others post similar issues, but no one has correlated it to a BIOS issue.

Can anybody suggest to me why on earth BIOS would matter when
modprobe'ing???  I'm a BIOS engineer, and I can fix my own @#$%, but
I cannot fathom the connection, at least not while I can pass a breathalizer test...

Thanks,
John

P.S.:  I've not been able to find any other problems or issues on either BIOS.  Modules
that were linked in at build time (full USB stack, a couple of SCSI mods., and a few
network mods. all work fine...), and no other manifestations that anything is amiss...
I can provide more details, but all I'm looking for is a hint at what the connection between
load_module and BIOS might be...I can probably take it from there...

