Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUBQVWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266632AbUBQVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:20:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:61132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266603AbUBQVRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:17:36 -0500
Date: Tue, 17 Feb 2004 13:17:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
cc: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <200402172208.25398.robin.rosenberg.lists@dewire.com>
Message-ID: <Pine.LNX.4.58.0402171314320.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
 <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
 <200402172208.25398.robin.rosenberg.lists@dewire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Robin Rosenberg wrote:
>
> On Tuesday 17 February 2004 17.57, Linus Torvalds wrote:
> [case-insanesititvity proposal ///]
> > See where I'm going? Would this be acceptable to you? Are there any samba 
> > people who are knowledgeable about the VFS-layer and have the time/energy 
> > to try something like this?
> 
> So the same guy that strongly insist that a file is a string of bytes and nothing else,
> now thinks it is sane to even think of "case" of a byte. That's impossible unless you
> actually DO believe its a bunch of characters.  What is it?

Which part of my argumen don't you understand?

The kernel proper thinks it's just a stream of bytes, and all the existing 
interfaces do likewise.

But we'd have a kernel helper module to let samba do what it already does 
now, except help it do so more efficiently?

The fact that _I_ think pathnames are just a nice stream of bytes sadly 
doesn't make Windows clients do the same. Some day when I'm King Of The 
World, and I can outlaw windows clients, we'll finally get rid of the 
braindamage, but until then I'm pragmatic enough to say "let's help out 
the poor samba people who have to deal with the crap day in and day out".

What's your problem with that?

		Linus
