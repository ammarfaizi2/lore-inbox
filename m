Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTLCUMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTLCUMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:12:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265145AbTLCUL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:11:58 -0500
Date: Wed, 3 Dec 2003 12:11:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Jens Axboe <axboe@suse.de>,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>
Subject: Re: Errors and later panics in 2.6.0-test11.
In-Reply-To: <16334.16859.886609.956641@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.58.0312031209370.7406@home.osdl.org>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org>
 <20031203162045.GA27964@suse.de> <16334.16859.886609.956641@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 4 Dec 2003, Neil Brown wrote:
>
> xfs seems to figure almost as prominantly as raid (the raid1 bug was
> ext3), but maybe it's just that xfs over raid is a popular
> configuration.

I suspect that is the case - people seem to be reporting it with other
filesystems too, and it's more likely just a case of "somebody who feels
he needs to set up raid probably is also likely to feel he needs XFS".

That effect is then quite possibly exaggerated by XFS having different IO
patterns than some other loads (ie it is likely that a lot of RAID
developers are themselves using just ext3 and may thus have hit the
"normal" bugs and fixed them already).

		Linus
