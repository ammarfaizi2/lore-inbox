Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUKKLND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUKKLND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUKKLND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:13:03 -0500
Received: from [195.135.223.242] ([195.135.223.242]:5760 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262213AbUKKLLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:11:40 -0500
Date: Thu, 11 Nov 2004 00:30:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IO_APIC NMI Watchdog not handled by suspend/resume.
Message-ID: <20041110233045.GB1099@elf.ucw.cz>
References: <1099643612.3793.3.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099643612.3793.3.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Tracking down SMP problems, I've found that if you boot with
> nmi_watchdog=1 (IO_APIC), the watchdog continues to run while suspend is
> doing sensitive things like restoring the original kernel. I don't know
> enough to provide a patch to disable it so thought I'd ask if someone
> could volunteer to fix this?

When we debated this at x86-64 lists, our conclusion was 'critical
section should take less than 5 seconds, and watchdog only touches its
own variables, so stopping it should not be needed'. [on x86-64,
watchdog is enabled even on up].

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
