Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUKLBPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUKLBPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 20:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKLBNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 20:13:39 -0500
Received: from fsmlabs.com ([168.103.115.128]:24455 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S262402AbUKLBNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 20:13:15 -0500
Date: Thu, 11 Nov 2004 18:13:00 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IO_APIC NMI Watchdog not handled by suspend/resume.
In-Reply-To: <1100204641.4579.2.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411111812120.3407@musoma.fsmlabs.com>
References: <1099643612.3793.3.camel@desktop.cunninghams> 
 <20041110233045.GB1099@elf.ucw.cz> <1100204641.4579.2.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, Nigel Cunningham wrote:

> On Thu, 2004-11-11 at 10:30, Pavel Machek wrote:
> > Hi!
> > 
> > > Tracking down SMP problems, I've found that if you boot with
> > > nmi_watchdog=1 (IO_APIC), the watchdog continues to run while suspend is
> > > doing sensitive things like restoring the original kernel. I don't know
> > > enough to provide a patch to disable it so thought I'd ask if someone
> > > could volunteer to fix this?
> > 
> > When we debated this at x86-64 lists, our conclusion was 'critical
> > section should take less than 5 seconds, and watchdog only touches its
> > own variables, so stopping it should not be needed'. [on x86-64,
> > watchdog is enabled even on up].
> 
> I've since decided this too; it turns out that the SMP problems were a
> function of a problem with freezing workthreads, which I've since fixed.
> I have a perfectly stable system now. Which reminds me, since that code
> was merged, I should send the patch to Andy. Will do so shortly.

Could you please Cc me, i (really) wanted to work on that code but got 
interrupted by some residence moving.

Thanks,
	Zwane

