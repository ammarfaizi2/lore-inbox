Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268597AbTGLWAd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268617AbTGLWAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:00:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15079 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268597AbTGLWAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:00:31 -0400
Date: Sat, 12 Jul 2003 15:15:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: 2.5 'what to expect'
Message-Id: <20030712151511.107c1f59.akpm@osdl.org>
In-Reply-To: <20030712202352.GA7741@suse.de>
References: <20030711140219.GB16433@suse.de>
	<E19bK8w-0004Ij-00@roos.tartu-labor>
	<20030712202352.GA7741@suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> ..
> 
> Something seems amiss. The deprecated elvtune interface is the old -r/-w/-b command line.
> I was lead to believe a new elvtune appeared which supports an option
> for changing the elevator under 2.5, however a quick google doesn't turn
> up any such patched elvtune, so I'm somewhat puzzled.

No, we planned to do the selection via sysfs rather than ioctl.

>  > Maybe just suggest the sysfs interface at once and not mention elvtune?
> 
> Changing the elevator type per device via sysfs does seem to make sense,
> however /sys/block/<devicename>/queue/iosched/ doesn't yield anything
> that would suggest this is possible (yet).  I think Jens has patches for this?

But it never happened.  There are all sorts of nasties wrt actually making
the switch.  Some related to request queueing, some to sysfs itself.

So yes, we should have runtime selection, and maybe sometime we will, but
the lowness of the return-to-effort ratio means it won't happen soon.


