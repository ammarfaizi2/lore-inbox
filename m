Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUIMNvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUIMNvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUIMNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:51:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:53321 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266756AbUIMNvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:51:52 -0400
Date: Mon, 13 Sep 2004 14:51:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Roman Zippel <zippel@linux-m68k.org>
cc: Alex Zarochentsev <zam@namesys.com>, Paul Jackson <pj@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined
    atomic_sub_and_test
In-Reply-To: <Pine.LNX.4.61.0409131522090.981@scrub.home>
Message-ID: <Pine.LNX.4.44.0409131447110.17861-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Roman Zippel wrote:
> On Mon, 13 Sep 2004, Hugh Dickins wrote:
> 
> > But Bill already said he doesn't want it, [...]
> > 
> > -		if (atomic_sub_and_test(bio->bi_vcnt, &fq->nr_submitted))
> > +		if (atomic_sub_return(bio->bi_vcnt, &fq->nr_submitted) == 0)
> 
> And that is more portable how?

It's more portable in that all but s390 already provide it
(and I expect Martin will be happy to add it).

Hugh

