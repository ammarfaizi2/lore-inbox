Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267604AbUBRPyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUBRPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:54:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:51869 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267604AbUBRPyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:54:31 -0500
Date: Wed, 18 Feb 2004 07:54:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
In-Reply-To: <20040218095915.GC28599@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402180749120.2686@home.osdl.org>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
 <20040216062152.GB5192@pegasys.ws> <20040216155534.GA17323@mail.shareable.org>
 <20040217064755.GC9466@pegasys.ws> <20040217213714.GI24311@mail.shareable.org>
 <Pine.LNX.4.58.0402171400540.2154@home.osdl.org> <20040218095915.GC28599@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Jamie Lokier wrote:
> 
> It's irritating that logging in from the wrong kind of terminal
> doesn't just provide the right "user experience" for the command line
> automatically.

Well, you should be able to just start something "screen"-equivalent 
directly by just making it your default shell or have a fix to "login". 

The thing is, the kernel tty layer is happy to work with utf-8 (well,
modulo the issues of erase etc - and Andries posted that patch already,
and there are probably others like it) if your terminal supports it, but
if your terminal doesn't have CJK supprt internally, then you need 
something to do the multi-character translations anyway in order to be 
able to input them in the first place.

And that is _not_ an stty option.

Btw, from the screen man-page it appears that screen is not able to do 
that either. You can put screen into utf-8 mode, but it sounds like it 
just means that it passes UTF-8 through, not that it does any translation 
from "latin1 vt100 to utf-8".

I think there are a few editors that actually do ("mined" looks like it 
should do it).

		Linus
