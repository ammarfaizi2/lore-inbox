Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTDQPBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTDQPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:01:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:6823 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261598AbTDQPBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:01:13 -0400
Date: Thu, 17 Apr 2003 08:13:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 594] New: Get repeatly Debug: sleeping function called from
 illegal context at mm/slab.c:1658 
Message-ID: <10590000.1050592385@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=594

           Summary: Get repeatly Debug: sleeping function called from
                    illegal context at mm/slab.c:1658
    Kernel Version: 2.5.67-vanilla
            Status: NEW
          Severity: high
             Owner: akpm@digeo.com
         Submitter: torden88@yahoo.no


Distribution: Linux From Scratch
Hardware Environment:Athlon XP 1600+, VIA KT266a, 256mb TwinMOS DDR ram
Software Environment:GCC 3.2.2, glibc 2.3.2
Problem Description:
I get this message repeatly (about 1 second between each time), after the
system as been up for about 5 minutes(even in runlevel 1).
It does NOT come when I am in X, but when i switch to the console, it
appears.

Debug: sleeping function called from illegal context at mm/slab.c:1658
Call Trace:
 [<c01186bf>] __might_sleep+0x5f/0xa0
 [<c0137df9>] kmalloc+0x89/0x90
 [<c0283425>] accel_cursor+0xd5/0x300
 [<c0283845>] fb_vbl_handler+0x85/0xa0
 [<c0123be4>] group_send_sig_info+0x1c4/0x510
 [<c0281e40>] cursor_timer_handler+0x0/0x40
 [<c0281e61>] cursor_timer_handler+0x21/0x40
 [<c012242c>] run_timer_softirq+0x8c/0x170
 [<c010e864>] timer_interrupt+0x54/0x140
 [<c011e5e1>] do_softirq+0xa1/0xb0
 [<c010ad18>] do_IRQ+0x108/0x130
 [<c0107040>] default_idle+0x0/0x30
 [<c0107040>] default_idle+0x0/0x30
 [<c0109408>] common_interrupt+0x18/0x20
 [<c0107040>] default_idle+0x0/0x30
 [<c0107040>] default_idle+0x0/0x30
 [<c0107067>] default_idle+0x27/0x30
 [<c01070e1>] cpu_idle+0x31/0x40
 [<c0105000>] rest_init+0x0/0x60



Steps to reproduce:
Boot the computer, wait for 5 minutes, and it comes.
But, when I am in X, it does not start before I switch to the console, and
it stops when I switch back to X.

