Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUJOMU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUJOMU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJOMUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:20:25 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:46553 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S267700AbUJOMUY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:20:24 -0400
X-Envelope-From: kraxel@bytesex.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
References: <416E6ADC.3007.294DF20D@localhost>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 15 Oct 2004 14:05:50 +0200
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
Message-ID: <87d5zkqj8h.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kendall Bennett" <KendallB@scitechsoft.com> writes:

> Note that the SNAPBoot code uses the x86emu BIOS emulator project as the 
> core CPU emulation technology, and project we have been actively involved 
> with for many years since the licensing on the project was changed to 
> MIT/BSD style licensing and incorporated into the XFree86 project.

> So what we would like to find out is how much interest there might be in 
> both an updated VESA framebuffer console driver as well as the code for 
> the Video card BOOT process being contributed to the maintstream kernel. 

It certainly would be nice to have that.  Not nessesarely in the
kernel through, people tend not to like such complex stuff like cpu
emulation in the kernel for good reasons.  The kernel can run
userspace apps (modprobe, hotplug), that mechanism could be used to
invoke a userspace tool which does the boot / mode switching.  Having
it in userspace likely also makes it easier to share code with X11.

Have you talked to the powermanagement guys btw.?  One of the major
issues with suspend-to-ram is to get the graphics card back online,
and SNAPBoot might help to fix this too.  I'm not sure a userspace
solution would work for *that* through.

  Gerd

-- 
return -ENOSIG;
