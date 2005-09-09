Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVIIDxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVIIDxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVIIDxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:53:06 -0400
Received: from mail.suse.de ([195.135.220.2]:40415 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964958AbVIIDxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:53:05 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com
Subject: Re: [PATCH] re-export genapic on i386
References: <4320793602000078000244D9@emea1-mh.id2.novell.com>
	<20050908155011.GA12359@infradead.org>
From: Andi Kleen <ak@suse.de>
Date: 09 Sep 2005 05:53:04 +0200
In-Reply-To: <20050908155011.GA12359@infradead.org>
Message-ID: <p73u0gu3nj3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Sep 08, 2005 at 05:47:34PM +0200, Jan Beulich wrote:
> > (Note: Patch also attached because the inline version is certain to get
> > line wrapped.)
> > 
> > A change not too long ago made i386's genapic symbol no longer be
> > exported,
> > and thus certain low-level functions no longer be usable. Since
> > close-to-
> > the-hardware code may still be modular, this rectifies the situation.
> 
> Again, what code would use it, why and why can't it use a proper accessor.
> And a shitty thousands of lines out ot tree debugger ported from Novell's
> legacy OS is not the answer, btw.

Why not?  Most debuggers will always be out of tree for political
reasons, and because of that the normal "every hook must 
have an in tree user" rule cannot be strictly applied to them.

It's also not reasonable to ask these people to always 
carry big patchkits around - after all they just want
to debug core kernel code, and it is very ugly to apply
a big patchkit just for that.

So as long as the hooks for external modular debuggers 
are reasonable and _GPL I think they should be merged.

-Andi
