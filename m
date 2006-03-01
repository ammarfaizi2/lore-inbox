Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWCAWqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWCAWqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWCAWqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:46:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37307 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751331AbWCAWqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:46:48 -0500
Date: Wed, 1 Mar 2006 17:46:47 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Subject: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060301224647.GD1440@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This amused me.

(17:43:34:davej@nemesis:~)$ ll /proc/acpi/processor/
total 0
dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU1/
dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU2/
dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU3/
(17:43:36:davej@nemesis:~)$

As cool as a 3-way x86-64 sounds, it's really only got 2.

Two of these..

vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 8
cpu MHz         : 1789.412
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3578.59
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp


(17:45:21:davej@nemesis:~)$ cat /proc/acpi/processor/CPU*/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      yes
limit interface:         yes
processor id:            1
acpi id:                 2
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
processor id:            255
acpi id:                 3
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no

I guess the '255' has confused something.

This made my 'bug of the day' :)

		Dave

