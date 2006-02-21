Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWBUHr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWBUHr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 02:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWBUHr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 02:47:59 -0500
Received: from mail.astral.ro ([193.230.240.11]:32928 "EHLO mail.astral.ro")
	by vger.kernel.org with ESMTP id S1750948AbWBUHr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 02:47:59 -0500
Message-ID: <43FAC5AA.1030205@astral.ro>
Date: Tue, 21 Feb 2006 09:47:54 +0200
From: Imre Gergely <imre.gergely@astral.ro>
Organization: Astral Telecom SA
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: irq balance problems?
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi

i have kernel 2.6.9, with FC2, on an AMD64 Dual Opteron.

[root@btv 28]# cat /proc/interrupts
           CPU0       CPU1
  0:   22249515   39262513    IO-APIC-edge  timer
  1:          0          8    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          0          0    IO-APIC-edge  rtc
 14:          1         13    IO-APIC-edge  ide0
 24:         10  441422068   IO-APIC-level  ioc0, eth1
 25:  171765170       5905   IO-APIC-level  ioc1, eth2
 28:        921     406066   IO-APIC-level  eth0
NMI:      16960       6317
LOC:   61500529   61500464
ERR:          0
MIS:          0

i was wondering, if IRQ28's (eth0) affinity is set to the default "f"

[root@btv 28]# cat /proc/irq/prof_cpu_mask
f
[root@btv 28]# cat /proc/irq/28/smp_affinity
f


and irqbalance is not running, why aren't the interrupts coming from eth0
balanced between the two processors? at least that's what i understood from the
examples in Documentation/IRQ-affinity.txt. are there any other settings/kernel
parameters/compile option one has to set?

(pls msg me in private, i'm not on the list.)
thanks

