Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUJNUCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUJNUCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUJNUBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:01:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49652 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267474AbUJNTyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:54:24 -0400
Subject: Re: ACPI hangs at boot  w/ nForce motherboard
From: john stultz <johnstul@us.ibm.com>
To: Len Brown <len.brown@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1097782870.29329.34.camel@d845pe>
References: <1097777194.20778.8.camel@cog.beaverton.ibm.com>
	 <1097782870.29329.34.camel@d845pe>
Content-Type: text/plain
Message-Id: <1097783664.20778.22.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 14 Oct 2004 12:54:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 12:41, Len Brown wrote:
> On Thu, 2004-10-14 at 14:06, john stultz wrote:
> > Hey Len,
> >         Sorry for the lack of details here, but I figured I should at
> > least let you know. On my box at home (nForce1 motherboard w/ voodoo3
> > video) 2.6.9-rcX kernels hang on boot. Since its my personal system, I
> > haven't had much time to debug or look into the issue, however I have
> > found that acpi=off allows me to boot.
> > 
> > There are no strange error messages, the system just hangs (the
> > framebuffer console looks to be locked at well - no blinking cursor).
> > 
> > Any suggestions?  I plan to try the standard acpi=noirq, and
> > pci=noacpi, but I feel like I tried them awhile ago to no effect.
> 
> Did this break recently, or did a previous ACPI-mode kernel work
> properly?

Previously it worked fine w/ ACPI, as recently as 2.6.8.1 (I don't
recall exactly, but I don't think 2.6.9-rc1 worked).

> With ACPI enabled, try "acpi_skip_timer_override"
> With ACPI enabled, try "noapic"
> With ACPI enabled, try "nolapic"

I'll give those a shot.

> If you can send me a serial console capture with "debug" for the failure
> case, that would help.  With any successful boot, the dmesg might be
> helpful, and the output from lspci -vv and acpidmp is also helpful.
> acpidmp is in /usr/sbin or in pmtools here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

I'll try for these as well however, its the only system in the house, so
I probably won't be able to get you a serial dump.

> You can send this to me, and/or attach them into a bug report here:
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> and assign it to me.

Will do.

thanks!
-john


