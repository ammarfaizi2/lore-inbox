Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVA0CBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVA0CBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVAZXqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:46:34 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:26271 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261836AbVAZTPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:15:23 -0500
Date: Wed, 26 Jan 2005 20:15:01 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Pollard <jesse@cats-chateau.net>, linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050126191501.GA26920@suse.de>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <41F6A45D.1000804@comcast.net> <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com> <05012609151500.16556@tabby> <Pine.LNX.4.58.0501260803360.2362@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501260803360.2362@ppc970.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 26, Linus Torvalds wrote:

> The biggest part of that is having nice interfaces. If you have good 
> interfaces, bugs are less likely to be problematic. For example, the 
> "seq_file" interfaces for /proc were written to clean up a lot of common 
> mistakes, so that the actual low-level code would be much simpler and not 
> have to worry about things like buffer sizes and page boundaries. I don't 
> know/remember if it actually fixed any security issues, but I'm confident 
> it made them less likely, just by making it _easier_ to write code that 
> doesn't have silly bounds problems.

And, did that nice interface help at all? No, it did not.
Noone made seqfile mandatory in 2.6.
Now we have a few nice big patches to carry around because every driver
author had its own proc implementation. Well done...

