Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbUK0CEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUK0CEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUKZThV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:37:21 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262380AbUKZTWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:22:05 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Howells <dhowells@redhat.com>, Alexandre Oliva <aoliva@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
In-Reply-To: <20041126141935.GA29035@parcelfarce.linux.theplanet.co.uk>
References: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	 <19865.1101395592@redhat.com>
	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <12983.1101470307@redhat.com>
	 <1101470443.8191.9438.camel@hades.cambridge.redhat.com>
	 <20041126141935.GA29035@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1101479593.8191.9555.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 26 Nov 2004 14:33:14 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-26 at 14:19 +0000, Matthew Wilcox wrote:
> On Fri, Nov 26, 2004 at 12:00:43PM +0000, David Woodhouse wrote:
> > On Fri, 2004-11-26 at 11:58 +0000, David Howells wrote:
> > > How about calling the interface headers "kapi*/" instead of "user*/". In case
> > > you haven't guessed, "kapi" would be short for "kernel-api".
> > 
> > I don't think that change really makes any difference. The nomenclature
> > really isn't _that_ important.
> 
> Indeed.  We could also make this transparent to userspace by using a script
> to copy the user-* headers to /usr/include.  Something like this:

Indeed.

> If we really wanted to get fancy, we could also sed __u32 to uint32_t.
> But that would probably cause more pain, confusion, hurt and bad feeling
> than I'd ever want to be responsible for.

Also true. Let's just use the standard types in the first place and not
screw around with having to fix it up later.

-- 
dwmw2

