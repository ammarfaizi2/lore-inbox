Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTI3Vm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTI3Vm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:42:26 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:3471 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261760AbTI3VmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:42:21 -0400
Message-ID: <3F79F8BB.2080905@yahoo.com>
Date: Tue, 30 Sep 2003 22:42:19 +0100
From: Chris Rankin <rankincj@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.4) Gecko/20030624
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: APIC error on SMP machine
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-2.4.22-SMP, 1 GB RAM, devfs, gcc-3.2.3.

Hi,

Today, my dual PIII (Coppermine) refused to boot, and wrote a large number of 
these messages to the serial console instead:

APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(04)

Can anyone tell me what these might mean, please? The kernel source implies that 
it's a "Send accept error", but this doesn't help me in an "Ah, I can fix that!" 
sense.

Does this APIC error just mean that the CPU is unhappy in this slot, and is 
refusing to listen to the motherboard? Or is the motherboard refusing to listen 
to the CPU?

Background:
This machine has been misbehaving for a while. I thought I had worked around the 
problem by underclocking the FSB from 133 MHz to 100 MHz, but that now looks 
like it was just a "reprieve". I have tried running "nosmp", "pci=noacpi" and 
"noapic pci=noacpi" without success, and have resorted to yanking the CPU out of 
this slot entirely. (I suspect that the CPU is fine, however.) I have also 
restored the FSB to 133 MHz, so I am currently running the SMP kernel on a 
single 933 MHz PIII.

Cheers,
Chris

