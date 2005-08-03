Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVHCIYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVHCIYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 04:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVHCIYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 04:24:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34232 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262127AbVHCIYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 04:24:49 -0400
Date: Wed, 3 Aug 2005 03:24:14 -0500
From: Robin Holt <holt@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robin Holt <holt@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-ID: <20050803082414.GB6384@lnx-holt.americas.sgi.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> <42EDDB82.1040900@yahoo.com.au> <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org> <Pine.LNX.4.58.0508011116180.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508011116180.3341@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 11:18:42AM -0700, Linus Torvalds wrote:
> On Mon, 1 Aug 2005, Linus Torvalds wrote:
> > 
> > Ie something like the below (which is totally untested, obviously, but I 
> > think conceptually is a lot more correct, and obviously a lot simpler).
> 
> I've tested it, and thought more about it, and I can't see any fault with
> the approach. In fact, I like it more. So it's checked in now (in a
> further simplified way, since the thing made "lookup_write" always be the
> same as just "write").
> 
> Can somebody who saw the problem in the first place please verify?

Unfortunately, I can not get the user test to run against anything but the
SLES9 SP2 kernel.  I took the commit 4ceb5db9757aaeadcf8fbbf97d76bd42aa4df0d6
and applied that diff to the SUSE kernel.  It does fix the problem the
customer reported.

Thanks,
Robin Holt
