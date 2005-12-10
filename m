Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVLJBnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVLJBnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 20:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLJBnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 20:43:33 -0500
Received: from tim.rpsys.net ([194.106.48.114]:1740 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964798AbVLJBnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 20:43:32 -0500
Subject: Re: spitz: Real time clock?
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0512091915090.26663@localhost.localdomain>
References: <20051209212850.GE4658@elf.ucw.cz>
	 <1134167947.8092.116.camel@localhost.localdomain>
	 <20051209225312.GF4658@elf.ucw.cz>
	 <Pine.LNX.4.64.0512091915090.26663@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 10 Dec 2005 01:43:16 +0000
Message-Id: <1134178996.8092.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 19:19 -0500, Nicolas Pitre wrote:
> The RTC count is lost on a hard reset.  It survives sleep mode though.
> 
> The fact is that PocketPC/WinCE is not meant to be "rebooted" and the 
> RTC on the PXA was probably designed with that fact.  The normal usage 
> pattern is to go into sleep mode all the time.

Which is the aim of the Zaurus kernel although it doesn't help when
developing...

> > could we do something like storing time on system shutdown and 
> > restoring it on bootup? That way at least time will be monotonic... 
> > Ok, that's userland problem.
> 
> I'd say so.

OpenZaurus/OE did have code to try and do this built into its images.
I'm not sure what its status is at the moment.

> > Is there way to reboot without "really" rebooting? That would help at
> > least in my usage case.
> 
> You should be able to "soft" reboot which will also preserve the RTC 
> count.

Based on past performance, the bootloader (in ROM) will probably
corrupt/reset the RTC but I'd like to be proved wrong.

Russell posted some rough code to linux-arm-kernel recently that allowed
you load a new kernel in a kexec sort of manner and that is probably the
best bet to preserve the RTC. This functionality would be useful on the
Zaurus in general.

Richard

