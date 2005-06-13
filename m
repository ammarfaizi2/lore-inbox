Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVFMERP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVFMERP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 00:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVFMERP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 00:17:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45068 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261345AbVFMERK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 00:17:10 -0400
Date: Mon, 13 Jun 2005 06:17:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: David Lang <dlang@digitalinsight.com>
Cc: subbie subbie <subbie_subbie@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: optional delay after partition detection at boot time
Message-ID: <20050613041705.GD8907@alpha.home.local>
References: <20050612071213.GG28759@alpha.home.local> <20050612101514.81433.qmail@web30707.mail.mud.yahoo.com> <20050612102726.GA8470@alpha.home.local> <Pine.LNX.4.62.0506121919310.3896@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506121919310.3896@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 07:22:45PM -0700, David Lang wrote:
> On Sun, 12 Jun 2005, Willy Tarreau wrote:
> 
> > - you don't know the root device, so the kernel will
> >   panic at boot because it cannot find the root device.
> >   In this case, you have the partition list still on
> >   the screen as it's among the latest things in the
> >   boot order. And if your kernel reboots upon panic,
> >   just boot it with panic=30 so get 30 seconds to read
> >   the partition table.
> 
> I have one machine inmy lab that turns out to need to boot from /dev/sdq1
> 
> trust me, that partition info has LONG since scrolled off the screen by 
> the time it fails to mount and panics.

Interesting. How many total partitions do you have ? I ask this because
David Alan Gilbert proposed a patch to dump the partition list on the
screen upon panic. Perhaps it's larger than the screen in you case ? If
you have more than 25 partitions, to you think they can fit with 2 or 3
columns ?

> I ended up setting up a serial console to capture the boot to figure this 
> machine out, but that's a pretty extreme measure to have to go to.
> 
> David Lang
> 
> P.S. I had to do this after grub failed to mount by label (my guess is 
> that grub only looks at so many drives before giving up on finding the 
> label) so don't tell me that I should just use labels and then I wouldn't 
> have to worry about this type of thing

I wouldn't tell you that, I *hate* labels. It causes lots of problems
when you simply move some disks between machines.

Regards,
Willy

