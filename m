Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVFLMfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVFLMfc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 08:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVFLMfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 08:35:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30988 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262450AbVFLMfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 08:35:25 -0400
Date: Sun, 12 Jun 2005 14:35:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31 7/9] gcc4: fix const function warnings
Message-ID: <20050612123508.GL28759@alpha.home.local>
References: <200506121121.j5CBLGd4019750@harpo.it.uu.se> <20050612115019.GJ28759@alpha.home.local> <42AC273B.60808@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AC273B.60808@yahoo.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 10:14:51PM +1000, Nick Piggin wrote:
(...) 
> const functions are those that don't have side effects and depend
> only on their argument list. So such functions can be CSE'ed or
> reordered.
> 
> If it makes sense to use on any inline function, then I think it
> makes sense if they're only using asm. Actually I would have thought
> it would *only* help inline functions using asm, because gcc may
> not know that such asm is 'const'.
> 
> But that's not to say they should be removed just because they
> can't help gcc - it may be instructive to the programmer, or more
> robust when making modifications to the code (eg. uninlining).

Thanks for the clarification, Nick.

Willy

