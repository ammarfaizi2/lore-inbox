Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270623AbUJUCMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270623AbUJUCMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270641AbUJUCDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:03:32 -0400
Received: from fmr05.intel.com ([134.134.136.6]:39882 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270739AbUJUCBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:01:50 -0400
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS,
	...)
From: Li Shaohua <shaohua.li@intel.com>
To: Nate Lawson <nate@root.org>
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <4176FCB8.3060103@root.org>
References: <4176FCB8.3060103@root.org>
Content-Type: text/plain
Message-Id: <1098323602.6132.51.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 09:53:23 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 08:03, Nate Lawson wrote:
> Pavel Machek wrote:
> >>>I'm seeing bad problem with N620c notebook (and have reports of
> more
> >>>machines behaving like this, for example ASUS L8400C.) If I
> shutdown
> >>>machine with lid closed, opening lid will power the machine up.
> Ouch.
> >>>2.6.7 behaves okay.
> >>
> >>:> Some people would love to have the machine power up when they
> open
> >>the lid! Wish my XE3 would do that!
> 
> This problem sounds like a wake GPE is enabled for the lid switch and 
> that it has a _PRW that indicates it can wake the system from S5.  If 
> this is the case, just disabled the GPE.
> 
> > :-). Well for some other people it powers up when they unplug AC
> > power, and *that* is nasty. I'd like my machine to stay powered down
> > when I tell it so.
> 
> This is likely a similar GPE problem.  The GPE for the EC fires even
> in 
> S5.  I think the EC GPE should be disabled in the suspend method.
It could be the wakeup GPE issue, but must note Pavel's system suffer
the problem even with acpi=off. Could you please try boot your system
with acpi=off, and then reboot with acpi=off, what's the result? I
expected the wakeup GPE is disabled by the BIOS in this case.
Anyway, the DSDT can tell us the wakeup GPE info.

Thanks,
Shaohua

