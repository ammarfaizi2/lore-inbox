Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVH0Usm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVH0Usm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVH0Usm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 16:48:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51094 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750752AbVH0Usl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 16:48:41 -0400
Date: Sat, 27 Aug 2005 22:48:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Masoud Sharbiani <masouds@masoud.ir>, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [ACPI] acpi_shutdown: Only prepare for power off on power_off
Message-ID: <20050827204828.GA1971@elf.ucw.cz>
References: <Pine.SOC.4.61.0508221152350.17731@math.ut.ee> <m1mznativw.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508242252120.20856@math.ut.ee> <m11x4iofmw.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508260802230.22690@math.ut.ee> <m1ek8htfcc.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508262144490.24024@math.ut.ee> <m1r7cfswa5.fsf_-_@ebiederm.dsl.xmission.com> <20050827115759.GB1109@openzaurus.ucw.cz> <m1acj3rwjl.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acj3rwjl.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> When acpi_sleep_prepare was moved into a shutdown method we
> >> started calling it for all shutdowns.  It appears this triggers
> >> some systems to power off on reboot.  Avoid this by only calling
> >> acpi_sleep_prepare if we are going to power off the system.
> >
> > Are you sure that system_state is correctly set at this point? There are
> > quite a few ways that lead to this...
> 
> - It is an error if system_state is not set properly.
> 
> -  Do to my earlier cleanups there are only 4 functions
>    that call device_shutdown they are:
>    kernel_restart(), kernel_kexec(), kernel_halt(), kernel_power_off()
> 
>    And those four all set system_state correctly.
> 
> If you can find another path that calls this incorrectly I would be happy
> to fix it.  But my grep through the kernel doesn't reveal any other
> callers.

Ok, thanks for analysis!
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
