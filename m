Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVHXHfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVHXHfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVHXHfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:35:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45274 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750714AbVHXHfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:35:41 -0400
Date: Wed, 24 Aug 2005 08:35:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@www.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (28/43) alpha xchg fix
Message-ID: <20050824073537.GC24513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@www.linux.org.uk>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1E7gbr-0007DA-1I@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E7gbr-0007DA-1I@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:47:07PM +0100, Al Viro wrote:
> alpha xchg has to be a macro - alpha disables always_inline and if that
> puppy does not get inlined, we immediately blow up on undefined reference.
> Happens even on gcc3; with gcc4 that happens a _lot_.

I think you should rather fix alpha to not disable always_inline.  Having
one architecture behaving very different from the others is a rather bad
idea.

