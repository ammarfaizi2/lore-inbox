Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVAZXxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVAZXxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVAZXv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:51:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:12515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbVAZTy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:54:29 -0500
Date: Wed, 26 Jan 2005 11:53:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
cc: Jesse Pollard <jesse@cats-chateau.net>, linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050126193839.GA29324@suse.de>
Message-ID: <Pine.LNX.4.58.0501261151010.2362@ppc970.osdl.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
 <41F6A45D.1000804@comcast.net> <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
 <05012609151500.16556@tabby> <Pine.LNX.4.58.0501260803360.2362@ppc970.osdl.org>
 <20050126191501.GA26920@suse.de> <Pine.LNX.4.58.0501261127280.2362@ppc970.osdl.org>
 <20050126193839.GA29324@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jan 2005, Olaf Hering wrote:
> > 
> > Details, please?
> 
> You did it this way:
> http://linux.bkbits.net:8080/linux-2.5/cset@4115cba3UCrZo9SnkQp0apTO3SghJQ

Oh, that's a separate issue. We want to have multiple levels of security.

We not only try to make sure that there are easy interfaces (but yeah, I 
don't force people to rewrite - I sadly don't have a cadre of slaves at my 
beck and call ;p), but it's also always a good idea to have interfaces 
that are bug-resistant even in the face of people actively not using the 
better interfaces.

So having good interfaces that are harder to have bugs in does _not_ mean 
that we still shouldn't have defensive programming practices anyway. The 
combination of the two means that a bug in one layer hopefully gets caught 
be the other layer.

		Linus
