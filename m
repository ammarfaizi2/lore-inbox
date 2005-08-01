Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVHASXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVHASXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVHASVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:21:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261700AbVHASTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:19:04 -0400
Date: Mon, 1 Aug 2005 11:18:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508011116180.3341@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Aug 2005, Linus Torvalds wrote:
> 
> Ie something like the below (which is totally untested, obviously, but I 
> think conceptually is a lot more correct, and obviously a lot simpler).

I've tested it, and thought more about it, and I can't see any fault with
the approach. In fact, I like it more. So it's checked in now (in a
further simplified way, since the thing made "lookup_write" always be the
same as just "write").

Can somebody who saw the problem in the first place please verify?

		Linus
