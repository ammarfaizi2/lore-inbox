Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTLCQvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLCQvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:51:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:58571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265079AbTLCQvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:51:36 -0500
Date: Wed, 3 Dec 2003 08:51:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
In-Reply-To: <20031203162045.GA27964@suse.de>
Message-ID: <Pine.LNX.4.58.0312030823010.5258@home.osdl.org>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org>
 <20031203162045.GA27964@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Jens Axboe wrote:
> >
> > Interesting. Another RAID 0 problem report..
>
> Hmm did _all_ reports include raid-0, or just "some" raid? I'm looking
> at the bio_pair stuff which raid-0 is the only user of, something looks
> fishy there.

The ones I've seen seem to be raid-0, but Nathan (nathans@sgi.com)
reported problems in RAID-5 under load. I didn't decode the full oops on
that one, but it really looked like a stale "bi" bio that trapped on the
PAGE_ALLOC debug code.

So we may have more than one problem.

		Linus
