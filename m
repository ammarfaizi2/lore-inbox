Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUJNTsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUJNTsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUJNTrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:47:05 -0400
Received: from fmr11.intel.com ([192.55.52.31]:19595 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S267397AbUJNTlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:41:22 -0400
Subject: Re: ACPI hangs at boot  w/ nForce motherboard
From: Len Brown <len.brown@intel.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1097777194.20778.8.camel@cog.beaverton.ibm.com>
References: <1097777194.20778.8.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097782870.29329.34.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Oct 2004 15:41:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 14:06, john stultz wrote:
> Hey Len,
>         Sorry for the lack of details here, but I figured I should at
> least let you know. On my box at home (nForce1 motherboard w/ voodoo3
> video) 2.6.9-rcX kernels hang on boot. Since its my personal system, I
> haven't had much time to debug or look into the issue, however I have
> found that acpi=off allows me to boot.
> 
> There are no strange error messages, the system just hangs (the
> framebuffer console looks to be locked at well - no blinking cursor).
> 
> Any suggestions?  I plan to try the standard acpi=noirq, and
> pci=noacpi, but I feel like I tried them awhile ago to no effect.


Hi John,
Did this break recently, or did a previous ACPI-mode kernel work
properly?

With ACPI enabled, try "acpi_skip_timer_override"
With ACPI enabled, try "noapic"
With ACPI enabled, try "nolapic"

If you can send me a serial console capture with "debug" for the failure
case, that would help.  With any successful boot, the dmesg might be
helpful, and the output from lspci -vv and acpidmp is also helpful.
acpidmp is in /usr/sbin or in pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

You can send this to me, and/or attach them into a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and assign it to me.

thanks,
-Len


