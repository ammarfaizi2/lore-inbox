Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVGRQOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVGRQOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 12:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVGRQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 12:14:29 -0400
Received: from mxout2.netvision.net.il ([194.90.9.21]:32194 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id S261827AbVGRQNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 12:13:07 -0400
Date: Mon, 18 Jul 2005 19:12:50 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: 2.6.12.3/2.6.13-rc3 BUG REPORT - x86_64 with hyperthreading
To: linux-kernel@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <102574499.20050718191250@netvision.net.il>
MIME-version: 1.0
X-Mailer: The Bat! (v3.5.30) Professional
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I tried 2.6.12.3/2.6.13-rc3 compiled for x86_64 on Supermicro dual Xeon
with hyperthreading enabled and the kernel gets stuck when trying to
initialize the second CPU.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using local APIC timer interrupts.
Detected 12.501 MHz APIC timer.
Booting processor 1/6 rip 6000 rsp ffff81007ff35f58
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 2.80GHz stepping 01
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/1 rip 6000 rsp ffff8100032dff58
Initializing CPU#2

Booting with hyperthreading disabled is OK.
Booting with hyperthreading enabled and maxcpus=1 is also OK.

Here are board/bios details:
Supermicro X6DH8-XG2/X6DHE-XG2 BIOS Rev 1.2a

CPU = 4 - Intel(R) Xeon(TM) CPU 2.80GHz
DRAM Type : DDR2-400
Hyper Threading Technology Enabled

Please advise.

Thanks,

Maxim Kozover.

