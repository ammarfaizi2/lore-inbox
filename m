Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVIUCTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVIUCTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 22:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIUCTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 22:19:20 -0400
Received: from mgate02.necel.com ([203.180.232.82]:10488 "EHLO
	mgate02.necel.com") by vger.kernel.org with ESMTP id S1750809AbVIUCTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 22:19:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	<1127061146.6939.6.camel@phantasy>
	<20050918165219.GA595@alpha.home.local>
	<20050918171845.GL19626@ftp.linux.org.uk>
	<Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Wed, 21 Sep 2005 11:18:27 +0900
In-Reply-To: <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org> (Linus Torvalds's message of "Sun, 18 Sep 2005 10:31:36 -0700 (PDT)")
Message-Id: <buod5n3go3w.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> Actually, some day that migth be a good idea, but at least historically, 
> gcc has really really messed that kind of code up.
>
> Last I looked, depending on what the initializer was, gcc would create a 
> temporary struct on the stack first, and then do a "memcpy()" of the 
> result.

A little test shows:

gcc-3.4.4 seems to still do what you describe.

gcc-4.0.1 seems to  it the "right" way (writing each field directly to
the destination structure).

Someday...

-miles
-- 
Yo mama's so fat when she gets on an elevator it HAS to go down.
