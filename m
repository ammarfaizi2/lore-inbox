Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTJOLVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 07:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTJOLVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 07:21:17 -0400
Received: from [144.132.162.109] ([144.132.162.109]:40954 "EHLO
	tigers-lfs.local") by vger.kernel.org with ESMTP id S262772AbTJOLVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 07:21:15 -0400
Date: Wed, 15 Oct 2003 21:19:47 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: NPTL, the Kernel & GCC version
Message-ID: <20031015111947.GA297@tigers-lfs.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I've been having grief for quite a while when running the NPTL test suite.
The last report I sent is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106583848317628&w=2

Up until now, I've been compiling the 2.6.0-test kernels with gcc-2.95.4.
Today I tried compiling the kernel with gcc-3.2.3 and voila! No more
crashes, oopses or nasty lockups! And the NPTL test suite almost passed!
(only 1 failure). Joy o joy.

Anyway, I thought you guys might find this tidbit interesting. I wouldn't
know where to start to try and figure out what goes wrong with the older
gcc, but I'd be happy to pass on info if required.

Latest oops is attached for the record.

Thanks
Greg
(not subscribed)

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

Oct 15 20:25:46 tigers-lfs kernel: Unable to handle kernel paging request at virtual address 40071f40
Oct 15 20:25:46 tigers-lfs kernel:  printing eip:
Oct 15 20:25:46 tigers-lfs kernel: 40071f40 
Oct 15 20:25:46 tigers-lfs kernel: *pde = 0a2fb067
Oct 15 20:25:46 tigers-lfs kernel: *pte = 00000000
Oct 15 20:25:46 tigers-lfs kernel: Oops: 0004 [#1]
Oct 15 20:25:46 tigers-lfs kernel: CPU:    1
Oct 15 20:25:46 tigers-lfs kernel: EIP:    0073:[<40071f40>]    Not tainted
Oct 15 20:25:46 tigers-lfs kernel: EFLAGS: 00010246
Oct 15 20:25:46 tigers-lfs kernel: EIP is at 0x40071f40 
Oct 15 20:25:46 tigers-lfs kernel: eax: 00000003   ebx: 4294ca7c   ecx: 00000000   edx: 4000fc60
Oct 15 20:25:46 tigers-lfs kernel: esi: 00000000   edi: 00000000   ebp: 4294cab8   esp: 4294ca68
Oct 15 20:25:46 tigers-lfs kernel: ds: 007b   es: 007b   ss: 007b
Oct 15 20:25:46 tigers-lfs kernel: Process ld-linux.so.2 (pid: 11356, threadinfo=e5e78000 task=d14ccc80)
Oct 15 20:25:46 tigers-lfs kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000038
Oct 15 20:25:46 tigers-lfs kernel:  printing eip:
Oct 15 20:25:46 tigers-lfs kernel: c012116c
Oct 15 20:25:46 tigers-lfs kernel: *pde = 00000000
Oct 15 20:25:46 tigers-lfs kernel: Oops: 0000 [#2]
Oct 15 20:25:46 tigers-lfs kernel: CPU:    1
Oct 15 20:25:46 tigers-lfs kernel: EIP:    0060:[do_exit+892/976]    Not tainted
Oct 15 20:25:46 tigers-lfs kernel: EFLAGS: 00010292
Oct 15 20:25:46 tigers-lfs kernel: EIP is at do_exit+0x37c/0x3d0
Oct 15 20:25:46 tigers-lfs kernel: eax: 00000000   ebx: e5e78000   ecx: f7fff0c0   edx: d14cd274
Oct 15 20:25:46 tigers-lfs kernel: esi: 00000000   edi: d14ccc80   ebp: e5e79eec   esp: e5e79ee0
Oct 15 20:25:46 tigers-lfs kernel: ds: 007b   es: 007b   ss: 0068
Oct 15 20:25:46 tigers-lfs kernel: Process ld-linux.so.2 (pid: 11356, threadinfo=e5e78000 task=d14ccc80)
Oct 15 20:25:46 tigers-lfs kernel: Stack: e5e78000 00000004 e5e79fc4 e5e79f04 c010a32d 0000000b 00000000 d14ccc80
Oct 15 20:25:46 tigers-lfs kernel:        00000071 e5e79fb4 c01181fd c02c4ebe e5e79fc4 00000004 4294ca7c 00000004
Oct 15 20:25:46 tigers-lfs kernel:        c0117f20 00000238 e5e79f84 c011a4a0 c1a13c00 e5e79f84 00000046 00030001
Oct 15 20:25:46 tigers-lfs kernel: Call Trace:
Oct 15 20:25:46 tigers-lfs kernel:  [die+221/224] die+0xdd/0xe0
Oct 15 20:25:46 tigers-lfs kernel:  [do_page_fault+733/1042] do_page_fault+0x2dd/0x412
Oct 15 20:25:46 tigers-lfs kernel:  [do_page_fault+0/1042] do_page_fault+0x0/0x412
Oct 15 20:25:46 tigers-lfs kernel:  [schedule+432/1616] schedule+0x1b0/0x650
Oct 15 20:25:46 tigers-lfs kernel:  [exit_notify+1659/1712] exit_notify+0x67b/0x6b0
Oct 15 20:25:46 tigers-lfs kernel:  [do_exit+949/976] do_exit+0x3b5/0x3d0
Oct 15 20:25:46 tigers-lfs kernel:  [do_group_exit+214/224] do_group_exit+0xd6/0xe0
Oct 15 20:25:46 tigers-lfs kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 15 20:25:46 tigers-lfs kernel:
Oct 15 20:25:46 tigers-lfs kernel: Code: 83 78 38 00 74 0a 6a 01 e8 97 1f 0d 00 83 c4 04 8b 55 08 89

--sm4nu43k4a2Rpi4c--
