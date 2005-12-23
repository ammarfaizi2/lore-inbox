Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbVLWSQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbVLWSQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 13:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbVLWSQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 13:16:49 -0500
Received: from waste.org ([64.81.244.121]:35534 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030596AbVLWSQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 13:16:48 -0500
Date: Fri, 23 Dec 2005 12:14:53 -0600
From: Matt Mackall <mpm@selenic.com>
To: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] Add memcpy32 function
Message-ID: <20051223181453.GS3356@waste.org>
References: <1135301759.4212.76.camel@serpentine.pathscale.com> <20051223024943.GC27537@redhat.com> <20051223171628.GP3356@waste.org> <20051223174228.GA29679@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223174228.GA29679@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 05:42:28PM +0000, Christoph Hellwig wrote:
> On Fri, Dec 23, 2005 at 11:16:28AM -0600, Matt Mackall wrote:
> > > io.h is a very generic sounding name for something that just houses
> > > a memcpy variant.  What's wrong with calling a spade a spade,
> > > and using memcpy32.h ?
> > 
> > I think it belongs in string.h alongside memcpy, just for tradition's
> > sake. I don't think it belongs in a file named io.h, as it probably
> > has uses beyond I/O.
> 
> Actually I think memcpy32 is not the thing pathscale wants.  They want
> memcpy_{to,from}_io32, because memcpy32 wouldn't be allowed to operate
> on I/O mapped memory.  I'd say back to the drawingboard.

Ahh, excellent point. We probably want something closer to
iowrite32_rep and have it live in iomap.h. Perhaps iowrite32_copy?

-- 
Mathematics is the supreme nostalgia of our time.
