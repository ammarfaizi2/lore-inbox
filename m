Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTDODWS (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 23:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbTDODWS (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 23:22:18 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24993 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263522AbTDODWQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 23:22:16 -0400
Date: Mon, 14 Apr 2003 20:34:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 583] New: Enabling Coda with Devfs causes Kernel Panic
Message-ID: <18760000.1050377643@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=583

           Summary: Enabling Coda with Devfs causes Kernel Panic
    Kernel Version: 2.5.67
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: qubex@punkass.com


Distribution: Gentoo 1.4_rc 
Hardware Environment: Micron Millenia Transport, P133 (i586) 
Software Environment: i586-pc-linux-gnu, posix threads, gcc 3.2.2 
Problem Description: Compiling Devfs into kernel is fine. Compiling Coda
into kernel is fine.  Compiling Devfs and Coda together is not fine, causes
a kernel panic.   
Sorry, I don't have a console - here is what I can see of the error: 
 
CPU:     0 
EIP:     0060:[<C020605F>]    Not tainted 
EFLAGS: 00010202 
EIP is at vsnprintf+0x2f/0x460 
eax: c2fd3f43    ebx: c2fd3f44   ecx: c040776c   edx: 00000000 
esi: c2fd3f44    edi: 00000000   ebp: c2fd3f24    esp: c2fd3f0c 
ds: 007b    es: 007b    ss: 0068 
Process swapper (pid: 1, threadinfo=c2fd2000 task c2fd0040) 
Stack: 000001f0 c2fd3f2c c2fd3f83 c2fd3f44 c2fd3fa0 00000000 c2fd3f8c
c01a4a62            c2fd3f44 00000040 00000000 c2fd3f98 c01360d1 00000000
00000246 00000043            00000001 00000000 c2fd3f70 c0150e47 00000018
000000d0 00000000 00000001   
[<c01a4a62>] devfs_mk_dir+0x22/0xd0 
[<c01360d1>] kmalloc+0x81/0x99 
[<c0150e47>] register_chrdev_region+0x17/0x120 
[<c0150f6b>] register_chrdev+0x1b/0x20 
[<c019a9ab>] init_coda_psdev+0x4b/0x90 
[<c019b050>] init_once+0x0/0x20 
[<c01050a2>] init+0x32/0x190 
[<c0105070>] init+0x0/0x190 
[<c0107255>] kernel_thread_helper+0x50/0x10 
 
Code: 80 3a 00 74 1d 8a 02 3c 25 74 3d 3b 75 f0 77 05 88 06 8b 55 
<0>Kernel panic: Attempted to kill init! 
 
Steps to reproduce: 
Compile Devfs and Codafs into kernel (have not tested as modules.) This
causes kernel panic  upon boot.

