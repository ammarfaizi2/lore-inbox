Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUKHRsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUKHRsL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUKHRrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:47:55 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:50084 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261791AbUKHRqn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:46:43 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-23.tower-45.messagelabs.com!1099936001!7215312!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: error on kern.log
Date: Mon, 8 Nov 2004 12:46:39 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC403E@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: error on kern.log
thread-index: AcTFuGfkOyHhdKJPQba0DZb1W6rVdgAAAZCgAACVxdA=
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       "Mike Tesliuk" <mike@001admin.com.br>,
       "kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spoke too fast, I see you are running 2.6.4, my problems began with
2.6.9, it would be interesting if you have the same problem however, I
did not recall experiencing this issue in kernels <= 2.6.8.1.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Piszcz, Justin
Michael
Sent: Monday, November 08, 2004 12:33 PM
To: Mike Tesliuk; kernel
Subject: RE: error on kern.log

This is a known bug, it has to do with your network card using TSO
(tcp-sementation-offload), hopefully, it will be fixed in 2.6.10.

http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1326.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1684.html


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Mike Tesliuk
Sent: Monday, November 08, 2004 11:54 AM
To: kernel
Subject: error on kern.log

Hello for all!!!

I have a kernel messages like this every time: 

printk: 9 messages suppressed.
perl5.6.1: page allocation failure. order:3, mode:0x20
Call Trace:
 [<c01351c5>] __alloc_pages+0x2dd/0x2ec
 [<c01351f1>] __get_free_pages+0x1d/0x38
 [<c0137d5d>] cache_grow+0xc5/0x2f8
 [<c013815b>] cache_alloc_refill+0x1cb/0x214
 [<c0138468>] __kmalloc+0x60/0x7c
 [<c02eb2cc>] alloc_skb+0x3c/0xd8
 [<c0312ec5>] tcp_fragment+0x6d/0x2ac
 [<c0315291>] tcp_write_wakeup+0xd9/0x20c
 [<c03153d7>] tcp_send_probe0+0x13/0xfc
 [<c0315f16>] tcp_probe_timer+0xa2/0xac
 [<c03163be>] tcp_write_timer+0xae/0xe4
 [<c0316310>] tcp_write_timer+0x0/0xe4
 [<c0123075>] run_timer_softirq+0x129/0x15c
 [<c011f2bc>] do_softirq+0x6c/0xcc
 [<c01131d3>] smp_apic_timer_interrupt+0x13f/0x144
 [<c010afa2>] apic_timer_interrupt+0x1a/0x20


( Im using a kernel 2.6.4 )

somebody can help me! i have this messages every time!!

what is this?

Thanks!!

Mike Tesliuk (from Brasil)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
