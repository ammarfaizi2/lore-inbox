Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUBJU3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUBJU3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:29:33 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11025 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265251AbUBJU3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:29:32 -0500
Message-ID: <40294013.7000202@tmr.com>
Date: Tue, 10 Feb 2004 15:33:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hod McWuff <hod@wuff.dhs.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT CPU handling - 2.6.2
References: <1nqw6-5W0-25@gated-at.bofh.it>
In-Reply-To: <1nqw6-5W0-25@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hod McWuff wrote:
> I've got a 2.0A GHz P4, advertised as non-hyperthread, that seems to be
> reporting the presence of a second CPU. It also seems to be disabled by
> setting bit 7 of its ID. I've tried compiling with support for 130 CPU's
> and nothing changed. What would have to be done to get this disabled
> CPU half back online?
> 
> Feb  9 04:45:03 pug ACPI: Local APIC address 0xfee00000
> Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Feb  9 04:45:03 pug Processor #0 15:2 APIC version 20
> Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
> Feb  9 04:45:03 pug Processor #129 invalid (max 16)
> Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])

Look in /proc/cpuinfo for number of siblings. If it's one you have no HT 
capability, the stuff for HT is mostly there but there's no sib to 
share. Sort of like a Siamese twin who's an only child or some such. You 
have a funky APIC and not much else.

Don't know if the LAPIC is actually useful.
-- 
Bill Davidsen, TMR

