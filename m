Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbUK3SWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbUK3SWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUK3SWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:22:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:53645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262234AbUK3SWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:22:16 -0500
Date: Tue, 30 Nov 2004 10:21:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <1101837135.26071.380.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>  <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
  <1101406661.8191.9390.camel@hades.cambridge.redhat.com> 
 <20041127032403.GB10536@kroah.com>  <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> 
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> 
 <1101828924.26071.172.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> 
 <1101832116.26071.236.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
 <1101837135.26071.380.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, David Woodhouse wrote:
> 
> The idea in the proposal which David posted, which seemed perfectly
> specific enough to me, was to move all the user-visible parts to
> separate header files in a separate directory.

You call _that_ specific?

Hell no. You need to do it without breaking existing uses, as noted 
earlier, and it's not specific at all. "all user visible parts" is a big 
undertaking, if you can't make it smaller than that, then forget about it.

Basic rule in kernel engineering: you don't just rewrite the world. You do
it in incremental independent steps.

Any mtd-specific rewrite is obviously a go. 

		Linus
