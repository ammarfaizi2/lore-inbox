Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTDXQTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTDXQTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:19:19 -0400
Received: from franka.aracnet.com ([216.99.193.44]:56962 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262620AbTDXQTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:19:18 -0400
Date: Thu, 24 Apr 2003 09:31:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 632] New: stream of bugus retval mask errors from ips on boot 
Message-ID: <82680000.1051201883@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=632

           Summary: stream of bugus retval mask errors from ips on boot
    Kernel Version: 2.5.68-bkcurrent
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: plars@austin.ibm.com


Distribution:
SuSE 8.0
Hardware Environment:
2-way PIII 550, ServeRaid (ips)
Software Environment:
Problem Description:
This system generates a ton of messages like this on boot:
Apr 24 10:52:07 triumph kernel: handlers:
Apr 24 10:52:07 triumph kernel: [<c02ac9d8>] (do_ipsintr+0x0/0xdc)
Apr 24 10:52:07 triumph kernel: irq event 11: bogus retval mask f7d31600
Apr 24 10:52:07 triumph kernel: Call Trace:
Apr 24 10:52:07 triumph kernel:  [<c010ae04>] handle_IRQ_event+0x94/0xf0
Apr 24 10:52:07 triumph kernel:  [<c010b0e9>] do_IRQ+0xf9/0x1b0
Apr 24 10:52:07 triumph kernel:  [<c0106df0>] default_idle+0x0/0x34
Apr 24 10:52:07 triumph kernel:  [<c0105000>] _stext+0x0/0x70
Apr 24 10:52:07 triumph kernel:  [<c0109910>] common_interrupt+0x18/0x20
Apr 24 10:52:07 triumph kernel:  [<c0106df0>] default_idle+0x0/0x34
Apr 24 10:52:07 triumph kernel:  [<c0105000>] _stext+0x0/0x70
Apr 24 10:52:07 triumph kernel:  [<c0106e1c>] default_idle+0x2c/0x34
Apr 24 10:52:07 triumph kernel:  [<c0106ea3>] cpu_idle+0x37/0x48
Apr 24 10:52:07 triumph kernel:  [<c010506d>] _stext+0x6d/0x70
Apr 24 10:52:07 triumph kernel:  [<c04bc772>] start_kernel+0x176/0x180

I can attach the entire log if you want, but they all look identical to me,
irq even 11, mask f7d31600, etc.

Steps to reproduce:
Boot on an ips machine with that kernel


