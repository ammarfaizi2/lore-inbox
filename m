Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTESOeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 10:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTESOeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 10:34:20 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:59810 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262473AbTESOeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 10:34:19 -0400
Date: Mon, 19 May 2003 16:47:17 +0200
From: bert hubert <ahu@ds9a.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
Message-ID: <20030519144716.GA20193@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>
References: <20030519124910.C8868@infradead.org> <Pine.LNX.4.44.0305191351570.9877-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305191351570.9877-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 02:33:01PM +0200, Ingo Molnar wrote:
>  - start the phasing out of FUTEX_FD. This i believe is quite unclean and
>    unrobust, because it attaches a new concept (futexes) to a very old
>    (polling) concept. We want futex support in kernel-AIO, not in the
>    polling APIs. AFAIK only NGPT uses FUTEX_FD.

I for one would want the ability to select, poll and epoll on a futex while
also being notified of availability of data on sockets. I see no alternative
even, except for messing with signals or running select with a small
timeout, introducing needless latency.

It may be weird, but it does work in practice. 'Unrobust' would be a problem
but I fail to see how this is unclean.

Thanks.


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
