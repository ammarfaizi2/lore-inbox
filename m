Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWFLJuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWFLJuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWFLJuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:50:20 -0400
Received: from smtp2.versatel.nl ([62.58.50.89]:50375 "EHLO smtp2.versatel.nl")
	by vger.kernel.org with ESMTP id S1751512AbWFLJuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:50:20 -0400
Message-ID: <20060612095008.21733.qmail@www.wolff-online.nl>
From: kernel@wolff-online.nl
To: linux-kernel@vger.kernel.org
Subject: Good performance (hard realtime ??) on 2.6.16 patched with
  patch-2.6.16-rt29 from Ingo Molnar
Date: Mon, 12 Jun 2006 11:50:08 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I have tested 2.6.16 patched with 2.6.16-rt29 on two ordinary boxes (Dell 
PIII, 780 Mhz, IDE disks) connected back to back with ethernet cross at 
100Mbit, one broadcasting small udp messages @50Hz, the other receiving 
those messages. Distro Mandriva 2006.0, used .config from them. 

Conditions:
* Sending and receiving process @RT priority, FIFO, prio 99
* Sending box is almost idle, receiving box heavily loaded (cpu / mem).
* Watchdog/0 non RT (this setting is critical!)
* IRQ from network card on RT prio, rx thread from softirq-net-rx on RT prio 
(FIFO)
* posix_cpu_timer on RT
* kernel compiled without preemption debugging, complete realtime, 
scheduler@100Hz
* receiving process memory locked MCL_CURRENT|MCL_FUTURE
* Heavily loaded (continuously compiling kernel, with 100 jobs in parallel) 

I see following figures:
max latency 512 microseconds on receiving box, during 24 hours of heavily 
testing. 

** this looks like hard realtime, am I correct, or is this coincidence ? 

Thanks
Carl. 


