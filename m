Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWI1UOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWI1UOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWI1UOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:14:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161107AbWI1UOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:14:39 -0400
Date: Thu, 28 Sep 2006 13:14:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org, "Andy Currid" <ACurrid@nvidia.com>
Subject: Re: 2.6.18 hangs during boot on ASUS M2NPV-VM motherboard
Message-Id: <20060928131427.bc3d0ed4.akpm@osdl.org>
In-Reply-To: <451BFDC8.6030308@perkel.com>
References: <451BFDC8.6030308@perkel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 09:52:24 -0700
Marc Perkel <marc@perkel.com> wrote:

> Ok - I don't understand why this bug is being ignored. It appears that this bug applies to many models of motherboards all using the new nVidia chipset for AM2
> socket AMD processors causing these motherboards to lock up on boot. This bug has been reported for a long time and it appears that there seems to be some
> understanding as to what the problem is. Yet no one is fixing it.
> 
> So what's up with that? I know this is free software but I would think that someone would want to put out some effort to make Linux run on the AM2 systems.
> So why is this being ignored?
> 
> I compiled 2.6.18 and setting acpi_skip_timer_override to 0 instead of 1 makes the problem go away. Obviously the logic needs to e a little more complex than
> is but this shouldn't be that hard to resolve.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6975
> 

I think the kernel _should_ be enabling acpi_skip_timer_override by itself,
but isn't doing that for some reason.

Perhaps Andy can help.  He may not even be aware of this problem...
