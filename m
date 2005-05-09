Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVEIT6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVEIT6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVEIT6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:58:43 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:25481 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261415AbVEIT6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:58:40 -0400
Date: Mon, 9 May 2005 15:58:04 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ricky Beam <jfbeam@bluetronic.net>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050509195804.GD2297@csclub.uwaterloo.ca>
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <427FA557.3030400@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427FA557.3030400@tmr.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 02:00:55PM -0400, Bill Davidsen wrote:
> Linus did what was probably right then. I would agree that there is room 
> for something better now. Just to prove it could be done (not that this 
> is the only or best way):

I suspect many architecture's /proc/cpuinfo were not decided by Linus at
all, but by whoever ported linux to that architecture.

>   cpu0 {
>     socket: 0
>     chip-cache: 0
>     num-core: 2
>     per-core-cache: 512k
>     num-siblings: 2
>     sibling-cache: 0
>     family: i86
>     features: sse2 sse3 xxs bvd
>     # stepping and revision info
>   }
>   cpu1 {
>     socket: 1
>     chip-cache: 0
>     num-core: 1
>     pre-core-cache: 512k
>     num-siblings: 2
>     sibling-cache: 64k
>     family: i86
>     features: sse2 sse3 xxs bvd kook2
>     # stepping and revision info
>   }

Where does numa nodes fit into that?

> This is just proof of concept, you can have per-chip, per-core, and 
> per-sibling cache for instance, but I can't believe that anyone would 
> make a chip where the cache per core or per sibling differed, or the 
> instruction set, etc. Depending on where you buy your BS, Intel and AMD 
> will (or won't) make single and dual core chips to fit the same socket.

Have you seen the Cell processor?  Multi core with different instruction
set for the smaller execution cores than the main one.

> The complexity wasn't needed a decade ago, and I'm not sure it is now, 
> other than it being easy to display if people don't complain about 
> breaking the existing format.

But people always like complaining about all changes that they notice.

Len Sorensen
