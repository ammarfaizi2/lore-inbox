Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263082AbTC2B54>; Fri, 28 Mar 2003 20:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263374AbTC2B54>; Fri, 28 Mar 2003 20:57:56 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61870 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263082AbTC2B5x>; Fri, 28 Mar 2003 20:57:53 -0500
Date: Fri, 28 Mar 2003 17:59:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 516] New: Removing wireless card triggers might_sleep warnings
Message-ID: <72780000.1048903154@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=516

           Summary: Removing wireless card triggers might_sleep warnings.
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: davej@codemonkey.org.uk


orinoco_lock() called with hw_unavailable (dev=cf899800)
orinoco_lock() called with hw_unavailable (dev=cf899800)
orinoco_lock() called with hw_unavailable (dev=cf899800)
Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c01212d5>] __might_sleep+0x55/0x60
 [<d08488d8>] +0x14/0x93 [ds]
 [<d084857a>] get_socket_info_by_nr+0x1a/0xb0 [ds]
 [<d08488d8>] +0x14/0x93 [ds]
 [<d08473d0>] handle_removal+0x0/0x30 [ds]
 [<d08473dd>] handle_removal+0xd/0x30 [ds]
 [<c012eadd>] run_timer_softirq+0x14d/0x3b0
 [<c0129d73>] do_softirq+0xb3/0xc0
 [<c010cd95>] do_IRQ+0x215/0x310
 [<c0107280>] default_idle+0x0/0x50
 [<c0105000>] _stext+0x0/0xe0
 [<c010af68>] common_interrupt+0x18/0x20
 [<c0107280>] default_idle+0x0/0x50
 [<c0105000>] _stext+0x0/0xe0
 [<c01072a7>] default_idle+0x27/0x50
 [<c010734a>] cpu_idle+0x2a/0x40

orinoco_lock() called with hw_unavailable (dev=cf899800)

