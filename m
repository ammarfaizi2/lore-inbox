Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUK3RKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUK3RKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUK3RJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:09:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:7861 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbUK3Q54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:57:56 -0500
Date: Tue, 30 Nov 2004 08:57:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <9122.1101832431@redhat.com>
Message-ID: <Pine.LNX.4.58.0411300854270.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> 
 <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <1101828924.26071.172.camel@hades.cambridge.redhat.com> <9122.1101832431@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, David Howells wrote:
> 
> If you did user annotations you'd have to solve the problem of applying it to
> #defines and still allowing the constants to be used in assembly. Obviously
> this is not impossible. This is trivial with __KERNEL__ or separation into
> other files.

Annotations don't have to be per-entry. It can be something as simple as 
"this particular file is exposed to user space", or "things from here to 
here are exposed to user space".

And while automation is good, sometimes automation isn't even worth it. I 
suspect it might be good just to _comment_ the structures we expose to 
user space, even if it's never used for anything but as a note to tell 
people not to change it.

		Linus
