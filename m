Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbUBWQLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUBWQLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:11:02 -0500
Received: from mail.tmr.com ([216.238.38.203]:20352 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261945AbUBWQJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:09:27 -0500
Message-ID: <403A25B0.5090104@tmr.com>
Date: Mon, 23 Feb 2004 11:09:20 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: ACPI and ISA IRQ 9, Linux 2.4
References: <m3isi3n9wa.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3isi3n9wa.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Hi,
> 
> I think this is a known problem, but I don't know how to fix it:
> 
> I have a dual Pentium-2 machine (non-SCSI Asus P2B-D), latest BIOS with
> ACPI etc. It has an ISA card (serial port) using IRQ 9 (I can't change
> the IRQ). It works fine without ACPI, Linux 2.4 lists IRQ 9 as
> APIC edge-triggered.
> 
> With acpi=force (due to BIOS date) IRQ 9 is used by ACPI. /proc/interrupts
> lists it as APIC level-triggered, and the ISA card no longer generates
> interrupts.
> 
> IRQ 9 is set to "ISA" in BIOS setup. acpi_irq_isa=9 doesn't help.
> 
> Is is possible to fix it? Or is it just impossible to use ISA IRQ 9
> with ACPI?
> 
> More details available on request, of course.

I have a similar problem, and my aha1520 can't be moved off irq9 without 
cutting traces on the system board. How bad is it without ACPI at all? I 
tried that for a while, and several other things didn't work, and it 
looks as if the aha1520 driver won't share irq anyway, and something 
else (I forget) wants that irq as well.

I boot into 2.4 to do backups, fortunately the only thing on the SCSI.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
