Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbVLWRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbVLWRme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 12:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVLWRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 12:42:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11196 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030587AbVLWRme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 12:42:34 -0500
Date: Fri, 23 Dec 2005 17:42:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Dave Jones <davej@redhat.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] Add memcpy32 function
Message-ID: <20051223174228.GA29679@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Mackall <mpm@selenic.com>, Dave Jones <davej@redhat.com>,
	Bryan O'Sullivan <bos@pathscale.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <1135301759.4212.76.camel@serpentine.pathscale.com> <20051223024943.GC27537@redhat.com> <20051223171628.GP3356@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223171628.GP3356@waste.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 11:16:28AM -0600, Matt Mackall wrote:
> > io.h is a very generic sounding name for something that just houses
> > a memcpy variant.  What's wrong with calling a spade a spade,
> > and using memcpy32.h ?
> 
> I think it belongs in string.h alongside memcpy, just for tradition's
> sake. I don't think it belongs in a file named io.h, as it probably
> has uses beyond I/O.

Actually I think memcpy32 is not the thing pathscale wants.  They want
memcpy_{to,from}_io32, because memcpy32 wouldn't be allowed to operate
on I/O mapped memory.  I'd say back to the drawingboard.

And to pathscale:  please get your driver __iomem and endianess annotated
before sending out further core patches, I'm pretty sure getting those
things fixed will shed some light on the actual requirements.

