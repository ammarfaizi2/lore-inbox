Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUAPXCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUAPXCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:02:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:25496 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265977AbUAPXCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:02:54 -0500
Date: Fri, 16 Jan 2004 15:02:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: habanero@us.ibm.com
Subject: [Bug 1895] New: oops on test_wp_bit
Message-ID: <23720000.1074294168@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1895

           Summary: oops on test_wp_bit
    Kernel Version: 2.6.1-bk4, 2.6.1-mm4, 2.6.1
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: habanero@us.ibm.com


Distribution:
Hardware Environment: x440, 8-way, 16 GB
Software Environment:
Problem Description: I get this when trying to boot:

Memory: 16596844k/17301504k available (3362k kernel code, 94596k reserved,
1131)Checking if this processor honours the WP bit even in supervisor mode...
<1>Una0 printing eip:
c057727b
*pde = 00000000
Oops: 0003 [#1]
CPU:    0
EIP:    0060:[<c057727b>]    Not tainted
EFLAGS: 00010286
EIP is at test_wp_bit+0x36/0x90
eax: 00000001   ebx: 00002fec   ecx: ffe07000   edx: 00101001
esi: c05bc08c   edi: c671dfec   ebp: c05b90a0   esp: c0565fb8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0564000 task=c04c1400)
Stack: 000001f8 00101000 00000025 c05664fc c045a719 c05be6f1 c05b2220 00000000
       c05660d4 00000bfb 00000020 00008000 c05be6c0 0002080e 00099800 c0105000
       0008e000 c01001b6
Call Trace:
 [<c05664fc>] start_kernel+0x1a3/0x461
 [<c05660d4>] unknown_bootoption+0x0/0x169
 [<c0105000>] _stext+0x0/0x27
                                                                                
Code: 88 15 00 70 e0 ff 31 c0 c7 04 24 f8 01 00 00 a2 04 35 4c c0

