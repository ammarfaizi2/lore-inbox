Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUD0MAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUD0MAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbUD0MAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:00:12 -0400
Received: from cpe.atm2-0-52195.0x50c6d58a.slnxx1.customer.tele.dk ([80.198.213.138]:41451
	"EHLO ntserver.MINISOFT") by vger.kernel.org with ESMTP
	id S264026AbUD0MAA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:00:00 -0400
content-class: urn:content-classes:message
Subject: Unable to handle kernel paging request at virtual address f899b000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Tue, 27 Apr 2004 13:59:51 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Message-ID: <CC9C3DBEFF34584690F2695172DEDC221DDD04@mmarsh.ca.caldera.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to handle kernel paging request at virtual address f899b000
Thread-Index: AcQsTv955xo2BewET8aP4/YWIts4gg==
From: =?iso-8859-1?Q?Jesper_Langkj=E6r?= <jl@MINISOFT.DK>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi..

Hope that somone can help us..

One of our customer has an RedHat 7.2 with a stock 2.4.7-10SMP kernel, and every now an then it starts to throw of all of the users on that assigned CPU.
It has 4 CPU and 1 Gb of ram

In the messages log we can read the following

Apr 23 16:10:57 desyv kernel: Unable to handle kernel paging request at virtual
address f899b000
Apr 23 16:10:57 desyv kernel:  printing eip:
Apr 23 16:10:57 desyv kernel: 00113102
Apr 23 16:10:57 desyv kernel: *pde = 021d2067
Apr 23 16:10:57 desyv kernel: *pte = 00000000
Apr 23 16:10:57 desyv kernel: Oops: 0000
Apr 23 16:10:57 desyv kernel: CPU:    0
Apr 23 16:10:57 desyv kernel: EIP:    0023:[exit_devpts_fs+1126546/-1072693360]
Apr 23 16:10:57 desyv kernel: EIP:    0023:[<00113102>]
Apr 23 16:10:57 desyv kernel: EFLAGS: 00010217
Apr 23 16:10:57 desyv kernel: eax: 00000030   ebx: 0000066f   ecx: 00000002   ed
x: 0010ecb0
Apr 23 16:10:57 desyv kernel: esi: 00000001   edi: 0040703c   ebp: bfffe8d0   es
p: bfffe8c0
Apr 23 16:10:57 desyv kernel: ds: 002b   es: 002b   ss: 002b
Apr 23 16:10:57 desyv login(pam_unix)[19909]: session closed for user frh
Apr 23 16:10:57 desyv kernel: Process todayx (pid: 19910, stackpage=f6bf1000)
Apr 23 16:10:57 desyv kernel:  <1>Unable to handle kernel paging request at virt
ual address f899b000
Apr 23 16:10:57 desyv kernel:  printing eip:
Apr 23 16:10:57 desyv kernel: 0011305c
Apr 23 16:10:57 desyv kernel: *pde = 021d2067
Apr 23 16:10:57 desyv kernel: *pte = 00000000
Apr 23 16:10:57 desyv kernel: Oops: 0000
Apr 23 16:10:57 desyv login(pam_unix)[2044]: session closed for user ka3
Apr 23 16:10:57 desyv kernel: CPU:    0
Apr 23 16:10:57 desyv kernel: EIP:    0023:[exit_devpts_fs+1126380/-1072693360]
Apr 23 16:10:57 desyv kernel: EIP:    0023:[<0011305c>]
Apr 23 16:10:57 desyv kernel: EFLAGS: 00010246
Apr 23 16:10:57 desyv kernel: eax: 00000004   ebx: bffff710   ecx: 0040aabc   ed
x: 00000001
Apr 23 16:10:57 desyv kernel: esi: 0049807c   edi: 0049dd94   ebp: bffff604   es
p: bffff5f4
Apr 23 16:10:57 desyv kernel: ds: 002b   es: 002b   ss: 002b
Apr 23 16:10:57 desyv kernel: Process todayx (pid: 2045, stackpage=eb9ef000)
Apr 23 16:10:57 desyv kernel:  <1>Unable to handle kernel paging request at virt
ual address f899b000
Apr 23 16:10:57 desyv kernel:  printing eip:
Apr 23 16:10:57 desyv kernel: 0011305c
Apr 23 16:10:57 desyv kernel: *pde = 021d2067
Apr 23 16:10:57 desyv kernel: *pte = 00000000
Apr 23 16:10:57 desyv kernel: Oops: 0000
Apr 23 16:10:57 desyv kernel: CPU:    0
Apr 23 16:10:57 desyv login(pam_unix)[23195]: session closed for user kv2
Apr 23 16:10:57 desyv kernel: EIP:    0023:[exit_devpts_fs+1126380/-1072693360]
Apr 23 16:10:57 desyv kernel: EIP:    0023:[<0011305c>]
Apr 23 16:10:57 desyv kernel: EFLAGS: 00010246
Apr 23 16:10:57 desyv kernel: eax: 00000004   ebx: bffff80d   ecx: 0042a111   ed
x: 00000001
Apr 23 16:10:57 desyv kernel: esi: 00000001   edi: 00473448   ebp: bffff758   es
p: bffff748
Apr 23 16:10:57 desyv kernel: ds: 002b   es: 002b   ss: 002b
Apr 23 16:10:58 desyv kernel: Process todayx (pid: 23196, stackpage=f6bbb000)
Apr 23 16:10:58 desyv kernel:  <1>Unable to handle kernel paging request at virt
ual address f899b000
Apr 23 16:10:58 desyv kernel:  printing eip:
Apr 23 16:10:58 desyv kernel: 0011305c
Apr 23 16:10:58 desyv kernel: *pde = 021d2067
Apr 23 16:10:58 desyv kernel: *pte = 00000000
Apr 23 16:10:58 desyv kernel: Oops: 0000
Apr 23 16:10:58 desyv kernel: CPU:    0
Apr 23 16:10:58 desyv kernel: EIP:    0023:[exit_devpts_fs+1126380/-1072693360]
Apr 23 16:10:58 desyv kernel: EIP:    0023:[<0011305c>]
Apr 23 16:10:58 desyv kernel: EFLAGS: 00010246
Apr 23 16:10:58 desyv kernel: eax: 00000004   ebx: bffff60d   ecx: 0042a111   ed
x: 00000001
Apr 23 16:10:58 desyv kernel: esi: 00000001   edi: 004b8118   ebp: bffff5f4   es
p: bffff5e4
Apr 23 16:10:58 desyv kernel: ds: 002b   es: 002b   ss: 002b
Apr 23 16:10:58 desyv login(pam_unix)[18459]: session closed for user nas
Apr 23 16:10:58 desyv kernel: Process todayx (pid: 18460, stackpage=d41e5000)
Apr 23 16:10:58 desyv kernel:  <1>Unable to handle kernel paging request at virt
ual address f899b000

Kind regards

Jesper Langkjær

----------------------------

MINISOFT A/S
Ørstedevej 13, 8600 Silkeborg
Tlf: 86813488
Fax: 86801397
E-mail: jl@minisoft.dk
General E-mail: info@minisoft.dk


