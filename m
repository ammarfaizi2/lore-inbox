Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbUKKUjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbUKKUjC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUKKUjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:39:02 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:60131 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262354AbUKKUiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:38:54 -0500
Subject: Re: IO_APIC NMI Watchdog not handled by suspend/resume.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041110233045.GB1099@elf.ucw.cz>
References: <1099643612.3793.3.camel@desktop.cunninghams>
	 <20041110233045.GB1099@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1100205177.4579.7.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 12 Nov 2004 07:32:57 +1100
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

Oh... oops... Must be too early in the morning!

It's not merged, so I don't have to send the fix.

By the way, the slowness caused by sysdev is because of time.c; I'm
about to try reducing the number of get_cmos_time() calls, which should
speed it up by at least 2 seconds.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

