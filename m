Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbUK3W0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUK3W0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUK3W0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:26:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:30852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262353AbUK3W0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:26:20 -0500
Date: Tue, 30 Nov 2004 14:25:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <8219.1101828816@redhat.com>
 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Alexandre Oliva wrote:

> >  (a) it can't break anything (ie the old location still includes the new 
> >      one, exactly the same way)
> 
> You mean it can't break anything in a kernel build, or it can't break
> anything except for userland apps that abused kernel headers and used
> to get away with that?

It can't break userland either.

> >  (b) there are people who will actually take _advantage_ of that 
> >      particular file (ie "just because I think so" doesn't fly).
> 
> People who currently get to maintain duplicates of these header
> contents will take immediate advantage of these changes, since they
> will no longer have to maintain the duplicates.

Wrong. They'll _still_ have to maintain duplicates, since they can't rely
ont he end-user to have a recent enough kernel.

It's just that they can hopefully start _copying_ their dupliates more 
easily. But if you think the duplication goes away, then I don't want you 
to send me patches, because you don't understand the issues.

At RH you may see only the case where people do a whole-system upgrade. 
Please realize that that is just _one_ schenario, and you should not 
assume that it's the only valid one.

		Linus
