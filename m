Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVAZQLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVAZQLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVAZQLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:11:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:64685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262344AbVAZQKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:10:37 -0500
Date: Wed, 26 Jan 2005 08:09:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <05012609151500.16556@tabby>
Message-ID: <Pine.LNX.4.58.0501260803360.2362@ppc970.osdl.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
 <41F6A45D.1000804@comcast.net> <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
 <05012609151500.16556@tabby>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jan 2005, Jesse Pollard wrote:
> 
> And covering the possible unknown errors is a good way to add protection.

I heartily agree. The more we can do to make the inevitable bugs be less 
likely to be security problems, the better off we are. Most of that ends 
up being design - trying to avoid design decisions that just drive every 
bug to be an inevitable security problem. 

The biggest part of that is having nice interfaces. If you have good 
interfaces, bugs are less likely to be problematic. For example, the 
"seq_file" interfaces for /proc were written to clean up a lot of common 
mistakes, so that the actual low-level code would be much simpler and not 
have to worry about things like buffer sizes and page boundaries. I don't 
know/remember if it actually fixed any security issues, but I'm confident 
it made them less likely, just by making it _easier_ to write code that 
doesn't have silly bounds problems.

			Linus
