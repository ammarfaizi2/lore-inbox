Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267716AbUBTAWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267637AbUBTAUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:20:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:41953 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267607AbUBTATk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:19:40 -0500
Date: Thu, 19 Feb 2004 16:24:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Tridge <tridge@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org>
 <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org> <20040220000054.GA5590@mail.shareable.org>
 <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Linus Torvalds wrote:
> 
> I agree. It might even be acceptable not as a new flag, but as a 
> modification to existing behaviour. I can't imagine that a file manager is 
> all that interested in seeing the changes it itself does be reported back 
> to it. And I don't really know of any other uses of dnotify.

I take that back. Even a file manager may very well be interested in moves 
that it does itself - most of them have some soft of multi-window view 
capability, and if they use dnotify, they might well be using it to keep 
the different views coherent.

So yes, a new flag would likely be required. 

That said, who actually _uses_ dnotify? The only time dnotify seems to 
come up in discussions is when people complain how badly designed it is, 
and I don't think I've ever heard anybody say that they use it and 
that they liked it ;)

		Linus
