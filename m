Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTKIQSg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 11:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTKIQSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 11:18:36 -0500
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:19214 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262355AbTKIQSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 11:18:34 -0500
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: increasing APIC errors & spontaneous reboots
Date: Sun, 9 Nov 2003 08:17:08 -0800
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311090817.08570.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm seeing an increasing number of APIC errors (variable irq_mis_count, 
displayed as the "MIS:"  value in /proc/interrupts) and I'm also seeing 
spontaneous reboots.  Could these be related?

Before I go into details, a little background.  I've been using this same 
motherboard/CPUs/RAM with the 2.4.x kernels for several years with no 
problems.  Oh, the MIS: count would climb to 2, maybe as high as 4 but as 
no problems were experienced I never much cared.  The hardware being used 
is a Giga-Byte GA-6BXDU motherboard, dual P3/850Mhz processors and 3 
256MB sticks of ECC PC100 RAM.

For the last 6 - 8 months I've been seeing the MIS count increasing.  The 
largest I've seen is a value of 20.  During the same period I've been 
seeing spontaneous reboots.  The system will reboot itself every 3 to 4 
weeks.  There's no great uptime here; those APIC errors accumulate in 
less than a month.

No problems are seen in the system logs for this machine.  Things are 
apparently going along fine, then the next log entry is the starting line 
of a kernel loading.  The system has rebooted.  (I'm administering this 
machine remotely, so I can't report any text shown on the screen.)

I initially suspected the problems were heat-related (no, I do not 
overclock anything) but lm_sensors consistently shows the CPU fan 
rotations and temperatures to be of reasonable values.

Although this generally is a Red Hat v7.3 system, I run the latest stable 
plain-vanilla Linux kernel, not RH's patched versions.  I am currently 
running v2.4.22, with v2.4.21 before that.

Can anyone explain to me what would cause the increasing APIC MIS counts?  
Also, could this cause the system to reboot?

Thanks.

