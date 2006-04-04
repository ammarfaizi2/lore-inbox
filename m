Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWDDBLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWDDBLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 21:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWDDBLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 21:11:43 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:64225 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S964934AbWDDBLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 21:11:43 -0400
X-ASG-Debug-ID: 1144113094-7352-45-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: Kernel panic in add_entropy_words
Subject: Re: Kernel panic in add_entropy_words
From: Arjan van de Ven <arjan@infradead.org>
To: Kim Le <kle@merunetworks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <61716BB31DD0AE469370BBE04DD6C07A0CF2A1@hail.merunetworks.com>
References: <61716BB31DD0AE469370BBE04DD6C07A0CF2A1@hail.merunetworks.com>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 03:11:31 +0200
Message-Id: <1144113091.3067.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10447
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          BODY: Custom Rule 7568M
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 13:24 -0700, Kim Le wrote:
> Folks,
> 
> Any one ever encounter this kernel panic.
> I am pulling my hair finding the fix for this.  So any help is appreciate.
> Please reply to my email address if you could.
> 
> Thanks
> Kim
> 
> EIP is at add_entropy_words [kernel] 0x92 (2.4.18-3-meruenabled)
> eax: 08000001   ebx: 1fa96582   ecx: 00000007   edx: c16b2b00
> esi: c16ba300   edi: 0000001f   ebp: 00000000   esp: dc809d08
> ds: 0018   es: 0018   ss: 0018
> Process coordinator (pid: 1266, stackpage=dc809000)
> Stack: c16ba300 00000400 c16ba280 00000000 c017c4e9 c16ba300 c1757b3c 00000002
>        dc809d3c dc809d3c c02e4c00 c011d6d9 c16ba280 c02fe72c c02fe72c c02ecb14
>        c02ecb00 c0120699 c029de60 dc809db0 00000000 00000000 00000000 c011d60b
> Call Trace: [<c017c4e9>] batch_entropy_process [kernel] 0x59
> [<c011d6d9>] __run_task_queue [kernel] 0x49
> [<c0120699>] tqueue_bh [kernel] 0x19
> [<c011d60b>] bh_action [kernel] 0x1b
> [<c011d51e>] tasklet_hi_action [kernel] 0x4e
> [<c011d33b>] do_softirq [kernel] 0x4b
> [<c010a06c>] do_IRQ [kernel] 0x9c
> [<c012fd87>] kmalloc [kernel] 0x37
> [<e08d9e43>] kcomm_mailbox_sendto [kcomm] 0x6b
> [<c01b627f>] alloc_skb [kernel] 0xdf
> [<e08d9f8a>] kcomm_mailbox_alloc_skb [kcomm] 0x12
> [<e08dcb78>] kcomm_socket_sendmsg [kcomm] 0x8c
> [<e08d6634>] nulldevname.0 [ip_tables] 0x0


what is this kcomm thing? You forgot to put in a pointer to the source
of that :)
Also you seem to run a very modified kernel... what did you change?


