Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUBHDuc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUBHDuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:50:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262030AbUBHDu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:50:29 -0500
Date: Sun, 8 Feb 2004 03:50:28 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: walt <wa1ter@myrealbox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [2.6.1] Kernel panic with ppa driver updates
Message-ID: <20040208035028.GD21151@parcelfarce.linux.theplanet.co.uk>
References: <fa.db71fu4.1gju7jo@ifi.uio.no> <fa.n1cha2m.1hhep3a@ifi.uio.no> <4025AE98.3090601@myrealbox.com> <20040208034855.GC21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208034855.GC21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 03:48:55AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Feb 07, 2004 at 07:35:52PM -0800, walt wrote:
> > Only one of the print statements was executed, apparently:
> > 
> > ppa: Version 2.07 (for Linux 2.4.x)
> > dev = dfd67940, dev->cur_cmd = 7232b2df
> > Unable to handle kernel paging request at virtual address 7232b403
> >  printing eip:
> > c027bc25
> > 
> > The remainder of the message was identical to the previous post -- no
> > extra printed messages anywhere.
> 
> Aaaaaargh....  dev = memset(dev, 0, sizeof(dev)); - spot the bug here...

s/dev = // - it's not _that_ bad ;-)
