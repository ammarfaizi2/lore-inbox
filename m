Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUBQUXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUBQUXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:23:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:20647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266586AbUBQUXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:23:45 -0500
Date: Tue, 17 Feb 2004 12:23:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <20040217201730.GR8858@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402171221120.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
 <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
 <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
 <20040217194414.GP8858@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402171153460.2154@home.osdl.org>
 <20040217201730.GR8858@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> > 	refresh(fd);
> 
> lseek(fd, 0, 0);

Yes. We can make that implicitly refresh, I'm certainly ok with that.

> > I suspect most people don't care that much, but I also suspect that 
> > projects like samba have to have a "anal mode" where they really act like 
> > Windows, even when it's "wrong". People can then choose to say "screw that 
> > idiocy", but by just _having_ a very compatible mode you deflect a lot of 
> > criticism. Regardless of whether people want the anal mode or not in real 
> > life.
> 
> Umm...  Samba deals with Windows clients.  Windows software allegedly being
> ported to Linux is a different story and in that case there's no excuse for
> demanding case-insensitive operations.

"wine". It's not porting, it's emulation.

But yes, I agree, I don't see any other cases where we want it. 

We basically want to support broken clients - whether they be on the other 
side of the network, or the other side of an emulation interface. That is 
the only valid reason to do this crap.

It's a fairly sizeable reason, though. On another front ("World
Domination, Fast!") we'll try to fix the problem another way, but there's 
nothing wrong with fighting on multiple fronts if you have the man-power.

		Linus
