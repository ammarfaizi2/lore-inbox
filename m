Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVHITSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVHITSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVHITSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:18:55 -0400
Received: from smtp.istop.com ([66.11.167.126]:45194 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932187AbVHITSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:18:54 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Wed, 10 Aug 2005 05:19:13 +1000
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
References: <42F57FCA.9040805@yahoo.com.au> <1123577509.30257.173.camel@gaston> <42F87C24.4080000@yahoo.com.au>
In-Reply-To: <42F87C24.4080000@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508100519.14462.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 August 2005 19:49, Nick Piggin wrote:
> Benjamin Herrenschmidt wrote:
> > I have no problem keeping PG_reserved for that, and _ONLY_ for that.
> > (though i'd rather see it renamed then). I'm just afraid by doing so,
> > some drivers will jump in the gap and abuse it again...
>
> Sure it would be renamed (better yet may be a slower page_is_valid()
> that doesn't need to use a flag).

Right!  This is the correct time to wrap all remaining users (that use the 
newly-mandated valid page sense) in an inline or macro.  And this patch set 
should change the flag name, because it quietly changes the rules.  I think 
you need a 3/3 that drops the other shoe.

Regards,

Daniel
