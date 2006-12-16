Return-Path: <linux-kernel-owner+w=401wt.eu-S1161161AbWLPQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWLPQdy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWLPQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:33:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53925 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161161AbWLPQdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:33:53 -0500
Date: Sat, 16 Dec 2006 08:33:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Willy Tarreau <w@1wt.eu>, karderio <karderio@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <200612161128.27721.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0612160828390.3557@woody.osdl.org>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
 <20061216064344.GF24090@1wt.eu> <200612161128.27721.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2006, Rafael J. Wysocki wrote:
> 
> I think the most important problem with the binary-only drivers is that we
> can't support their users _at_ _all_, but some of them expect us to support
> them somehow.

Actually, I do think that we've made our position on that side pretty 
clear.

I think people do by-and-large know that if they load a binary module, 
they simply can't get supported by the kernel developers. 

We make that fairly clear at module loadign time, and I think it's also 
something that people who have read linux-kernel or seen other peoples 
bug-reports are reasonably aware of.

I realize that a lot of people never read the kernel mailing list, but 
they probably don't look at www.kernel.org either - they got their kernel 
from their distribution. The only way they realize is probably by looking 
at where they got whatever binary modules they use.

That said - it should be noted that a lot of the time when you use a 
binary module and have an oops, the oops doesn't necessarily have anything 
to do with your binary module. If I recognize the oops from other reports, 
I certainly won't say "I'm not going to help you, because you used a 
binary module". If I can tell where the problem is, the binary module is a 
non-issue.

It's only when we try to debug things that we say "You've got a binary 
module, you need to reproduce this problem _without_ it, because otherwise 
we can't bother to waste our time on trying to debug something that may be 
due to somebody else".

			Linus
