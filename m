Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVAKBO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVAKBO3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVAKBJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:09:02 -0500
Received: from fmr19.intel.com ([134.134.136.18]:18878 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262703AbVAKBGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:06:53 -0500
Subject: Re: [ACPI] ACPI using smp_processor_id in preemptible code
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050110095508.GJ1353@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
	 <20050110095508.GJ1353@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1105405464.18834.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 11 Jan 2005 09:04:34 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 17:55, Pavel Machek wrote:
> > >I enabled CPU hotplug and preemptible debugging... now I get...
> > >
> > >BUG: using smp_processor_id() in preemptible [00000001] code:
> > >swapper/0
> > >caller is acpi_processor_idle+0xb/0x235
> > > [<c020ba28>] smp_processor_id+0xa8/0xc0
> > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c0101115>] cpu_idle+0x75/0x110
> > > [<c04f5988>] start_kernel+0x158/0x180
> > > [<c04f5390>] unknown_bootoption+0x0/0x1e0
> > It doesn't trouble to me. It's in idle thread.
> 
> You mean it does not happen to you? On my machine it fills logs very
> quickly...
What I mean is idle thread can't be migrated so this doesn't impact the
correctness. I guess the preemptible debugging can't recognise such
situation.

Thanks,
Shaohua

