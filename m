Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVDKKkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVDKKkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVDKKkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:40:42 -0400
Received: from general.keba.co.at ([193.154.24.243]:22972 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261766AbVDKKkI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:40:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: BUG in RT 45-01 when RT program dumps core
Date: Mon, 11 Apr 2005 12:39:59 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231E9@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BUG in RT 45-01 when RT program dumps core
Thread-Index: AcU+gtGH2rZKkpspRPWYat9yXGB4zA==
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a process running with RT priority dumps core,
I get the following BUG:

Apr 11 13:44:23 OF455 kern.err kernel: BUG: rtc2:833 RT task
yield()-ing!
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c026dad1>] yield+0x61/0x70
(8)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c0151e49>]
coredump_wait+0x79/0xc0 (20)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c0151f83>]
do_coredump+0xf3/0x200 (92)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c0136789>]
kmem_cache_free+0x49/0x120 (32)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c012abdb>]
atomic_dec_and_spin_lock+0x3b/0x50 (24)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c011c9a5>]
__dequeue_signal+0x105/0x160 (20)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c011e734>]
get_signal_to_deliver+0x334/0x350 (48)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c01027f8>]
do_signal+0x98/0x180 (44)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c0106b56>]
timer_interrupt+0x46/0x70 (108)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c012c9eb>]
handle_IRQ_event+0x5b/0xe0 (8)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c012cba1>]
__do_IRQ+0x111/0x190 (48)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c010d590>]
do_page_fault+0x0/0x530 (16)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c0102917>]
do_notify_resume+0x37/0x3c (8)
Apr 11 13:44:23 OF455 kern.warn kernel:  [<c0102ae6>]
work_notifysig+0x13/0x15 (8)



Klaus Kusche
> Entwicklung Software - Steuerung
> Software Development - Control
> 
> KEBA AG
> A-4041 Linz
> Gewerbepark Urfahr
> Tel +43 / 732 / 7090-3120
> Fax +43 / 732 / 7090-6301
> E-Mail: kus@keba.com
> www.keba.com
> 
> 
