Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUH3Js1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUH3Js1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267629AbUH3Js1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:48:27 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:44554 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S267514AbUH3JsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:48:17 -0400
Message-ID: <4132F7DA.20406@fr.thalesgroup.com>
Date: Mon, 30 Aug 2004 11:48:10 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9 : a few submillisecond latencies
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <1093556379.5678.109.camel@krustophenia.net> <20040828121413.GB17908@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here are a few submillisecond latencies.

First, the lspci of the machine (which is different from the one I just posted 
about).
http://po.gaillard.free.fr/latency/dell.lspci-v.txt

First, the 3c59x Ethernet card seems to cause 450us latencies :
http://po.gaillard.free.fr/latency/latency_bt.3c59x.txt
http://po.gaillard.free.fr/latency/latency_trace.3c59x.txt

Then the e1000 driver seems to cause 200us latencies :
http://po.gaillard.free.fr/latency/latency_bt.e1000_stats.txt
http://po.gaillard.free.fr/latency/latency_trace.e1000_stats.txt

Since the other machine with an Intel e1000 controller, shows a twice smaller 
latency, I post its lpsci entry for the controller  (note that latency is twice 
smaller) :
02:0a.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Controller 
(Copper)
         Subsystem: Intel Corp.: Unknown device 1213
         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 22
         Memory at f2000000 (32-bit, non-prefetchable)
         I/O ports at b400 [size=64]
         Capabilities: [dc] Power Management version 2
         Capabilities: [e4] PCI-X non-bridge device.

  and thank you to Ingo for the speedy response to the console issue. I applied 
the patch and the kernel is compiling.

	P.O. Gaillard

