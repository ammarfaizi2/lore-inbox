Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266552AbUGPPM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266552AbUGPPM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 11:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUGPPM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 11:12:56 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:45696 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266552AbUGPPMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 11:12:54 -0400
Message-ID: <40F7F084.9070807@eidetix.com>
Date: Fri, 16 Jul 2004 17:13:08 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oopses - "irq:5 nobody cared" and drain_array
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First oops happened when one of my colleagues was compiling some code on 
the machine.  It shut it down.  Wrote down some of the trace:

drain_array+0x7c/0xf0
reap_timer_fnc+0x75/0x1f0
reap_timer_fnc
run_timer_soft_irq
do_timer
__do_soft_irq
do_IRQ
common_interrupt
default_idle
cpu_idle
start_kernel
unknown_bootoption

The second one was during boot and starts off like this:

irq 5: nobody cared!
  [<c010634a>] __report_bad_irq+0x2a/0x90
  [<c010643c>] note_interrupt+0x6c/0xa0
  [<c0106711>] do_IRQ+0x121/0x130
  [<c01049f4>] common_interrupt+0x18/0x20
  [<c011d770>] __do_softirq+0x30/0x80
  [<c011d7e6>] do_softirq+0x26/0x30
  [<c01066ed>] do_IRQ+0xfd/0x130


I'm going to post the dmesg of the machine at:

http://dedasys.com/dmesg2.txt

More info available on request.

Thankyou for any suggestions,
-- 
David N. Welton
davidw@eidetix.com
