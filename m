Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUJOOYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUJOOYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJOOYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:24:54 -0400
Received: from zero.aec.at ([193.170.194.10]:33296 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267850AbUJOOXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:23:00 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: KendallB@scitechsoft.com, linux-kernel@vger.kernel.org
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
References: <2Pkf0-42m-11@gated-at.bofh.it> <2PncW-6j9-19@gated-at.bofh.it>
	<2PncW-6j9-21@gated-at.bofh.it> <20030401205016$5cc4@gated-at.bofh.it>
	<20030401205016$63f7@gated-at.bofh.it>
	<20030424075011$4028@gated-at.bofh.it> <1ewKr-2Kh-41@gated-at.bofh.it>
	<CebL.O9.13@gated-at.bofh.it> <1bucs-57R-33@gated-at.bofh.it>
	<2PncW-6j9-23@gated-at.bofh.it> <20030423094012$4166@gated-at.bofh.it>
	<2PncW-6j9-17@gated-at.bofh.it> <2PAMY-7Ir-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 15 Oct 2004 16:22:56 +0200
In-Reply-To: <2PAMY-7Ir-21@gated-at.bofh.it> (Alan Cox's message of "Fri, 15
 Oct 2004 16:00:20 +0200")
Message-ID: <m3655cjc1r.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Iau, 2004-10-14 at 21:46, Kendall Bennett wrote:
>> a way to spawn a user mode process that early in the boot sequence (it 
>> would have to come from the initrd image I expect) then the only option 
>> is to compile it into the kernel.
>
> There is exactly that in 2.6 - the hotplug interfaces allow the kernel
> to fire off userspace programs. Jon Smirl (who you should definitely
> talk to about this stuff) has been hammering out a design for moving
> almost all the mode switching into user space for kernel video.

The problem is that this would imply that the console would only
work after user space is running. Even with initrd that's quite late.

The only way I see to make that fly would be a very good early 
console implementation, otherwise tracking down any problems will
be hell (how do you display "panic no rootfs found" without console?) 
And writing a good early console implementation would have all the
same problems as the current one.

So I can see Kendall's point.

-Andi

