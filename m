Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbTJJPL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTJJPL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:11:27 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:54233 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262862AbTJJPLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:11:22 -0400
Date: Fri, 10 Oct 2003 08:10:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: kbugs@pelvoux.nildram.co.uk
Subject: [Bug 1339] New: sleeping function called from invalid	context 
Message-ID: <200010000.1065798616@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: sleeping function called from invalid context
    Kernel Version: 2.6.0-test6
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: kbugs@pelvoux.nildram.co.uk


Distribution: Debian Sarge

Hardware Environment:

Gateway PC, Intel Pentium III (Katmai) 450Mhz, Intel 440BX Chipset, 640Mb RAM

Software Environment:

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
e2fsprogs              1.35-WIP
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         nfsd exportfs lockd sunrpc reiserfs 8250 serial_core
eepro100 mii rtc

Problem Description:

The following message appeared on the system log:

Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c011bd58>] __might_sleep+0x88/0x90
 [<c010c55f>] save_v86_state+0x6f/0x1f0
 [<c010d017>] handle_vm86_fault+0xb7/0xa10
 [<c0141e21>] do_no_page+0x191/0x2f0
 [<c0140fc6>] zeromap_pte_range+0x36/0x70
 [<c010b070>] do_general_protection+0x0/0xa0
 [<c010a399>] error_code+0x2d/0x38
 [<c010a1ef>] syscall_call+0x7/0xb

Steps to reproduce:

I don't have a method to reproduce - this just appeared in the log.


