Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUIMR2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUIMR2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUIMR2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:28:00 -0400
Received: from clusterfw.beelinegprs.com ([217.118.66.232]:4288 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S268580AbUIMR1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:27:37 -0400
Date: Mon, 13 Sep 2004 21:19:36 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Paul Jackson <pj@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined atomic_sub_and_test
Message-ID: <20040913171936.GC2252@backtop.namesys.com>
References: <Pine.LNX.4.61.0409131608530.877@scrub.home> <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 03:58:37PM +0100, Hugh Dickins wrote:
> On Mon, 13 Sep 2004, Roman Zippel wrote:
> > 
> > So why not add the missing atomic_sub_and_test() (using simply 
> > atomic_sub_return)?
> 
> sparc and s390 are not the only arches lacking atomic_sub_and_test.
> 
> Go ahead and send the patches changing all the arches that have it to
> define __ARCH_HAS_ATOMIC_SUB_AND_TEST, and add asm-generic/atomic.h
> for those that don't etc; but to me that seems like a waste of time -
> unless Zam convinces us that Reiser4 will need every last ounce of

I do not, Hans will ;-)

I just like to know what atomic.h common functions would be in 2.6.9+, because
nowdays the API is not consisent accross the arches. 

atomic_sub_return() is OK.

> cpu on this particular line of code.
> 
> Hugh

-- 
Alex.
