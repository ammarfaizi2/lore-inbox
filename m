Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUKEXMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUKEXMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUKEXMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:12:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:4261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261251AbUKEXMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:12:43 -0500
Date: Fri, 5 Nov 2004 15:12:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Chris Wedgwood <cw@f00f.org>, Andries Brouwer <aebr@win.tue.nl>,
       Adam Heath <doogie@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change Kconfig entry for RAMFS (Was: Re: support of
 older compilers)
In-Reply-To: <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
Message-ID: <Pine.LNX.4.58.0411051506590.2223@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Nov 2004, Grzegorz Kulewski wrote:
> 
> Probably, but it looks like it does not display in menuconfig and it is 
> set by default. I understand that it is a good example, but it should be 
> disabled by default I think... Or at least it should show in menuconfig. 
> And I do not know why embedded environments want to use ramfs more 
> than tmpfs. Swap is not needed for tmpfs and even if device has no swap it 
> can be oomed because of ramfs too.

Ehh. tmpfs _is_ ramfs in the embedded world. Take a look into 
mm/tiny-shmem.c, notice how it just calls it tmpfs and uses ramfs.

> Will you accept this patch:

Nope. See above. You're breaking a dependency here.

So at the very least you'd need to make the Kconfig understand the 
dependency on ramfs.

Also, don't shout in help-files. Nobody likes shouting. 

		Linus
