Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWDXClE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWDXClE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 22:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWDXClE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 22:41:04 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:6356 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1750752AbWDXClD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 22:41:03 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Q: Why decreased performance on 2.6.17-rc2-gitX with dual cpu vs single cpu ?
Date: Mon, 24 Apr 2006 02:41:01 +0000 (UTC)
Organization: Cistron
Message-ID: <e2hdrt$isr$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1145846461 19355 62.216.30.70 (24 Apr 2006 02:41:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tyan amd64 box with dual opteron 250
4GB ram
debian 64 bit os

It's running as a usenet gateway (2TB in & out roughly each day)

I recently installed munin to track more information.

I run 2.6.17-rc2-git4 in UP mode for 29 hours and then
switched to 2.6.17-rc2-git5 and enabled both cpu's (smp)

irqbalance is installed :


# cat /proc/interrupts
           CPU0       CPU1
  0:      55171    2161605    IO-APIC-edge  timer
  1:          5          2    IO-APIC-edge  i8042
  4:         62        422    IO-APIC-edge  serial
  9:          0          0   IO-APIC-level  acpi
 16:     239941    5682160   IO-APIC-level  aic79xx
 17:    3375173   36339647   IO-APIC-level  aic79xx, eth3
 18:    1433719   67869071   IO-APIC-level  acenic
NMI:       3858       7945
LOC:    2216253    2215748
ERR:          0
MIS:          0


Kernel config's, kern.log output of both kernels can
be found at: http://newsgate.newsserver.nl/kernel/

munin graphics: 
http://stats.handelsweg8.nl/munin/newsserver.nl/newsgate.newsserver.nl.html

I see in the munin graphics some idle time for the first 
time when both cpu's are enabled. But IO-Wait is also much
higher then in UP mode.

Any brilliant mind can explain to me what is happening here ?
i certainly don't get it !

Danny

