Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272505AbTHKUIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272910AbTHKUIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:08:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44684 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272505AbTHKUIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:08:49 -0400
Date: Mon, 11 Aug 2003 13:12:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1084] New: Kernel panic while initializing HP Smart Array (cciss)
Message-ID: <866870000.1060632747@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1084

           Summary: Kernel panic while initializing HP Smart Array (cciss)
    Kernel Version: 2.6.0-test3
            Status: NEW
          Severity: blocking
             Owner: andmike@us.ibm.com
         Submitter: tetsuo@geekbunker.org


Distribution: Red Hat 7.3
Hardware Environment: HP DL380 G3, dual P4 2.4Ghz (hyperthreading), 512Mb, 2 x 
36G discs in RAID 1, HP Smart Array 5i (v. 2.36)
Software Environment: No external packages, just using RH 7.3 .rpm.
GCC version 2.96 (rpm release 110)

Problem Description:
During the boot process, the kernel will panic just after it initializes 
the "Compaq CISS Drive (v.2.5.0)":

Unable to handle kernel NULL pointer dereference at virtual address 0000019a
 printing eip:
c0216249
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0216249>]    Not tainted
EFLAGS: 00010202
EIP is at blk_queue_hardsect_size+0x9/0x20
eax: 00000020 ebx: df79e050 ecx: 00000000 edx: 00000000
esi: 00000000 edi: df7b0002 ebp: 00000000 esp: dff7bee8
ds: 007b es: 007b ss: 0068
Process swapper (pid:1, threadinfo=dff7a000 task=c1527000)
Stack: (lots of hexas)
Call: Trace:
 [<c0387944>] cciss_init_one+0x4d4/0x510
 [<c018b40c>] sysfs_create+0x5c/0x80
 [<c01f6dcc>] pci_device_probe_static+0x2c/0x50
(..)
 <0>Kernel panic: Attempted to kill init!

I have the whole message as a screenshot, which i can send to anyone interested.

Steps to reproduce:
Compile the kernel with Compaq Smart Array 5xxx suport and boot.
Using the same .config file i was able to compile a 2.6.0-test2 which worked 
fine.

