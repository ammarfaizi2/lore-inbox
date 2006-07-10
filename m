Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWGJFyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWGJFyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 01:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWGJFyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 01:54:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49894 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751348AbWGJFyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 01:54:06 -0400
Date: Mon, 10 Jul 2006 15:53:21 +1000
From: Nathan Scott <nathans@sgi.com>
To: Milton Miller <miltonm@bga.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: readahead support
Message-ID: <20060710155321.B1675237@wobbly.melbourne.sgi.com>
References: <200607100546.k6A5k3qU049783@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200607100546.k6A5k3qU049783@sullivan.realtime.net>; from miltonm@bga.com on Mon, Jul 10, 2006 at 12:46:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 12:46:03AM -0500, Milton Miller wrote:
> > +#define trace_ahead_bit(rw)	\
> > +	(((rw) & (1 << BIO_RW_AHEAD)) << (BIO_RW_AHEAD - 0))
> ...
> I think the shift should be << (2 - BIO_RW_AHEAD).

Quite possibly.  As long as it ends up in slot 4 in that array still..
which it will.

cheers.

-- 
Nathan
