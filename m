Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbTLIHV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbTLIHV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:21:59 -0500
Received: from verein.lst.de ([212.34.189.10]:25737 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265592AbTLIHVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:21:54 -0500
Date: Tue, 9 Dec 2003 08:21:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nathan Scott <nathans@sgi.com>
Cc: pinotj@club-internet.fr, torvalds@osdl.org, hch@lst.de,
       neilb@cse.unsw.edu.au, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031209072131.GD24599@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Nathan Scott <nathans@sgi.com>, pinotj@club-internet.fr,
	torvalds@osdl.org, neilb@cse.unsw.edu.au, manfred@colorfullife.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <mnet2.1070931455.23402.pinotj@club-internet.fr> <20031209020322.GA1798@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209020322.GA1798@frodo>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 01:03:22PM +1100, Nathan Scott wrote:
> [ Christoph, is this failure expected?  I think you/Steve made
> some changes there to use __GFP_NOFAIL and assume it wont fail?
> (in 2.4 we do memory allocations differently to better handle
> failures, but that code was removed...) ]

It looks like the slab allocator doesn't like __GFP_NOFAIL, we'll
probably have to revert the XFS memory allocation wrappers to the
2.4 versions.

