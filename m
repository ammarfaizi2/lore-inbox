Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266043AbUALEk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 23:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUALEk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 23:40:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22279 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266043AbUALEk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 23:40:56 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.1 and irq balancing
Date: Sun, 11 Jan 2004 23:42:27 -0500
Organization: TMR Associates, Inc
Message-ID: <btt7pt$3m8$1@gatekeeper.tmr.com>
References: <7F740D512C7C1046AB53446D37200173618820@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073881725 3784 192.168.12.10 (12 Jan 2004 04:28:45 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <7F740D512C7C1046AB53446D37200173618820@scsmsx402.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:

> 2.6 kernels don't need a patch to it as far as I understand. Are you
> saying that with significant amount of load, you did not see any
> distribution of interrupts? Today's threshold in the kernel is high
> because we found moving around interrupts frequently rather hurt the
> cache and thus lower the performance compared to "do nothing". Can you
> try to create significant load with your network (eth0 and eh1) and see
> what happens? 

How much is significant? The term doesn't really help much. I will say 
that with one NIC taking 120MB/sec of data to a TB database and copying 
to two other machine (~220MB)  my interrupts got up in in the 5k-12k 
range with essentially CPU0 doing the work, some few percent going to CPU2.

I'm not sure this is a problem in any way, but some serious load is 
needed to trigger sharing, if indeed the NIC was the source of the ints 
on CPU2.

2x Xeon-2.4GHz, HT enabled. "CPU2" from memory, it was the other 
physical CPU, not another sibling. Worked fine, didn't break, don't 
regard it as a problem.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
