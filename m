Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVGFXJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVGFXJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVGFXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:09:30 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:4994 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262571AbVGFXJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:09:03 -0400
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200507062315.07536.s0348365@sms.ed.ac.uk>
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
	 <200507062200.08924.s0348365@sms.ed.ac.uk> <20050706210249.GA2017@elte.hu>
	 <200507062315.07536.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1120691329.6766.62.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2005 16:08:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 15:15, Alistair John Strachan wrote:
> On Wednesday 06 Jul 2005 22:02, Ingo Molnar wrote:
> > * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > This is a completely unrelated question, but now we've got everything
> > > under control.. how do I make "quiet" actually do something on the RT
> > > patchset?
> > >
> > > Currently I flag it on the kernel cmdline, but I still get everything
> > > spewed to my primary VT.
> >
> > do you have CONFIG_PRINTK_IGNORE_LOGLEVEL enabled perhaps?
> 
> Good idea, but nope. Find attached the config I'm using, and here's the output 
> from /proc/cmdline:
> 
> [alistair] 23:07 [~] cat /proc/cmdline
> BOOT_IMAGE=2.6.12rt ro root=301 acpi_sleep=s3_bios lapic quiet
> 
> [alistair] 23:07 [~] uname -r
> 2.6.12-RT-V0.7.51-06
> 
> What I see are the kernel messages pre-init not suppressed (like I think they 
> should be with quiet) and spurious noise from usb, etc. as the system boots 
> up. sysklogd starts up but the messages are still duplicated on the console.
> 
> Maybe my configuration is subtlely broken. Is anybody else experiencing this?

I see the same thing. "CONFIG_PRINTK_IGNORE_LOGLEVEL is not set" but
still printk ignores the loglevel (I commented out the #ifdef in
kernel/printk.c to make the spurious messages go away). 

-- Fernando


