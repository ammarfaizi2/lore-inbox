Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVAIVmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVAIVmd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 16:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVAIVmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 16:42:32 -0500
Received: from gprs214-84.eurotel.cz ([160.218.214.84]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261833AbVAIVmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 16:42:25 -0500
Date: Sun, 9 Jan 2005 22:10:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI using smp_processor_id in preemptible code
Message-ID: <20050109211042.GA1196@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I enabled CPU hotplug and preemptible debugging... now I get...

BUG: using smp_processor_id() in preemptible [00000001] code:
swapper/0
caller is acpi_processor_idle+0xb/0x235
 [<c020ba28>] smp_processor_id+0xa8/0xc0
 [<c02338ce>] acpi_processor_idle+0xb/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c02338ce>] acpi_processor_idle+0xb/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c02338c3>] acpi_processor_idle+0x0/0x235
 [<c0101115>] cpu_idle+0x75/0x110
 [<c04f5988>] start_kernel+0x158/0x180
 [<c04f5390>] unknown_bootoption+0x0/0x1e0

...in logs.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
