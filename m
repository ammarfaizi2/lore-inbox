Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbTIJTFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbTIJTE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:04:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265530AbTIJTDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:03:06 -0400
Date: Wed, 10 Sep 2003 20:03:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Stephen Hemminger <shemminger@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix type mismatch in jffs.
Message-ID: <20030910190303.GP454@parcelfarce.linux.theplanet.co.uk>
References: <20030910181847.GO454@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0309101152060.25211-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309101152060.25211-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:54:13AM -0700, Linus Torvalds wrote:
> 
> On Wed, 10 Sep 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > JFFS is host-endian.  If you want to make it swing both ways - feel free,
> 
> Please don't.
> 
> Dual-endianness is _evil_.
> 
> Admittedly host-endian is stupid too, but it's less stupid than being 
> dual.
> 
> The only sane thing to do is fixed-endianness. I'm sure the m68k people 
> remember being forced to fix their ext2 partitions back in the bad old 
> days. It's painful once, but after that, fixed-endian is a lot more 
> efficient and much simpler to handle.

	a) you've snipped the critical part ;-)
	b) nobody sane uses that beast these days
	c) if somebody wants to grow a private patch - it's their time,
after all...

Seriously, though, by now fs/jffs/* has only one real use - extracting
data from old filesystem.  IIRC, there was even a talk about having it go
the way of ext and xiafs.  He's dead, Jim...
