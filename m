Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWDCU0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWDCU0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 16:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWDCU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 16:26:15 -0400
Received: from h-66-17-68-74.noclli.covad.net ([66.17.68.74]:40703 "EHLO
	mail.merunetworks.com") by vger.kernel.org with ESMTP
	id S964878AbWDCU0O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 16:26:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Kernel panic in add_entropy_words
Date: Mon, 3 Apr 2006 13:24:08 -0700
Message-ID: <61716BB31DD0AE469370BBE04DD6C07A0CF2A1@hail.merunetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel panic in add_entropy_words
Thread-Index: AcZXXI+ajEJ7JcoLS4OI3TMMSdcO2A==
From: "Kim Le" <kle@merunetworks.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Kim Le" <kle@merunetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Any one ever encounter this kernel panic.
I am pulling my hair finding the fix for this.  So any help is appreciate.
Please reply to my email address if you could.

Thanks
Kim

EIP is at add_entropy_words [kernel] 0x92 (2.4.18-3-meruenabled)
eax: 08000001   ebx: 1fa96582   ecx: 00000007   edx: c16b2b00
esi: c16ba300   edi: 0000001f   ebp: 00000000   esp: dc809d08
ds: 0018   es: 0018   ss: 0018
Process coordinator (pid: 1266, stackpage=dc809000)
Stack: c16ba300 00000400 c16ba280 00000000 c017c4e9 c16ba300 c1757b3c 00000002
       dc809d3c dc809d3c c02e4c00 c011d6d9 c16ba280 c02fe72c c02fe72c c02ecb14
       c02ecb00 c0120699 c029de60 dc809db0 00000000 00000000 00000000 c011d60b
Call Trace: [<c017c4e9>] batch_entropy_process [kernel] 0x59
[<c011d6d9>] __run_task_queue [kernel] 0x49
[<c0120699>] tqueue_bh [kernel] 0x19
[<c011d60b>] bh_action [kernel] 0x1b
[<c011d51e>] tasklet_hi_action [kernel] 0x4e
[<c011d33b>] do_softirq [kernel] 0x4b
[<c010a06c>] do_IRQ [kernel] 0x9c
[<c012fd87>] kmalloc [kernel] 0x37
[<e08d9e43>] kcomm_mailbox_sendto [kcomm] 0x6b
[<c01b627f>] alloc_skb [kernel] 0xdf
[<e08d9f8a>] kcomm_mailbox_alloc_skb [kcomm] 0x12
[<e08dcb78>] kcomm_socket_sendmsg [kcomm] 0x8c
[<e08d6634>] nulldevname.0 [ip_tables] 0x0

