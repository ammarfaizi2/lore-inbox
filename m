Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUKFJwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUKFJwb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbUKFJwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:52:31 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21163 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261352AbUKFJwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:52:19 -0500
Subject: Re: IO_APIC NMI Watchdog not handled by suspend/resume.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411050825370.4441@musoma.fsmlabs.com>
References: <1099643612.3793.3.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411050825370.4441@musoma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1099731243.4507.323.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 06 Nov 2004 20:50:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-11-06 at 03:41, Zwane Mwaikambo wrote:
> Hi Nigel
> 
> On Fri, 5 Nov 2004, Nigel Cunningham wrote:
> 
> > Tracking down SMP problems, I've found that if you boot with
> > nmi_watchdog=1 (IO_APIC), the watchdog continues to run while suspend is
> > doing sensitive things like restoring the original kernel. I don't know
> > enough to provide a patch to disable it so thought I'd ask if someone
> > could volunteer to fix this?
> 
> Use enable/disable_lapic_nmi_watchdog but first  check to see whether 
> nmi_watchdog == NMI_IO_APIC in which case you'd then call 
> disable/enable_timer_nmi_watchdog. Something like;

Huh! I must have been blind; those routines are right above the lapic
code I was looking at last night!

Thanks!

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

