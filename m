Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTIHS0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTIHS0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:26:31 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:47503 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263463AbTIHS0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:26:31 -0400
Date: Mon, 8 Sep 2003 19:26:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
Message-ID: <20030908182603.GE27097@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain> <20030908102309.0AC4E2C013@lists.samba.org> <20030908175140.GC27097@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908175140.GC27097@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> It is probably worth adding a jhash_3longs() to jhash.h, which does
> one call to __hash_mix() on 32-bit, two calls on 64-bit, and avoids
> the loop in both cases.

Bob Jenkins has a 64-bit version of the mixing function, which we
aren't using.  It would be better to use a single iteration of that in
jhash_3longs().

See:
	http://burtleburtle.net/bob/hash/evahash.html#hash64

-- Jamie
