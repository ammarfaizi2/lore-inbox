Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbUK3UvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUK3UvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbUK3UvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:51:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:54423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262309AbUK3UsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:48:17 -0500
Date: Tue, 30 Nov 2004 12:47:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mariusz Mazur <mmazur@kernel.pl>
cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <200411302128.53583.mmazur@kernel.pl>
Message-ID: <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <1101837135.26071.380.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <200411302128.53583.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Mariusz Mazur wrote:
>
> Facts:
> - current __KERNEL__ stuff is crap;

Fact: you're wrong. I _constantly_ get emails when something breaks. It 
doesn't happen all that often, but it happens.

IOW, I _know_ from personal experience that people depend on it. No ifs, 
buts and maybes about it.

> People in this thread are trying to force you to agree to a specific location 
> where stuff like the above mentioned mtd can go to and to start accepting 
> patches (afaik there were a number of patches trying to introduce that 
> userland dir - all of them ignored). That's (mostly) all.

No. People in this thread have almost uniformly ignored my arguments.

If it's MTD-specific, nobody _cares_ where it goes. Somebody take a 
fricking flying leap of faith here.

If that's all that people want, I hereby proclaim that

	include/asm-xxx/user/xxxx.h
	include/user/xxxx.h

is reserved for user-visible stuff. And now you can send me small and 
localized patches that fix a _particular_ gripe. 

But claiming that __KERNEL__ doesn't work is clearly a bunch of crapola. 
As is the notion that you can somehow do it all. We do it in small pieces.

Happy now?

			Linus
