Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUKKUaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUKKUaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUKKUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:30:17 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43746 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262353AbUKKU35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:29:57 -0500
Subject: Re: IO_APIC NMI Watchdog not handled by suspend/resume.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041110233045.GB1099@elf.ucw.cz>
References: <1099643612.3793.3.camel@desktop.cunninghams>
	 <20041110233045.GB1099@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1100204641.4579.2.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 12 Nov 2004 07:24:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-11 at 10:30, Pavel Machek wrote:
> Hi!
> 
> > Tracking down SMP problems, I've found that if you boot with
> > nmi_watchdog=1 (IO_APIC), the watchdog continues to run while suspend is
> > doing sensitive things like restoring the original kernel. I don't know
> > enough to provide a patch to disable it so thought I'd ask if someone
> > could volunteer to fix this?
> 
> When we debated this at x86-64 lists, our conclusion was 'critical
> section should take less than 5 seconds, and watchdog only touches its
> own variables, so stopping it should not be needed'. [on x86-64,
> watchdog is enabled even on up].

I've since decided this too; it turns out that the SMP problems were a
function of a problem with freezing workthreads, which I've since fixed.
I have a perfectly stable system now. Which reminds me, since that code
was merged, I should send the patch to Andy. Will do so shortly.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

