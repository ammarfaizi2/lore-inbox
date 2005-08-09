Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVHIV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVHIV13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVHIV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:27:28 -0400
Received: from smtp.istop.com ([66.11.167.126]:35987 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S964984AbVHIV11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:27:27 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Wed, 10 Aug 2005 07:27:46 +1000
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
References: <42F57FCA.9040805@yahoo.com.au> <1123598952.30257.213.camel@gaston> <Pine.LNX.4.61.0508091621220.14003@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508091621220.14003@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508100727.47698.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 August 2005 01:36, Hugh Dickins wrote:
> On Tue, 9 Aug 2005, Benjamin Herrenschmidt wrote:
> >  - We already have a refcount
> >  - We have a field where putting a flag isn't that much of a problem
> >  - It can be difficult to get page refcounting right when dealing with
> >    such things, really.
>
> Probably easier to get the page refcounting right with these than with
> most.  Getting refcounting wrong is always bad.

He seems to be arguing for a new debug option.

> > In that case, we basically have an _easy_ way to trigger a useful BUG()
> > in the page free path when it's a page that should never be returned to
> > the pool.
>
> As bad_page already does on various other flags (though it clears those,
> whereas this one you'd prefer not to clear).   Hmm, okay, though I'm not
> sure it's worth its own page flag if they're in short supply.

Nineteen out of 32 officially spoken for so far, with some out of tree patches 
regarding the remainder with desirous eyes no doubt.  I think that qualifies 
as short supply.  But it is not just that, it is the extra cost of 
understanding and auditing the features implied by the flags, particularly 
bogus features.

Regards,

Daniel
