Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161332AbWG1WKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbWG1WKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161333AbWG1WKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:10:46 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:150
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1161332AbWG1WKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:10:45 -0400
Message-ID: <44CA8B56.4000402@microgate.com>
Date: Fri, 28 Jul 2006 17:10:30 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
References: <20060727015639.9c89db57.akpm@osdl.org>	<1154112276.3530.3.camel@amdx2.microgate.com> <20060728144854.44c4f557.akpm@osdl.org>
In-Reply-To: <20060728144854.44c4f557.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I don't know what would have caused this.  Was 2.6.18-rc1-mm2 OK?

I have not tried that combination.

> Patches which touch arch/i386/kernel/io_apic.c are:
> 
> x86_64-mm-i386-up-generic-arch.patch
> x86_64-mm-i386-io-apic-access.patch
> genirq-convert-the-i386-architecture-to-irq-chips.patch
> initial-generic-hypertransport-interrupt-support.patch
> genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector.patch
> genirq-i386-irq-move-msi-message-composition-into-io_apicc.patch
> genirq-i386-irq-dynamic-irq-support.patch
> 
> The developers of those patches are cc'ed.
> 
> A bisection search would be useful, if you have the time.  I'd zero in on
> the x86_64 tree initially.  Perhaps x86_64-mm-i386-io-apic-access.patch.
> 
> Or it could be something else altogether.

The machine in question is at the office so I won't be able
to test that particular setup this weekend. I will test removing
the listed patches as time permits starting on Monday.

It happens every time so there is no problem in reproducing it.
I will also test 2.6.18-rc2-mm1 on my home machine which
is AMDx2 as well (but a different chipset/MB).

--
Paul


