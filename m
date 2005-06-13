Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVFMCW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFMCW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 22:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFMCW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 22:22:56 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:6548 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261318AbVFMCWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 22:22:54 -0400
Date: Sun, 12 Jun 2005 19:22:45 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Willy Tarreau <willy@w.ods.org>
cc: subbie subbie <subbie_subbie@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: optional delay after partition detection at boot time
In-Reply-To: <20050612102726.GA8470@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0506121919310.3896@qynat.qvtvafvgr.pbz>
References: <20050612071213.GG28759@alpha.home.local>
 <20050612101514.81433.qmail@web30707.mail.mud.yahoo.com>
 <20050612102726.GA8470@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Willy Tarreau wrote:

>  - you don't know the root device, so the kernel will
>    panic at boot because it cannot find the root device.
>    In this case, you have the partition list still on
>    the screen as it's among the latest things in the
>    boot order. And if your kernel reboots upon panic,
>    just boot it with panic=30 so get 30 seconds to read
>    the partition table.

I have one machine inmy lab that turns out to need to boot from /dev/sdq1

trust me, that partition info has LONG since scrolled off the screen by 
the time it fails to mount and panics.

I ended up setting up a serial console to capture the boot to figure this 
machine out, but that's a pretty extreme measure to have to go to.

David Lang

P.S. I had to do this after grub failed to mount by label (my guess is 
that grub only looks at so many drives before giving up on finding the 
label) so don't tell me that I should just use labels and then I wouldn't 
have to worry about this type of thing

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
