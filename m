Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTEWOU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 10:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTEWOU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 10:20:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:46757 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262963AbTEWOU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 10:20:26 -0400
Date: Fri, 23 May 2003 07:33:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 741] New: [2.5.69-bk14] Unable to handle kernel null pointer
Message-ID: <26380000.1053700405@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: [2.5.69-bk14] Unable to handle kernel null pointer
    Kernel Version: 2.5.69-bk14
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: s.rivoir@gts.it


Distribution: Debian sid 
Hardware Environment: HP Omnibook XE3l 
Software Environment: kernel 2.5.69-bk14 
Problem Description: 
 
I get this everytime I run SVGATextMode with a resolution with more than 43 
rows; I'm not sure that this failure it's a kernel bug, but I suppose it 
should not give this error anyway... 
 
Steps to reproduce: 
 
# SVGATextMode "80x50x9" 
<1>Unable to handle kernel NULL pointer dereference at virtual address 
00000010 
 printing eip: 
 c01be43c 
 *pde = 00000000 
 Oops: 0002 [#9] 
 CPU:    0 
 EIP:    0060:[<c01be43c>]    Not tainted 
 EFLAGS: 00013202 
 EIP is at vt_ioctl+0x1b3c/0x1d30 
 eax: 00000000   ebx: 000001e0   ecx: 00000000   edx: 00000000 
 esi: 00000006   edi: 0000000c   ebp: 00000050   esp: c642fea8 
 ds: 007b   es: 007b   ss: 0068 
 Process SVGATextMode (pid: 342, threadinfo=c642e000 task=c6af0d00) 
 Stack: 00000005 00000050 00000028 00000001 c01c6b90 00000009 00000028 
c7113000 
        c66e7540 c642fedc c7639ca0 c71eb940 00000101 c7113000 00000001 
00000000 
        c71eb940 c11e67bc 00000001 c6f95000 000003e8 c015630c 000003e8 
c11e67bc 
 Call Trace: 
  [<c01c6b90>] con_open+0x0/0x90 
  [<c015630c>] vfs_permission+0x7c/0x120 
  [<c015223d>] get_chrfops+0x2d/0x90 
  [<c015258a>] chrdev_open+0x6a/0xc0 
  [<c0148b7a>] dentry_open+0x1ea/0x220 
  [<c01bc900>] vt_ioctl+0x0/0x1d30 
  [<c01b5e6c>] tty_ioctl+0x45c/0x570 
  [<c015ada0>] sys_ioctl+0x100/0x280 
  [<c010922b>] syscall_call+0x7/0xb 
 
 Code: 89 58 10 66 85 ff 74 0a 8b 04 b5 60 7a 2f c0 89 78 68 89 34 
  Segmentation fault

