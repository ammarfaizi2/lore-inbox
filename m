Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVACEc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVACEc4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 23:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVACEc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 23:32:56 -0500
Received: from mail.tmr.com ([216.238.38.203]:12160 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S261381AbVACEcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 23:32:54 -0500
Message-ID: <41D8C86D.4090603@tmr.com>
Date: Sun, 02 Jan 2005 23:22:05 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel M/L <linux-kernel@vger.kernel.org>
Subject: 2.6.10 IRQ 18 issues gone away
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ongoing issue with runaway IRQ 18 floods has gone away, although I am 
not totally sure they are "solved" in the usual sense. I flashed the 
latest BIOS from Asus and had various problems (P4P81019) then flashed 
one I got as a gift from a nameless source (P4P81086). That did the 
trick, all the IRQs are no longer shared, even though they worked 
perfectly as shared on 2.4.22-1.2199 (FC1) with the original BIOS.

Since the system worked with 2.4 and not with 2.6, even though a BIOS 
change made the problem go away, I suspect that there is still some 
issue with the shared IRQ, although I am certainly NOT interested in 
going back to help find it!

Many thanks to people who suggested BIOS upgrade as a workaround for the 
kernel, and pointed me at installing from CD instead of floppy (I don't 
have floppy). The system is now stable although there are a number of 
"not in 2.6" issues to solve eventually.

My new interrupt map if anyone cares:
           CPU0       CPU1
  0:    4770773    4751617    IO-APIC-edge  timer
  1:       8275       9223    IO-APIC-edge  i8042
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:      52649      44985    IO-APIC-edge  i8042
 14:      15451      12645    IO-APIC-edge  ide0
 15:      99181     135233    IO-APIC-edge  ide1
 16:     332255     330935   IO-APIC-level  radeon@PCI:1:0:0
 17:     246658     257869   IO-APIC-level  Intel ICH5
 22:       6069       6292   IO-APIC-level  SysKonnect SK-98xx
NMI:          0          0
LOC:    9453797    9458470
ERR:          0
MIS:          0

