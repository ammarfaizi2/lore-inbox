Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271287AbRHOQlR>; Wed, 15 Aug 2001 12:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271285AbRHOQlI>; Wed, 15 Aug 2001 12:41:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:54300 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271283AbRHOQlB>; Wed, 15 Aug 2001 12:41:01 -0400
Date: Wed, 15 Aug 2001 18:40:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, thockin@sun.com,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
Message-ID: <20010815184058.B12403@athlon.random>
In-Reply-To: <20010815163256.E7382@athlon.random> <Pine.LNX.4.21.0108151725490.1005-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108151725490.1005-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Aug 15, 2001 at 05:30:04PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 05:30:04PM +0100, Hugh Dickins wrote:
> On Wed, 15 Aug 2001, Andrea Arcangeli wrote:
> > 
> > Since 2.2 we have the free_pgtables to release the pagetables under
> > unused pgd slots, that was used to work pretty well last time I checked.
> 
> Funny you mention that: I noticed a while back that actually
> it doesn't work well with i386 PAE - presumably looks for an empty 1GB.

correct, we'd need the equivalent for the pmd too, this applies to the
other 3-level (or more) pagetables archs too.

Andrea
