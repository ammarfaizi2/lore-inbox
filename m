Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263412AbTCNRY7>; Fri, 14 Mar 2003 12:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbTCNRY7>; Fri, 14 Mar 2003 12:24:59 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:13150 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263412AbTCNRY5>;
	Fri, 14 Mar 2003 12:24:57 -0500
Date: Fri, 14 Mar 2003 18:35:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
Message-ID: <20030314173550.GG1375@dualathlon.random>
References: <20030314090825.GB1375@dualathlon.random> <Pine.LNX.4.44.0303140852220.27094-100000@dhcp64-226.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303140852220.27094-100000@dhcp64-226.boston.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 08:53:09AM -0500, Rik van Riel wrote:
> On Fri, 14 Mar 2003, Andrea Arcangeli wrote:
> 
> > Only in 2.4.21pre4aa3: 9900_aio-17.gz
> > Only in 2.4.21pre5aa1: 9900_aio-18.gz
> > 
> > 	Cleaned up the whole asm/kmap_types.h mess, moved
> > 	kmap_types.h into linux/, this must be visible
> > 	for aio and it has to be the same for all archs so it doesn't belong to
> > 	asm/.
> 
> Maybe I'm dense, maybe it's early on a friday morning, maybe
> even both ... but I don't understand why architectures without
> highmem should have kmap_types.h

it's the aio code that does some kmap_atomic in the common code, and the
kmap_atomic pretends to get a km_type parameter. Of course the km_type
parameter is optimized away at compile time if highmem is disabled, but
this allows to use kmap_atomic in common code.

Andrea
