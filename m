Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbUKQIDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUKQIDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbUKQIDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:03:08 -0500
Received: from calvin.codito.com ([203.199.140.162]:43408 "EHLO
	magrathea.codito.co.in") by vger.kernel.org with ESMTP
	id S262227AbUKQIC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:02:56 -0500
From: Amit Shah <amit.shah@codito.com>
Organization: Codito Technologies
To: Ingo Molnar <mingo@elte.hu>
Subject: BUG with 0.7.27-11, with KGDB
Date: Wed, 17 Nov 2004 13:29:33 +0530
User-Agent: KMail/1.7
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>,
       Stefan Schweizer <sschweizer@gmail.com>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <419A5A53.6050100@cybsft.com> <20041116212401.GA16845@elte.hu>
In-Reply-To: <20041116212401.GA16845@elte.hu>
X-GnuPG-Fingerprint: 3001 346D 47C2 E445 EC1B  2EE1 E8FD 8F83 4E56 1092
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411171329.41209.amit.shah@codito.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Initializing Cryptographic API
kgdb <20030915.1651.33> : port =3f8, IRQ=4, divisor =1
BUG: scheduling while atomic: swapper/0x00000001/1
caller is schedule+0x3f/0x13c
 [<c01041f4>] dump_stack+0x23/0x27 (20)
 [<c02ce307>] __sched_text_start+0xc97/0xce7 (116)
 [<c02ce396>] schedule+0x3f/0x13c (36)
 [<c02ce60a>] wait_for_completion+0x95/0x137 (96)
 [<c0138cd8>] kthread_create+0x22a/0x22c (368)
 [<c0145a30>] start_irq_thread+0x4f/0x83 (32)
 [<c01453ec>] setup_irq+0x55/0x140 (36)
 [<c0145655>] request_irq+0x90/0x107 (44)
 [<c01e1bc1>] kgdb_enable_ints_now+0xa5/0xb0 (28)
 [<c03bfb89>] kgdb_enable_ints+0x2c/0x63 (16)
 [<c03a8a23>] do_initcalls+0x31/0xc6 (32)
 [<c01003bb>] init+0x87/0x19a (28)
 [<c0101329>] kernel_thread_helper+0x5/0xb (1047322644)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02cfd66>] .... _raw_spin_trylock+0x1c/0x57
.....[<c01e1b31>] ..   ( <= kgdb_enable_ints_now+0x15/0xb0)
.. [<c013dbe3>] .... print_traces+0x1d/0x56
.....[<c01041f4>] ..   ( <= dump_stack+0x23/0x27)

-- 
Amit Shah
Codito Technologies Pvt. Ltd.
