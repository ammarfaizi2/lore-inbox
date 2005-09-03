Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVICBoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVICBoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVICBoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:44:10 -0400
Received: from siaag1ag.compuserve.com ([149.174.40.13]:18071 "EHLO
	siaag1ag.compuserve.com") by vger.kernel.org with ESMTP
	id S1751336AbVICBoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:44:09 -0400
Date: Fri, 2 Sep 2005 21:41:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [2.6.13 bug] i386: Wall clock running at double speed
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>
Message-ID: <200509022143_MC3-1-A902-51B5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running an i386 kernel on an AMD Turion notebook with the cpufreq drivers
enabled (both ACPI P-states and AMD PowerNow.)  My system clock is running
twice as fast as it should.

/sys/devices/system/cpu/cpu0/cpufreq/stats shows the system is spending over
99% of its time running at 800MHz (half speed.)


CONFIG_MK7=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y


>From /proc/interrupts:

  0:  136523787    IO-APIC-edge  timer

LOC:   68264003


The local APIC timer is getting half as many interrupts as the system
timer.

__
Chuck
