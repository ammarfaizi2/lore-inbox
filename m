Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVDLQmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVDLQmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVDLQlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:41:19 -0400
Received: from nef2.ens.fr ([129.199.96.40]:4361 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S262277AbVDLQf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:35:57 -0400
Date: Tue, 12 Apr 2005 18:35:49 +0200
From: Eric Rannaud <Eric.Rannaud@ens.fr>
To: Pedro Larroy <piotr@larroy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call to atention about using hash functions as content indexers (SCM saga)
Message-ID: <20050412163549.GA7379@clipper.ens.fr>
References: <20050411224021.GA25106@larroy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411224021.GA25106@larroy.com>
User-Agent: Mutt/1.4.2i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 12 Apr 2005 18:35:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simply put, the best known attack of SHA-1 takes 2^69 hash operations.
( http://www.schneier.com/blog/archives/2005/02/sha1_broken.html )
The attack is still only an unpublished paper and has not yet been
implemented. An attack is: you try as hard as you can to find a collision
between two arbitrary messages (i.e. two arbitrary --and nonsensical--
source files).
In the context of git, a better estimation would be the number of hash
operations needed to find a message that has the same hash than a given
fixed message (e.g. mm/memory.c). This is more like 2^100 hash
operations. And if a collision is found, this is very likely using a
message that *doesn't* look like a C source file...

Moreover, no example of collision is known, AFAIK.

In other words: this won't happen.

Best,
   /er.
