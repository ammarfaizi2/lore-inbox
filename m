Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269121AbUINCTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269121AbUINCTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUINCRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:17:23 -0400
Received: from holomorphy.com ([207.189.100.168]:58511 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269117AbUINCHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:07:30 -0400
Date: Mon, 13 Sep 2004 19:06:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Zarochentsev <zam@namesys.com>
Cc: Hugh Dickins <hugh@veritas.com>, Roman Zippel <zippel@linux-m68k.org>,
       Paul Jackson <pj@sgi.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined atomic_sub_and_test
Message-ID: <20040914020614.GI9106@holomorphy.com>
References: <Pine.LNX.4.61.0409131608530.877@scrub.home> <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain> <20040913171936.GC2252@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913171936.GC2252@backtop.namesys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 03:58:37PM +0100, Hugh Dickins wrote:
>> sparc and s390 are not the only arches lacking atomic_sub_and_test.
>> Go ahead and send the patches changing all the arches that have it to
>> define __ARCH_HAS_ATOMIC_SUB_AND_TEST, and add asm-generic/atomic.h
>> for those that don't etc; but to me that seems like a waste of time -
>> unless Zam convinces us that Reiser4 will need every last ounce of

On Mon, Sep 13, 2004 at 09:19:36PM +0400, Alex Zarochentsev wrote:
> I do not, Hans will ;-)
> I just like to know what atomic.h common functions would be in 2.6.9+,
> because nowdays the API is not consisent accross the arches. 
> atomic_sub_return() is OK.

sparc32 is very legacy; in a quick IRC poll of sparc32 users there was
approximately zero interest in new filesystems and most users used nfs
and/or ext[23]. One should note that as these cpus are very slow and
the systems have very little RAM compared to modern ones, kernel memory
footprint and the cpu complexity of fs operations for small fs's is of
high importance. I really don't expect reiser4 to ever be runtime
tested on sparc32. UltraSPARC is another matter entirely.


-- wli
