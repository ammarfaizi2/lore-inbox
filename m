Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268727AbUIAGKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268727AbUIAGKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUIAGKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:10:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:28613 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268727AbUIAGHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:07:09 -0400
Date: Tue, 31 Aug 2004 23:06:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <41356321.4030307@namesys.com>
Message-ID: <Pine.LNX.4.58.0408312259180.2295@ppc970.osdl.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <41352279.7020307@slaphack.com> <41356321.4030307@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Hans Reiser wrote:
> 
> You are saying, 1-2% simpler and better, no biggie, why work so hard to 
> get it?
> 
> And we are saying, 1-2% simpler and better, times thousands of 
> applications, wow! That's a lot!

But would thousands care? Seriously?

For example, you could make just _one_ program support "openat()", and 
you'd get most of the advantages, with no possibility of _breaking_ any of 
thousands of applications..

I know, you've ignored the "runat" program (which is just a wrapper around
the openat() system call), but it _has_ been mentioned several times in 
this thread. Yes, you'd type a bit more to do

	runat file ls -l

instead of

	ls -l file/

but at least the openat/runat approach also works for directories, which 
does actually make it a lot more _generic_ than the "show in the regular 
filespace" approach. No special cases.

So your comparison isn't valid, because you're ignoring the people who
shout "runat" at you. You've also not ever actually answered about the
problems about directories with attributes.

		Linus
