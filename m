Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWGRCGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWGRCGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 22:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWGRCGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 22:06:01 -0400
Received: from mail.thinktradellc.com ([66.54.171.98]:33796 "EHLO
	thinktradellc.com") by vger.kernel.org with ESMTP id S1750765AbWGRCGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 22:06:01 -0400
Message-ID: <44BC4200.90308@cloakmail.com>
Date: Mon, 17 Jul 2006 22:05:52 -0400
From: Andrew Athan <aathan_linux_kernel_1542@cloakmail.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CPU numbering & hyperthreading
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On an Intel Xeon dual CPU machine running 2.6.16 and up...

I have two highly CPU/memory/network intensive processes with 3-5 
threads each.  I am using sched_setaffinity calls to make sure these two 
processes never compete for the same physical CPU.  Am I right to assume 
that CPU #0 and #1 vs CPU #2 and #3 are separate physical CPUs on a 
2-CPU w/ hyperthreading box?

I've spent some time looking, but I did not find documentation on 
exactly how CPUs are numbered in a hyperthreaded box.

For a process with N threads where N is generally <=5, where each thread 
shares access to the same large (300Mb) data structure across several 
threads, and which pumps the data from memory to a TCP socket, making 
many futex, select, write(), send() network calls (but no disk I/O), I 
assume it is best to keep said process on the same physical CPU but 
allow use both logical processors on that CPU (vs. keeping it to a 
single logical CPU)?

Thanks,
A.



