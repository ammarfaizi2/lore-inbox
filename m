Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUK2XIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUK2XIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUK2XEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:04:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:7630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261858AbUK2XAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:00:41 -0500
Date: Mon, 29 Nov 2004 15:00:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Nov 2004, Alexandre Oliva wrote:
> 
> I don't see it as obvious at all.  The need for an agreement between
> two parties on an ABI doesn't imply that one party gets to define it
> and the other gets to follow it. 

Sorry, but that's not how it works.

He who writes the code decides what it is. In this case, if the kernel 
does a new extension, it's the kernel that gets to decide what it is. 
Full stop.

If glibc wants to do something new, go wild. The kernel won't care.

And that's really the fundamental issue. The kernel does not care what
user land does. The kernel exports functionality, the kernel does _not_
ask user land to help.

That _does_ make it a one-way street. Sorry.

		Linus
