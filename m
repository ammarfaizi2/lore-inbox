Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263566AbTCUJDz>; Fri, 21 Mar 2003 04:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263567AbTCUJDz>; Fri, 21 Mar 2003 04:03:55 -0500
Received: from angband.namesys.com ([212.16.7.85]:59786 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263566AbTCUJDx>; Fri, 21 Mar 2003 04:03:53 -0500
Date: Fri, 21 Mar 2003 12:14:55 +0300
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs oops [2.5.65]
Message-ID: <20030321121454.A17440@namesys.com>
References: <20030319141048.GA19361@suse.de> <20030320112559.A12732@namesys.com> <20030320132409.GA19042@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320132409.GA19042@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 20, 2003 at 01:24:09PM +0000, Dave Jones wrote:
>  > Hm, very interesting. Thank you.
>  > I've seen this once too, but on kernel patched with lots of unrelated and
>  > possibly memory corrupting stuff.
>  > I will look at it more closely.
>  > BTW, it oopsed not in find. Is your box SMP?
> Same box committed seppuku overnight, this time in a different way.

Hm, am I missing something?
So it died in the morning yesterday, but before that it died again? Or were those
two different nights? ;)

> There's lots of "slab error in cache_alloc_debugcheck_after()"
> warnings. cache reiser_inode_cache memory after object was overwritten

This second oops and first BUG you quoted indicate that internal slab structures
(I think second oops happened in the middle of list_del) were corrupted, not
the guarded data itself.
At least I think so.
Can I take a look at your .config?

Thank you.

Bye,
    Oleg
